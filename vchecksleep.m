
% This is the function to generate violin plot
% From anat_sleep and anat_wake datasets (Passive)
% The output should be e.g. within anat_sleep, a plot with LZ as vertical
% axis and regions are horizontal axis, 2 groups (alert and drowsy) for
% each property.


function vchecksleep()

passive_mean_dir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive';
addpath(passive_mean_dir);

% Read in data from CSV file, do anat_sleep first
passive_mean = readtable('average_passive.csv','TextType','string');
passive_sleep = readtable('average_passive_sleep.csv','TextType','string');
% aw_table = readtable('Aw_average.csv','TextType','string');

% Define property labels as a string array
 alertnames = {'FP_a','F_a','Cent_a','Anpos_a','Parie_a','Occi_a'};
 drowsynames = {'FP_d','F_d','Cent_d','Anpos_d','Parie_d','Occi_d'};


% Regional labels
regions = {'FP', 'F', 'Cent','Anpos', 'Parie', 'Occi'}; % This works for passive_sleep

% Define groups (alert and drowsy)
groups = {'drowsy','sleep'};

% Initialize cell array to store data
data_d = zeros(26, length(regions));
data_a = zeros(26, length(regions));
data_s = zeros(26,length(regions));

% Extract data columns for each categorical property and convert to numeric arrays
for i = 1:6
    alertcol = alertnames{i};
    drowsycol = drowsynames{i};
    sleepcol = regions{i};
    data_a(1:26,i) = (passive_mean.(alertcol));
    data_d(1:26,i) = (passive_mean.(drowsycol));
    data_s(1:26,i) = (passive_sleep.(sleepcol));
end

blue = [0.529 0.808 0.922];

for i = 1:length(regions)
    %alert = data_a(:,i);
    drowsy = data_d(:,i);
    sleep = data_s(:,i);
    violin([drowsy,sleep],groups,[1,0.71,0.76],'k',0.4,'g','y');% Good color selection
    hold on
    scatter(ones(26,1), drowsy, 'filled', 'MarkerFaceColor', blue);
    scatter(2*ones(26,1), sleep, 'filled', 'MarkerFaceColor', blue);

    % Add the lines connecting the data points for the same subjects
    for j = 1:26
        plot([1 2], [drowsy(j) sleep(j)], 'Color', [0.5 0.5 0.5]);
    end

    % Add a legend
    legend('Distr', 'Mean', 'Median','Location', 'Northwest');

    % Add title, and axis labels
    tit = strcat(regions{i},' in Passive dataset');
    title(tit);
    xlabel('State labels');
    ylabel('Average LZ');

end



end