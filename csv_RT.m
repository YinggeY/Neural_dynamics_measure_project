

% The final output should be two csv files for subject in either as or aw
% One is drowsy and the other is alert, with the LZ Values for 6 regions
% So a total of 4 csv files per subject
% No need for bash

% Note that LZ has already be averaged based on number of electrodes in
% each region

% For Corinne

function csv_RT()

path1 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts';
path2 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/label';

addpath(path1);
addpath(path2);

% Fix the readtable problem for the "state_noNREMS" colummn
opts = detectImportOptions('active_with_RT.csv');
opts.VariableTypes(11) = {'string'};% Problem happens when importing the 11th column
sublabel = readtable('active_with_RT.csv');

%sublabel = readtable('subs_labels.csv',opts);

%Initializing the subject string and carrying out calculations
sub = [521,551,552,632,634,664,681,682,686,694,699,700,704,706,713,714,720,721,739,740,750,751,766,789];

for i  = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));

     % Extract indices in CSV based on conditions
     idxsub = strcmp(sublabel.subject,subj); % Filter for subject and clean epochs
     subtable = sublabel(idxsub,:); % % Function for creating csv of LZ for each subject
     % Filter for all the states
     index = strcmp(subtable.state_noNREMS,'alert')|strcmp(subtable.state_noNREMS,'drowsy')|strcmp(subtable.state_noNREMS,'N2');
     % We get all the epochs as alert/drowsy/N2, note that there's no
     % 'clean_epoch_number', but the indices themselves are the epochs
     subads = subtable(index,:);


     % Store directory in active-corinne subject folders
     cdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/Corinne/',subj);
    
    % Add path to the computed LZ data versus epochs
    addpath(cdir);
    LZtable = strcat(subj,'_c_alert_drowsy_N2.csv');
    subLZ = readtable(LZtable);

    subLZ.RT = subads.RTRT;
    subLZ.ACCU = subads.ACCU;
    subLZ.DIF = subads.SNUM;
    save_c = strcat(cdir,'/',subj,'_with_RT.csv');

   writetable(subLZ,save_c);




end





end