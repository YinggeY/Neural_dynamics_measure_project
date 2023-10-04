% Function for creating csv of LZ for each subject
% The final output should be two csv files for subject in either as or aw
% The file is for the sleep data, with the LZ Values for 6 regions
% So a total of 2 csv files per subject
% No need for bash

% Note that LZ has already be averaged based on number of electrodes in
% each region

% For anat_sleep
function csv_as_sleep()

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
     sub_as = subtable(idx_as,:); % anat_sleep & clean & subject table

     % We are only interested if sleep_state is 2 or 3, and state is N2 or drowsy
     sleep_stage = sub_as.sleep_stage == 2 | sub_as.sleep_stage == 3; 
     sleep_as = sub_as(sleep_stage,:);% clean & sleep slots for subj in anat_sleep dataset

     dN2 = strcmp(sleep_as.state,'N2')|strcmp(sleep_as.state,'drowsy'); % Filter for state conditions
     sN2 = sleep_as(dN2,:); % drowsy state subject in clean anat_sleep


     % Store directory in anat_wake and anat_sleep subject folders
     asdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/',subj);
    
    % Add path to the computed LZ data versus epochs
    addpath(asdir);
    
    dataas = strcat('EEG_Passive_anat_sleep_epoch_0_4_clean_',subj,'.mat');
    load(dataas,'LZ_HGSN');


    % E.g. alert_as is expected to be a nX1 table containing
    % clean_EEG_epochs, which are indices to extract averaged LZ value from
    % mat file in each subject folder. Therefore, we need to loop through the row size of alert_as to assign
    % LZ values
    sas = size(sN2,1); % aas: alert & anat_sleep;

    % Add six new columns to each csv for storing corresponding LZ values
    zerosas = zeros(sas,1);
    sN2 = addvars(sN2,zerosas,zerosas,zerosas,zerosas,zerosas,zerosas,'NewVariableNames',{'FP','F','Cent','Anpos','Parie','Occi'});


    %sleep in anat_sleep
    for j = 1:sas
        epochidx = sN2.clean_EEG_epoch_number(j) + 1; % CSV used python indexing, starting from 0
        sN2.FP(j) = LZ_HGSN(1, epochidx);
        sN2.F(j) = LZ_HGSN(2, epochidx);
        sN2.Cent(j) = LZ_HGSN(3, epochidx);
        sN2.Anpos(j) = LZ_HGSN(4, epochidx);
        sN2.Parie(j) = LZ_HGSN(5, epochidx);
        sN2.Occi(j) = LZ_HGSN(6, epochidx);
    end


   % The final step is to store the alert and drowsy csvs into anat_sleep
   % and anat_wake
   save_sas = strcat(asdir,'/',subj,'_as_sleep.csv');
   writetable(sN2,save_sas);



end






end