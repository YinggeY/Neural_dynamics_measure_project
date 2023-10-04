% This function is to return epoch and region averaged LZ values for the
% Passive dataset

% Datasets are anat_sleep and anat_wake
% Rows are named 'FP','F','Cent','Anpos','Parie','Occi'
% Columns are 'sub07', 'sub08', ... , 'sub32'
% Final output will be two CSV files under the Passive folder


function Passive_sleep_mean()

% Define the names of rows and columns
regions = {'FP','F','Cent','Anpos','Parie','Occi'};
colnames = regions;
rownames = cell(26,1);
average = zeros(26,6); % This later will be the value assigned to table

for ID = 7:32
    idx = ID-6;
    % Get subject string first
     if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
        rownames{idx} = subj;
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
        rownames{idx} = subj;
     end
end

for ID = 7:32
    idx = ID-6;
    % Get subject string first
     if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
     end
     awdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj);
     asdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/',subj);
     addpath(awdir,asdir);

     % Read table from anat_sleep and anat_wake
     sawname = strcat(subj,'_as_sleep.csv');
     sasname = strcat(subj,'_aw_sleep.csv');
     % Now read tables
     saw = readtable(sawname);
     sas = readtable(sasname);

     % Now calculate means
     for i = 1:6
         prop = regions{i};
         flag_sas = size(sas.(prop),1);
         flag_saw = size(saw.(prop),1);
         sum_sleep = sum(sas.(prop))+sum(saw.(prop));
         mean_sleep = sum_sleep/(2*(flag_sas+flag_saw));
         average(idx,i) = mean_sleep;
     end

end


table = array2table(average, 'RowNames', rownames, 'VariableNames', colnames);
% Add the subj column
meantable = addvars(table, rownames, 'Before', 1, 'NewVariableNames', 'rownames');
passivedir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/','average_passive_sleep.csv');
writetable(meantable,passivedir);



end