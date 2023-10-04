% This function is to return epoch and region averaged LZ values from the
% CSV

% Datasets are anat_sleep and anat_wake
% Rows are named 'FP','F','Cent','Anpos','Parie','Occi'
% Columns are 'sub07', 'sub08', ... , 'sub32'

% For anat_wake
function awmean()

% Define the names of rows and columns
colnames = {'FP_aaw','FP_daw','F_aaw','F_daw','Cent_aaw','Cent_daw','Anpos_aaw','Anpos_daw','Parie_aaw','Parie_daw','Occi_aaw','Occi_daw'};
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
     addpath(awdir);
     % anat_wake tables: alert(aas) and drowsy(das)
     aawname = strcat(subj,'_aw_alert.csv');
     dawname = strcat(subj,'_aw_drowsy.csv');
     % Now read tables
     aaw = readtable(aawname);
     daw = readtable(dawname);
     % Now calculate means
     FPaaw = mean(aaw.FP)/2; % Divided by 2 since epochs are repeated for 2s
     Faaw = mean(aaw.F)/2;
     Centaaw = mean(aaw.Cent)/2;
     Anposaaw = mean(aaw.Anpos)/2;
     Parieaaw = mean(aaw.Parie)/2;
     Occiaaw = mean(aaw.Occi)/2;
     FPdaw = mean(daw.FP)/2;
     Fdaw = mean(daw.F)/2;
     Centdaw = mean(daw.Cent)/2;
     Anposdaw = mean(daw.Anpos)/2;
     Pariedaw = mean(daw.Parie)/2;
     Occidaw = mean(daw.Occi)/2;
     % Assgin values
     average(idx,1) = FPaaw;
     average(idx,2) = FPdaw;
     average(idx,3) = Faaw;
     average(idx,4) = Fdaw;
     average(idx,5) = Centaaw;
     average(idx,6) = Centdaw;
     average(idx,7) = Anposaaw;
     average(idx,8) = Anposdaw;
     average(idx,9) = Parieaaw;
     average(idx,10) = Pariedaw;
     average(idx,11) = Occiaaw;
     average(idx,12) = Occidaw;
end


aw_table = array2table(average, 'RowNames', rownames, 'VariableNames', colnames);
% Add the subj column
aw_table = addvars(aw_table, rownames, 'Before', 1, 'NewVariableNames', 'rownames');
dir_aw = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/','Aw_average.csv');
writetable(aw_table,dir_aw);



end