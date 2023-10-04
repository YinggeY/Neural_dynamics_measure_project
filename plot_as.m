% Plotting the anat_sleep results

function plot_as()

% Add the working directory
workdir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts/';
addpath(workdir);


for ID = 7:32
    if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
    end
    
    asdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/',subj);
    
    %Add path to the computed LZ data versus epochs
    addpath(asdir);
    
    subdata = strcat('EEG_Passive_anat_sleep_epoch_0_4_clean_',subj,'.mat');
    load(subdata,'LZ_HGSN');
    
    
    % Now we need to store figure in the corresponding subject folder
    storedir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/',subj);
    
    % Name the plot as sub0X or subXX
    Plotname = strcat('/EEG_Passive_anat_sleep_epoch_0_4_clean_line_',subj,'.fig'); % 'scatter' or 'line'
    
    % Concatenating to arrive at the storage directory
    savedir = strcat(storedir,Plotname);
    
    % First generating an integrated graph
    for i = 1:6
        [~,nepochs] = size(LZ_HGSN(i,:));
        epochs = linspace(1, nepochs, nepochs);
        %scatter(epochs,LZ_HGSN(i,:)); % If you want scatter graph, use this line, add 'scatter' to plotname
        plot(epochs,LZ_HGSN(i,:)); % For line graph, add 'line' in name
        hold on;
    end 
    hold off;
    xlabel('Number of epochs');
    ylabel('Normalised LZ');
    subjt = strcat(subj,'-as');
    title(subjt);
    legend('Fp','F','C','AP','Pa','Occ');
    saveas(gcf,savedir);
        
        
    
end




end

