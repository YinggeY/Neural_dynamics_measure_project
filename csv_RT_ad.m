% The final output should be two csv files for subject in either as or aw
% One is drowsy and the other is alert, with the LZ Values for 6 regions
% So a total of 4 csv files per subject
% No need for bash

% Note that LZ has already be averaged based on number of electrodes in
% each region

% For Corinne

function csv_RT_ad()

path1 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts';
addpath(path1);


%Initializing the subject string and carrying out calculations
sub = [521,551,552,632,634,664,681,682,686,694,699,700,704,706,713,714,720,721,739,740,750,751,766,789];

for i  = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));

    % Store directory in active-corinne subject folders
    cdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/Corinne/',subj,'/');
    
    % Add path to the computed LZ data versus epochs
    addpath(cdir);
    name = strcat(subj,'_with_RT.csv');
    RTtab = readtable(name);
    idx = strcmp(RTtab.ACCU,'correct'); % We only need 'correct' response RTs
    RTtable = RTtab(idx,:);
    ix = strcmp(RTtable.state_noNREMS,'alert');
    RT_a = RTtable(ix,:); % alert RTs
    ix1 = strcmp(RTtable.state_noNREMS,'drowsy');
    RT_d = RTtable(ix1,:); % drowsy RTs

    regions = {'FP','F','Cent','Anpos','Parie','Occi'};
    gLZ_a = zeros(size(RT_a.FP,1),1); % global LZ
    gLZ_d = zeros(size(RT_d.FP,1),1);
    for j = 1:6
        gLZ_a = gLZ_a + RT_a.(regions{j});
        gLZ_d = gLZ_d + RT_d.(regions{j});
    end
    RT_a.gLZ = gLZ_a;
    RT_d.gLZ = gLZ_d;
    save_a = strcat(cdir,subj,'_alert_RT.csv');
    save_d = strcat(cdir,subj,'_drowsy_RT.csv');
    writetable(RT_a,save_a);
    writetable(RT_d,save_d);



end


tables_a = cell(length(sub),1);
tables_d = cell(length(sub),1);

% loop through files and read each one into a table
for i = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));
    name_a = strcat(subj,'_alert_RT.csv');
    name_d = strcat(subj,'_drowsy_RT.csv');
    data_a = readtable(name_a);
    data_d = readtable(name_d);
    tables_a{i} = data_a;
    tables_d{i} = data_d;
end

% concatenate all tables vertically
combined_a = vertcat(tables_a{:});
combined_d = vertcat(tables_d{:});



storedir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/';
store_a = strcat(storedir,'RTs_alert.csv');
store_d = strcat(storedir,'RTs_drowsy.csv');

writetable(combined_a,store_a);
writetable(combined_d,store_d);

gLZ_a = combined_a.gLZ(:,1);
gLZ_d = combined_d.gLZ(:,1);
RT_a = (combined_a.RT(:,1));
RT_d = (combined_d.RT(:,1));
RT_a(RT_a == 0) = NaN; % Reaction time = 0 is meaningless
RT_d(RT_d == 0) = NaN;
plot(gLZ_a, RT_a, 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'none', 'MarkerSize', 3);
hold on;
plot(gLZ_d, RT_d, '+', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'none', 'MarkerSize', 3);
hold on;
% Perform linear regression
p_a = polyfit(gLZ_a, RT_a, 1);

% Evaluate the regression line at the x-values
y_fit_a = polyval(p_a, gLZ_a);
plot(gLZ_a, y_fit_a, 'k');
hold on;
p_d = polyfit(gLZ_d, RT_d, 1);
y_fit_d = polyval(p_d,gLZ_d);
plot(gLZ_d,y_fit_d,'g');
legend('alert RTs', 'drowsy RTs', 'alert regres','drowsy regres');


xlabel('Global LZ');
ylabel('RT/s');
title('Alert and drowsy clusters');



end