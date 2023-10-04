% This is the function to generate violin plot
% From Corinne dataset (Active)
% The output should be plot with LZ as vertical
% axis and regions are horizontal axis, 2 groups (alert and drowsy) for
% each property.


function vplot_active()

active_mean_dir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active';
addpath(active_mean_dir);

% Read in data from CSV file, do anat_sleep first
alert_mean = readtable('average_active_alert.csv','TextType','string');
drowsy_mean = readtable('average_active_drowsy.csv','TextType','string');

sub = [521,551,552,632,634,664,681,682,686,694,699,700,704,706,713,714,720,721,739,740,750,751,766,789];

% Regional labels
regions = {'FP', 'F', 'Cent','Anpos', 'Parie', 'Occi'};

% Define groups (alert and drowsy)
groups = {'alert','drowsy'};

% Initialize cell array to store data
len = length(sub);
data_d = zeros(len, length(regions));
data_a = zeros(len, length(regions));

% Extract data columns for each categorical property and convert to numeric arrays
for i = 1:6
    prop = regions{i};
    data_a(1:len,i) = (alert_mean.(prop));
    data_d(1:len,i) = (drowsy_mean.(prop));
end

blue = [0.529 0.808 0.922];

for i = 1:length(regions)
    alert = data_a(:,i);
    drowsy = data_d(:,i);
    violin([alert,drowsy],groups,[1,0.71,0.76],'k',0.4,'g','y');% Good color selection
    hold on
    scatter(ones(len,1), alert, 'filled', 'MarkerFaceColor', blue);
    scatter(2*ones(len,1), drowsy, 'filled', 'MarkerFaceColor', blue);

    % Add the lines connecting the data points for the same subjects
    for j = 1:len
        plot([1 2], [alert(j) drowsy(j)], 'Color', [0.5 0.5 0.5]);
    end

    % Add a legend
    legend('Distr', 'Mean', 'Median','Location', 'Northwest');

    % Add title, and axis labels
    tit = strcat(regions{i},' in Active dataset');
    title(tit);
    xlabel('State labels');
    ylabel('Average LZ');

end

% Performing t-test
% Generate two groups of data
group1 = data_a;
group2 = data_d;

% Perform a two-sample t-test (ttest2 is for two independent variables)
[h, p, ci, stats] = ttest(group1, group2);

% Display the results
fprintf('t = %g, p = %g\n', stats.tstat, p);
if h
    fprintf('The means of the two groups are significantly different.\n');
else
    fprintf('The means of the two groups are not significantly different.\n');
end
% It seems that the latter 3 brain regions has significant difference

end