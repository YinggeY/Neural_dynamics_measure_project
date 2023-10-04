
% Function for creating csv of LZ for each subject
% The final output should be two csv files for subject in either as or aw
% One is drowsy and the other is alert, with the LZ Values for 6 regions
% So a total of 4 csv files per subject
% No need for bash

% Note that LZ has already be averaged based on number of electrodes in
% each region

% For anat_wake
function csv_aw()

path1 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts';
path2 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/label';

addpath(path1);
addpath(path2);


% Fix the readtable problem for the "state_noNREMS" colummn
opts = detectImportOptions('subs_labels.csv');
opts.VariableTypes(11) = {'string'};% Problem happens in the 11th column
sublabel = readtable('subs_labels.csv',opts);


for ID = 7:32
    % Get subject string first
     if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
     end

     % Extract indices in CSV based on conditions
     idxsub = strcmp(sublabel.subject,subj);
     subtable = sublabel(idxsub,:); % Get subject table
     idxnum = ~isnan(subtable.clean_EEG_epoch_number); % Filter for subject and clean epochs
     subnumtable = subtable(idxnum,:);
     idx_aw = strcmp(subnumtable.dataset,'anat_wake'); 
     sub_aw = subnumtable(idx_aw,:); % subject in anat_wake (clean)

     % We are only interested in alert of drowsy states
     al_aw = strcmp(sub_aw.state_noNREMS,'alert');
     dr_aw = strcmp(sub_aw.state_noNREMS,'drowsy');

     alert_aw = sub_aw(al_aw,:);
     drowsy_aw = sub_aw(dr_aw,:);

     % Store directory in anat_wake and anat_sleep subject folders
     awdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj);
    
    % Add path to the computed LZ data versus epochs
    addpath(awdir);
    
    data = strcat('EEG_Passive_anat_wake_epoch_0_4_clean_',subj,'.mat');
    load(data,'LZ_HGSN');
    


    % E.g. alert_as is expected to be a nX1 table containing
    % clean_EEG_epochs, which are indices to extract averaged LZ value from
    % mat file in each subject folder. Therefore, we need to loop through the row size of alert_as to assign
    % LZ values
    aaw = size(alert_aw,1); % aaw: alert & anat_wake
    daw = size(drowsy_aw,1); % daw: drowsy & anat_wake

    % Add six new columns to each csv for storing corresponding LZ values
    zeroaaw = zeros(aaw,1);
    alert_aw = addvars(alert_aw,zeroaaw,zeroaaw,zeroaaw,zeroaaw,zeroaaw,zeroaaw,'NewVariableNames',{'FP','F','Cent','Anpos','Parie','Occi'});
    zerodaw = zeros(daw,1);
    drowsy_aw = addvars(drowsy_aw,zerodaw,zerodaw,zerodaw,zerodaw,zerodaw,zerodaw,'NewVariableNames',{'FP','F','Cent','Anpos','Parie','Occi'});
    
    % Note, the above and the below sections can be improved by using
    % property.labels = {} and loop through

    % alert in anat_wake
    for j = 1:aaw
        epochidx = alert_aw.clean_EEG_epoch_number(j) + 1;
        alert_aw.FP(j) = LZ_HGSN(1, epochidx);
        alert_aw.F(j) = LZ_HGSN(2, epochidx);
        alert_aw.Cent(j) = LZ_HGSN(3, epochidx);
        alert_aw.Anpos(j) = LZ_HGSN(4, epochidx);
        alert_aw.Parie(j) = LZ_HGSN(5, epochidx);
        alert_aw.Occi(j) = LZ_HGSN(6, epochidx);
    end

   % drowsy in anat_wake
   for j = 1:daw
        epochidx = drowsy_aw.clean_EEG_epoch_number(j) + 1;
        drowsy_aw.FP(j) = LZ_HGSN(1, epochidx);
        drowsy_aw.F(j) = LZ_HGSN(2, epochidx);
        drowsy_aw.Cent(j) = LZ_HGSN(3, epochidx);
        drowsy_aw.Anpos(j) = LZ_HGSN(4, epochidx);
        drowsy_aw.Parie(j) = LZ_HGSN(5, epochidx);
        drowsy_aw.Occi(j) = LZ_HGSN(6, epochidx);
   end

   % The final step is to store the alert and drowsy csvs into anat_sleep
   % and anat_wake
   save_aaw = strcat(awdir,'/',subj,'_aw_alert.csv');
   save_daw = strcat(awdir,'/',subj,'_aw_drowsy.csv');
   writetable(alert_aw,save_aaw);
   writetable(drowsy_aw,save_daw);



end






end
