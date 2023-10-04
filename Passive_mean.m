% This function is to return epoch and region averaged LZ values for the
% Passive dataset

% Datasets are anat_sleep and anat_wake
% Rows are named 'FP','F','Cent','Anpos','Parie','Occi'
% Columns are 'sub07', 'sub08', ... , 'sub32'
% Final output will be two CSV files under the Passive folder


function Passive_mean()

% Define the names of rows and columns
regions = {'FP','F','Cent','Anpos','Parie','Occi'};
colnames = {'FP_a','FP_d','F_a','F_d','Cent_a','Cent_d','Anpos_a','Anpos_d','Parie_a','Parie_d','Occi_a','Occi_d'};
rownames = cell(26,1);
average = zeros(26,12); % This later will be the value assigned to table

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

     % anat_wake tables: alert(aas) and drowsy(das)
     aawname = strcat(subj,'_aw_alert.csv');
     dawname = strcat(subj,'_aw_drowsy.csv');
     % Now read tables
     aaw = readtable(aawname);
     daw = readtable(dawname);

     % anat_sleep tables: alert(aas) and drowsy(das)
     aasname = strcat(subj,'_as_alert.csv');
     dasname = strcat(subj,'_as_drowsy.csv');
     % Now read tables
     aas = readtable(aasname);
     das = readtable(dasname);

     % Now calculate means
     for i = 1:6
         prop = regions{i};
         flag_aas = size(aas.(prop),1);
         flag_aaw = size(aaw.(prop),1);
         flag_das = size(das.(prop),1);
         flag_daw = size(daw.(prop),1);
         sum_alert = sum(aas.(prop))+sum(aaw.(prop));
         sum_drowsy = sum(das.(prop))+sum(daw.(prop));
         mean_alert = sum_alert/(2*(flag_aas+flag_aaw));
         mean_drowsy = sum_drowsy/(2*(flag_das+flag_daw));
         average(idx,2*i-1) = mean_alert;
         average(idx,2*i) = mean_drowsy;
     end

end


table = array2table(average, 'RowNames', rownames, 'VariableNames', colnames);
% Add the subj column
meantable = addvars(table, rownames, 'Before', 1, 'NewVariableNames', 'rownames');
passivedir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/','average_passive.csv');
writetable(meantable,passivedir);



end