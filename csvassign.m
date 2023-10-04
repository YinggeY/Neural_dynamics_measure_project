% Function for creating csv of LZ for each subject
% The final output should be two csv files for subject in either as or aw
% One is drowsy and the other is alert, with the LZ Values for 6 regions
% So a total of 4 csv files per subject

% Note that LZ has already be averaged based on number of electrodes in
% each region

% It turns out there will be problems for loading and renameing LZ_HGSN
% So instead of using this I break this into two scrips: csv_as, csv_aw
function csvassign()

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
     idxsub = strcmp(sublabel.subject,subj) & ~isnan(sublabel.clean_EEG_epoch_number); % Filter for subject and clean epochs
     subtable = sublabel(idxsub,:); % Get subject table
     idx_as = strcmp(subtable.dataset,'anat_sleep'); % Filter for dataset
     idx_aw = strcmp(subtable.dataset,'anat_wake'); 
     sub_as = subtable(idx_as,:); % anat_sleep & clean & subject table
     sub_aw = subtable(idx_aw,:); % subject in anat_wake (clean)

     % We are only interested in alert of drowsy states
     al_as = strcmp(sub_as.state_noNREMS,'alert'); % Filter for state condition
     dr_as = strcmp(sub_as.state_noNREMS,'drowsy'); 
     al_aw = strcmp(sub_aw.state_noNREMS,'alert');
     dr_aw = strcmp(sub_aw.state_noNREMS,'drowsy');

     alert_as = sub_as(al_as,:);% clean & alert slots for subj in anat_sleep dataset
     drowsy_as = sub_as(dr_as,:); % drowsy state subject in clean anat_sleep
     alert_aw = sub_aw(al_aw,:);
     drowsy_aw = sub_aw(dr_aw,:);

     % Store directory in anat_wake and anat_sleep subject folders
     asdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/',subj);
     awdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj);
    
    %Add path to the computed LZ data versus epochs
    addpath(asdir);
    addpath(awdir);
    
    dataas = strcat('EEG_Passive_anat_sleep_epoch_0_4_clean_',subj,'.mat');
    dataaw = strcat('EEG_Passive_anat_wake_epoch_0_4_clean_',subj,'.mat');
    load(dataas,'LZ_HGSN');
    assignin('base','LZ_HGSN_as',LZ_HGSN);
    load(dataaw,'LZ_HGSN');
    assignin('base','LZ_HGSN_aw',LZ_HGSN);


    % E.g. alert_as is expected to be a nX1 table containing
    % clean_EEG_epochs, which are indices to extract averaged LZ value from
    % mat file in each subject folder. Therefore, we need to loop through the row size of alert_as to assign
    % LZ values
    aas = size(alert_as,1); % aas: alert & anat_sleep;
    das = size(drowsy_as,1); % das: drowsy & anat_sleep
    aaw = size(alert_aw,1); % aaw: alert & anat_wake
    daw = size(drowsy_aw,1); % daw: drowsy & anat_wake

    % Add six new columns to each csv for storing corresponding LZ values
    zeroaas = zeros(aas,1);
    alert_as = addvars(alert_as,zeroaas,zeroaas,zeroaas,zeroaas,zeroaas,zeroaas,'NewVariableNames',{'FP','F','Cent','Anpos','Parie','Occi'});
    zerodas = zeros(das,1);
    drowsy_as = addvars(drowsy_as,zerodas,zerodas,zerodas,zerodas,zerodas,zerodas,'NewVariableNames',{'FP','F','Cent','Anpos','Parie','Occi'});
    zeroaaw = zeros(aaw,1);
    alert_aw = addvars(alert_aw,zeroaaw,zeroaaw,zeroaaw,zeroaaw,zeroaaw,zeroaaw,'NewVariableNames',{'FP','F','Cent','Anpos','Parie','Occi'});
    zerodaw = zeros(daw,1);
    drowsy_aw = addvars(drowsy_aw,zerodaw,zerodaw,zerodaw,zerodaw,zerodaw,zerodaw,'NewVariableNames',{'FP','F','Cent','Anpos','Parie','Occi'});


    % alert in anat_sleep
    for j = 1:aas
        epochidx = alert_as.clean_EEG_epoch_number(j) + 1; % CSV used python indexing, starting from 0
        alert_as.FP(j) = LZ_HGSN_as(1, epochidx);
        alert_as.F(j) = LZ_HGSN_as(2, epochidx);
        alert_as.Cent(j) = LZ_HGSN_as(3, epochidx);
        alert_as.Anpos(j) = LZ_HGSN_as(4, epochidx);
        alert_as.Parie(j) = LZ_HGSN_as(5, epochidx);
        alert_as.Occi(j) = LZ_HGSN_as(6, epochidx);
    end

    % drowsy in anat_sleep
    for j = 1:das
        epochidx = drowsy_as.clean_EEG_epoch_number(j) + 1;
        drowsy_as.FP(j) = LZ_HGSN_as(1, epochidx);
        drowsy_as.F(j) = LZ_HGSN_as(2, epochidx);
        drowsy_as.Cent(j) = LZ_HGSN_as(3, epochidx);
        drowsy_as.Anpos(j) = LZ_HGSN_as(4, epochidx);
        drowsy_as.Parie(j) = LZ_HGSN_as(5, epochidx);
        drowsy_as.Occi(j) = LZ_HGSN_as(6, epochidx);
    end

    % alert in anat_wake
    for j = 1:aaw
        epochidx = alert_aw.clean_EEG_epoch_number(j) + 1;
        alert_aw.FP(j) = LZ_HGSN_aw(1, epochidx);
        alert_aw.F(j) = LZ_HGSN_aw(2, epochidx);
        alert_aw.Cent(j) = LZ_HGSN_aw(3, epochidx);
        alert_aw.Anpos(j) = LZ_HGSN_aw(4, epochidx);
        alert_aw.Parie(j) = LZ_HGSN_aw(5, epochidx);
        alert_aw.Occi(j) = LZ_HGSN_aw(6, epochidx);
    end

   % drowsy in anat_wake
   for j = 1:daw
        epochidx = drowsy_aw.clean_EEG_epoch_number(j) + 1;
        drowsy_aw.FP(j) = LZ_HGSN_aw(1, epochidx);
        drowsy_aw.F(j) = LZ_HGSN_aw(2, epochidx);
        drowsy_aw.Cent(j) = LZ_HGSN_aw(3, epochidx);
        drowsy_aw.Anpos(j) = LZ_HGSN_aw(4, epochidx);
        drowsy_aw.Parie(j) = LZ_HGSN_aw(5, epochidx);
        drowsy_aw.Occi(j) = LZ_HGSN_aw(6, epochidx);
   end

   % The final step is to store the alert and drowsy csvs into anat_sleep
   % and anat_wake
   save_aas = strcat(asdir,'/',subj,'_as_alert.csv');
   save_das = strcat(asdir,'/',subj,'_as_drowsy.csv');
   save_aaw = strcat(awdir,'/',subj,'_aw_alert.csv');
   save_daw = strcat(awdir,'/',subj,'_aw_drowsy.csv');
   writetable(alert_as,save_aas);
   writetable(drowsy_as,save_das);
   writetable(alert_aw,save_aaw);
   writetable(drowsy_aw,save_daw);



end






end
