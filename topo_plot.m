% Template to make topoplot scalp map %
% Samika - 12 June, 2023
% Edited by Yingge - 15 June, 2023

function topo_plot() % anat_sleep, anat_wake, or Corinne
% Initialize EEGlab
addpath('/rds/user/yy453/hpc-work/eeglab2022.1');
eeglab;

path1 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts';
path2 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/label';

addpath(path1);
addpath(path2);


% dataset = 'anat_sleep'; May also be anat_wake or Corinne
predatadir = '/rds/project/tb419/rds-tb419-bekinschtein/Samika/drowsy_eeg_fmri/eeg_data/anat_wake/processed_data/';

for ID = 7:32
    if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
    end

    % Store directory in anat_wake and anat_sleep subject folders
    awdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj);
    
    % Add path to the computed LZ data versus epochs
    addpath(awdir);

    table_aaw = strcat(subj,'_aw_alert.csv');
    table_daw = strcat(subj,'_aw_drowsy.csv');
    subalert = readtable(table_aaw);
    subdrowsy = reatable(table_daw);

    
    % Load LZ array - as LZ_electrodes
    data = strcat('EEG_Passive_anat_wake_no_region_',subj,'.mat');
    load(data,'LZ_electrodes');

    datadir = strcat(predatadir,subj,'/ses-wall/continuous_epochs_0_4/');
    datafile = strcat(subj,'_wall_continuous_epochs_0_4_clean.set');
    addpath(datadir);

    % Load EEG data and chanlocs
    EEG = pop_loadset(datafile,datadir);
    chanlocs = EEG.chanlocs;

    epoch_alert = unique(subalert.clean_EEG_epoch_number);
    epoch_drowsy = unique(subdrowsy.clean_EEG_epoch_number);
    alert_LZ = ddd;


    


    LZ_plot_values = mean(LZ_electrodes,2);

    % Remove these values from the plot.
    LZ_plot_values(94:96) = NaN;
    % Remove these values. They are outside of the scalp map.
    LZ_plot_values(86) = NaN;
    LZ_plot_values(74) = NaN;
    LZ_plot_values(44) = NaN;

    % assign minimum and maximum values for color map
    vmax = 0.55; % TO CHANGE to the real minimum of all the LZ data (alert and drowsy)
    vmin = 0.4; % TO CHANGE to the real maximum of all the LZ data (alert and drowsy)

    % Initialize figure
    figure;

    % Plot figure
    topoplot(LZ_plot_values,chanlocs,'maplimits',[vmin,vmax],'chantype','EEG','conv','on','electrodes','on');

    % Title plot
    title(sprintf('Example plot'),'FontSize',20); % TO CHANGE

    % show color bar
    cbar;

    % Save figure
    savefig('/Users/kumarsas/Documents/yingge/example_plot.fig') % TO CHANGE

end

end
