
% Template to make topoplot scalp map %
% Samika - 12 June, 2023

% Initialize EEGlab
% addpath('/rds/user/yy453/hpc-work/eeglab2022.1');
eeglab;

% Load channel locations
chanlocs = load('/Users/kumarsas/Documents/scripts_phd/EEG_chanlocs.mat').EEG_chanlocs; % TO CHANGE

% Load LZ array - as LZ_electrodes
% TO CHANGE
load('/Users/kumarsas/Documents/yingge/sub09_wall_continuous_epochs_0_4_clean_LZ_elecs.mat'); % TO CHANGE

% Get LZ values that you want to plot; for example, the mean 
LZ_plot_values = mean(LZ_electrodes,2); % TO CHANGE

% Remove these values from the plot.
LZ_plot_values(94:96) = NaN;
% Remove these values. They are outside of the scalp map.
LZ_plot_values(86) = NaN;
LZ_plot_values(74) = NaN;
LZ_plot_values(44) = NaN;

% assign minimum and maximum values for color map
vmax = 0.55; % TO CHANGE
vmin = 0.4; % TO CHANGE

% Initialize figure
figure;

% plot image
topoplot(LZ_plot_values,chanlocs,'maplimits',[vmin,vmax],'chantype','EEG','conv','on','electrodes','on');

% Title plot
title(sprintf('Example plot'),'FontSize',20); % TO CHANGE

% show color bar
cbar;

% save image
% export_fig(sprintf('/Users/kumarsas/Documents/yingge/example_plot.png'),'-png', '-nocrop', '-m3', '-transparent');
savefig('/Users/kumarsas/Documents/yingge/example_plot.fig') % TO CHANGE


