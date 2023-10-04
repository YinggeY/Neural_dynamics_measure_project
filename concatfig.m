
% Script for concatenating 6 pictures from fig files

% Loop over the subplots and add the group labels
fig1 = openfig('FP_active.fig');
fig2 = openfig('F_active.fig');
fig3 = openfig('Cent_active.fig');
fig4 = openfig('Anpos_active.fig');
fig5 = openfig('Parie_active.fig');
fig6 = openfig('Occi_active.fig');

newFig = figure;
set(newFig,'Position',[0 0 1500 400]);

ax1 = subplot(1,3,1);
ax2 = subplot(1,3,2);
ax3 = subplot(1,3,3);
copyobj(allchild(get(fig1,'CurrentAxes')), ax1);
copyobj(allchild(get(fig2,'CurrentAxes')), ax2);
copyobj(allchild(get(fig3,'CurrentAxes')), ax3);

newFig = figure;
set(newFig,'Position',[0 0 1500 400]);
ax4 = subplot(1,3,1);
ax5 = subplot(1,3,2);
ax6 = subplot(1,3,3);
copyobj(allchild(get(fig4,'CurrentAxes')), ax4);
copyobj(allchild(get(fig5,'CurrentAxes')), ax5);
copyobj(allchild(get(fig6,'CurrentAxes')), ax6);


copyobj(allchild(get(fig1,'CurrentAxes')), ax1);
copyobj(allchild(get(fig2,'CurrentAxes')), ax2);
copyobj(allchild(get(fig3,'CurrentAxes')), ax3);
copyobj(allchild(get(fig4,'CurrentAxes')), ax4);
copyobj(allchild(get(fig5,'CurrentAxes')), ax5);
copyobj(allchild(get(fig6,'CurrentAxes')), ax6);

% Copy the label and title properties from the original axes objects to the new axes objects
set(ax1, 'YLabel', get(get(fig1,'CurrentAxes'),'YLabel'));
set(ax1, 'XLabel', get(get(fig1,'CurrentAxes'),'XLabel'));
set(ax1, 'Title', get(get(fig1,'CurrentAxes'),'Title'));

set(ax2, 'YLabel', get(get(fig2,'CurrentAxes'),'YLabel'));
set(ax2, 'XLabel', get(get(fig2,'CurrentAxes'),'XLabel'));
set(ax2, 'Title', get(get(fig2,'CurrentAxes'),'Title'));
%set(ax2, 'XLabel', get(get(fig2,'CurrentAxes'), 'XLabel'), 'XLabel');

set(ax3, 'YLabel', get(get(fig3,'CurrentAxes'),'YLabel'));
set(ax3, 'XLabel', get(get(fig3,'CurrentAxes'),'XLabel'));
set(ax3, 'Title', get(get(fig3,'CurrentAxes'),'Title'));

set(ax4, 'YLabel', get(get(fig4,'CurrentAxes'),'YLabel'));
set(ax4, 'XLabel', get(get(fig4,'CurrentAxes'),'XLabel'));
set(ax4, 'Title', get(get(fig4,'CurrentAxes'),'Title'));

set(ax5, 'YLabel', get(get(fig5,'CurrentAxes'),'YLabel'));
set(ax5, 'XLabel', get(get(fig5,'CurrentAxes'),'XLabel'));
set(ax5, 'Title', get(get(fig5,'CurrentAxes'),'Title'));

set(ax6, 'YLabel', get(get(fig6,'CurrentAxes'),'YLabel'));
set(ax6, 'XLabel', get(get(fig6,'CurrentAxes'),'XLabel'));
set(ax6, 'Title', get(get(fig6,'CurrentAxes'),'Title'));

group_labels = {' ', 'alert',' ','drowsy'};

for i = 1:3
    % Select the i-th subplot
    subplot(1, 3, i);

    % Add the group labels to the x-axis
    xticklabels(group_labels);
end


