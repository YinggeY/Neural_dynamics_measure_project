% Example data
group1 = randn(100,1);
group2 = randn(100,1) + 1;

% Combine the data into a single matrix
data = [group1, group2];

% Example data
group1 = randn(100,1);
group2 = randn(100,1) + 1;

group = {'alert','drowsy'};

% Create the violin plot
violin(data,group,[0.8,0.3,0.3]);
violin(data,group,[1,0.71,0.76],'k',0.4,'g','y');% Good color selection

grey = [0.502 0.502 0.502];
%gold = [1 0.843 0];
blue = [0.529 0.808 0.922];
% Add the scatter plot of data points
hold on
scatter(ones(52,1), alert, 'filled', 'MarkerFaceColor', blue);
scatter(2*ones(52,1), drowsy, 'filled', 'MarkerFaceColor', blue);

% Add the lines connecting the data points for the same subjects
for i = 1:52
    plot([1 2], [alert(i) alert(i)], 'Color', [0.5 0.5 0.5]);
end

% Add a legend
legend('Alert', 'Drowsy', 'Location', 'Northwest');