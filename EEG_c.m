% Serves as the main function in bash for calling other Matlab functions
% This is for Corinne

function EEG_c()

% First we need to add all necessary paths for search
addpath('/rds/user/yy453/hpc-work/eeglab2022.1');

% Initialize EEGlab
eeglab;

% Add the working directory
workdir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts/';
addpath(workdir);

% dataset = 'Corinne'; May also be anat_sleep or anat_wake
predir = '/rds/project/tb419/rds-tb419-bekinschtein/Samika/drowsy_eeg_fmri/eeg_data/corinne/';
postdir = '/ses-sleep/tone_epochs_-4_0/';

%Initializing the subject string and carrying out calculations
sub = [521,551,552,632,634,664,681,682,686,694,699,700,704,706,713,714,720,721,739,740,750,751,766,789];

for i  = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));
    datadir = strcat(predir,subj,postdir);
    datafile = strcat(subj,'_sleep_tone_epochs_-4_0_clean.set');
    addpath(datadir);
    % Extract the EEG struct data
    % EEG = pop_loadset('myfile.set', 'myfilepath');
    % Try to create a cell array
    EEG = pop_loadset(datafile,datadir);
    
    % Now the calculation begins
    labels = getlabels(EEG);
    nums = numHGSN(labels);
    LZ_electrodes = LZ_elect(EEG);
    LZ_HGSN = HGSN_LZ(LZ_electrodes,labels);

    % Now calculate the region average based on number of electrodes
    LZ_HGSN = LZ_HGSN./nums;
    
    % Now we need to store data in the corresponding subject folder
    storedir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/Corinne/',subj);
    
    % Name the file as sub0X or subXX
    Filename = strcat('/EEG_Active_Corinne_tone_0_4_clean_',subj,'.mat');
    
    % Concatenating to arrive at the storage directory
    savedir = strcat(storedir,Filename);
    save(savedir, 'LZ_HGSN'); % As we are using the HGSN division
    
end

end