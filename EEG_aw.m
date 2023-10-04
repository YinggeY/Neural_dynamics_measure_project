% Serves as the main function in bash for calling other Matlab functions
% This is for anat_wake

function EEG_aw()

% First we need to add all necessary paths for search
addpath('/rds/user/yy453/hpc-work/eeglab2022.1');

% Initialize EEGlab
eeglab;

% Add the working directory
workdir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts/';
addpath(workdir);

% dataset = 'anat_wake'; May also be anat_sleep or Corinne
predatadir = '/rds/project/tb419/rds-tb419-bekinschtein/Samika/drowsy_eeg_fmri/eeg_data/anat_wake/processed_data/';

%Initializing the subject string and carrying out calculations
for ID = 7:32 % Note that there's some problem with sub09 now
    if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
    end
    datadir = strcat(predatadir,subj,'/ses-wall/continuous_epochs_0_4/');
    datafile = strcat(subj,'_wall_continuous_epochs_0_4_clean.set');
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
    storedir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj);
    
    % Name the file as sub0X or subXX
    Filename = strcat('/EEG_Passive_anat_wake_epoch_0_4_clean_',subj,'.mat');
    
    % Concatenating to arrive at the storage directory
    savedir = strcat(storedir,Filename);
    save(savedir, 'LZ_HGSN'); % As we are using the HGSN division
    
end

end