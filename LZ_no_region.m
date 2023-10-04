%Initializing the subject string and carrying out calculations
for ID = 7:32
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

    % Load LZ array - as LZ_electrodes
    EEG = pop_loadset(datafile,datadir);
    chanlocs = EEG.chanlocs;
    LZ_electrodes = LZ_elect(EEG);
    storedir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj);

    % Name the file as sub0X or subXX
    Filename = strcat('/EEG_Passive_anat_wake_no_region_',subj,'.mat');
    
    % Concatenating to arrive at the storage directory
    savedir = strcat(storedir,Filename);
    save(savedir, 'LZ_electrodes'); % As we are using the HGSN division

end