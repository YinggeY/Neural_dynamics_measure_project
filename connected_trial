% Example data
group1 = randn(100,1);
group2 = randn(100,1) + 1;

% Combine the data into a single matrix
data = [group1, group2];

% Define a custom color palette
my_colors = [0.3 0.3 0.8; 0.8 0.3 0.3]; % Blue and Red

% Create the violin plot with custom colors
violin(data, 'FaceColor', my_colors);

% Add the scatter plot of data points
hold on
scatter(ones(100,1), group1, 'filled', 'MarkerFaceColor', 'p');
scatter(2*ones(100,1), group2, 'filled', 'MarkerFaceColor', 'p');

% Add the lines connecting the data points for the same subjects
for i = 1:100
    plot([1 2], [group1(i) group2(i)], 'Color', [0.5 0.5 0.5]);
end

% Add a legend
legend('Group 1', 'Group 2', 'Location', 'Northwest');