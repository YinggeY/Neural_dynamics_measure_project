% Define the parent directory where you want to create the folders
parentDir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/Corinne';

% Define the subjects array with folder names
sub = [521,551,552,632,634,664,681,682,686,694,699,700,704,706,713,714,720,721,739,740,750,751,766,789];

% Loop through the subjects array and create a folder for each subject
for i = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));
    folderPath = fullfile(parentDir, subj);
    mkdir(folderPath);
end