% This function is to return epoch and region averaged LZ values from the
% CSV

% Datasets are anat_sleep and anat_wake
% Rows are named 'FP','F','Cent','Anpos','Parie','Occi'
% Columns are 'sub07', 'sub08', ... , 'sub32'

% For anat_sleep
function asmean()

% Define the names of rows and columns
colnames = {'FP_aas','FP_das','F_aas','F_das','Cent_aas','Cent_das','Anpos_aas','Anpos_das','Parie_aas','Parie_das','Occi_aas','Occi_das'};
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
     asdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/',subj);
     addpath(asdir);
     % anat_sleep tables: alert(aas) and drowsy(das)
     aasname = strcat(subj,'_as_alert.csv');
     dasname = strcat(subj,'_as_drowsy.csv');
     % Now read tables
     aas = readtable(aasname);
     das = readtable(dasname);
     % Now calculate means
     FPaas = mean(aas.FP)/2; % Divided by 2 since epochs are repeated for 2s
     Faas = mean(aas.F)/2;
     Centaas = mean(aas.Cent)/2;
     Anposaas = mean(aas.Anpos)/2;
     Parieaas = mean(aas.Parie)/2;
     Occiaas = mean(aas.Occi)/2;
     FPdas = mean(das.FP)/2;
     Fdas = mean(das.F)/2;
     Centdas = mean(das.Cent)/2;
     Anposdas = mean(das.Anpos)/2;
     Pariedas = mean(das.Parie)/2;
     Occidas = mean(das.Occi)/2;
     % Assgin values
     average(idx,1) = FPaas;
     average(idx,2) = FPdas;
     average(idx,3) = Faas;
     average(idx,4) = Fdas;
     average(idx,5) = Centaas;
     average(idx,6) = Centdas;
     average(idx,7) = Anposaas;
     average(idx,8) = Anposdas;
     average(idx,9) = Parieaas;
     average(idx,10) = Pariedas;
     average(idx,11) = Occiaas;
     average(idx,12) = Occidas;
end

as_table = array2table(average,'RowNames',rownames,'VariableNames', colnames);
% Add the subj column
as_table = addvars(as_table, rownames, 'Before', 1, 'NewVariableNames', 'rownames');
dir_as = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/','As_average.csv');
writetable(as_table,dir_as);




end