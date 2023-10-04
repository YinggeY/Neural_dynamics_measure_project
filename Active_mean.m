% This function is to return epoch and region averaged LZ values for the
% Passive dataset

% Datasets are anat_sleep and anat_wake
% Rows are named 'FP','F','Cent','Anpos','Parie','Occi'
% Columns are 'sub07', 'sub08', ... , 'sub32'
% Final output will be two CSV files under the Passive folder


function Active_mean()

% Define the names of rows and columns
regions = {'FP','F','Cent','Anpos','Parie','Occi'};
sub = [521,551,552,632,634,664,681,682,686,694,699,700,704,706,713,714,720,721,739,740,750,751,766,789];
rownames = cell(length(sub),1);
average_a = zeros(length(sub),6); % This later will be the value assigned to table
average_d = zeros(length(sub),6); % _a and _d means 'alert' and 'drowsy'

for i  = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));
    rownames{i} = subj;
end


for i = 1:length(sub)
    % Get subject string first
     subj = 'sub%d';
     subj = sprintf(subj,sub(i));
     cdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/Corinne/',subj);
     addpath(cdir);

     % Active dataset table
     cname = strcat(subj,'_c_alert_drowsy_N2.csv');
     table = readtable(cname);

     % Now calculate means
     for j = 1:6
         prop = regions{j};
         al = strcmp(table.state_noNREMS,'alert');
         dr = strcmp(table.state_noNREMS,'drowsy');
         num_a = sum(al); % number of alert epochs
         num_d = sum(dr); % number of drowsy epochs
         alert = table(al,:);
         drowsy = table(dr,:);
         average_a(i,j) = sum(alert.(prop))/num_a;
         average_d(i,j) = sum(drowsy.(prop))/num_d;
     end


table_a = array2table(average_a, 'RowNames', rownames, 'VariableNames', regions);
table_d = array2table(average_d, 'RowNames', rownames, 'VariableNames', regions);
% Add the subj column
mean_a = addvars(table_a, rownames, 'Before', 1, 'NewVariableNames', 'rownames');
mean_d = addvars(table_d, rownames, 'Before', 1, 'NewVariableNames', 'rownames');
alertdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/','average_active_alert.csv');
drowsydir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/','average_active_drowsy.csv');
writetable(mean_a,alertdir);
writetable(mean_d, drowsydir);



end


end