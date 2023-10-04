% Function for creating csv of LZ for each subject
% The final output should be two csv files for subject in either as or aw
% One is drowsy and the other is alert, with the LZ Values for 6 regions
% So a total of 4 csv files per subject
% No need for bash

% Note that LZ has already be averaged based on number of electrodes in
% each region

% For Corinne

function csv_c()

path1 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts';
path2 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/label';

addpath(path1);
addpath(path2);

sublabel = readtable('active_labels.csv');
% Fix the readtable problem for the "state_noNREMS" colummn
%opts = detectImportOptions('active_labels.csv');
%opts.VariableTypes(11) = {'string'};% Problem happens when importing the 11th column
%sublabel = readtable('subs_labels.csv',opts);

%Initializing the subject string and carrying out calculations
sub = [521,551,552,632,634,664,681,682,686,694,699,700,704,706,713,714,720,721,739,740,750,751,766,789];

for i  = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));

     % Extract indices in CSV based on conditions
     idxsub = strcmp(sublabel.subject,subj); % Filter for subject and clean epochs
     subtable = sublabel(idxsub,:); % Get subject table

     % Filter for all the states
     index = strcmp(subtable.state_noNREMS,'alert')|strcmp(subtable.state_noNREMS,'drowsy')|strcmp(subtable.state_noNREMS,'N2');
     % We get all the epochs as alert/drowsy/N2, note that there's no
     % 'clean_epoch_number', but the indices themselves are the epochs
     subads = subtable(index,:);

     % Store directory in active-corinne subject folders
     cdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/Corinne/',subj);
    
    % Add path to the computed LZ data versus epochs
    addpath(cdir);
    
    datac = strcat('EEG_Active_Corinne_tone_0_4_clean_',subj,'.mat');
    load(datac,'LZ_HGSN');


    % E.g. alert_c is expected to be a nX1 table containing
    % clean_EEG_epochs, which are indices to extract averaged LZ value from
    % mat file in each subject folder. Therefore, we need to loop through the row size of alert_as to assign
    % LZ values
    ac = sum(strcmp(subads.state_noNREMS,'alert')); % ac: alert & Corinne
    dc = sum(strcmp(subads.state_noNREMS,'drowsy')); % dc: drowsy & Corinne


    % Add six new columns to each csv for storing corresponding LZ values
    cols = zeros(size(subads,1),1);
    subads = addvars(subads,cols,cols,cols,cols,cols,cols,'NewVariableNames',{'FP','F','Cent','Anpos','Parie','Occi'});
    
    % Assigning values to 'alert', 'N2', and 'drowsy' epochs

    for j = 1:size(subads,1)
        subads.FP(j) = LZ_HGSN(1, j);
        subads.F(j) = LZ_HGSN(2, j);
        subads.Cent(j) = LZ_HGSN(3, j);
        subads.Anpos(j) = LZ_HGSN(4, j);
        subads.Parie(j) = LZ_HGSN(5, j);
        subads.Occi(j) = LZ_HGSN(6, j);

    end


   % The final step is to store the alert and drowsy csvs into Corinne
   % and Corinne
   save_c = strcat(cdir,'/',subj,'_c_alert_drowsy_N2.csv');
   writetable(subads,save_c);




end






end