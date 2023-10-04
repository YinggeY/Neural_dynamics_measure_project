% Serves as the main function in bash for calling other Matlab functions
% This is for anat_wake
% For trial with filtered data in sub09, sub15, sub18

function EEG_filt()

% First we need to add all necessary paths for search
addpath('/rds/user/yy453/hpc-work/eeglab2022.1');

% Initialize EEGlab
eeglab;

% Add the working directory
workdir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts/';
addpath(workdir);

% dataset = 'anat_wake'; May also be anat_sleep or Corinne
predatadir = '/rds/project/tb419/rds-tb419-bekinschtein/Samika/drowsy_eeg_fmri/eeg_data/anat_wake/processed_data/';

% Filtered subjects (4-13 Hz) are sub09, sub15, and sub18
fsubs = {'sub09','sub15','sub18'};

%Initializing the subject string and carrying out calculations
for i = 1:3
    subj = fsubs{i};
    datadir = strcat(predatadir,subj,'/ses-wall/continuous_epochs_0_4/');
    datafile = strcat(subj,'_wall_continuous_epochs_0_4_clean_filt_4-13.set');
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
    storedir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj,'/filtered/');
    
    % Name the file as sub0X or subXX
    Filename = strcat('/EEG_Passive_anat_wake_epoch_0_4_clean_filt_4-13_',subj,'.mat');
    
    % Concatenating to arrive at the storage directory
    savedir = strcat(storedir,Filename);
    save(savedir, 'LZ_HGSN'); % As we are using the HGSN division
    
end

end