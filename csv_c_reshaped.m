% RE-shape the active csvs so that they can be used for statistical
% analysis

% Note that LZ has already be averaged based on number of electrodes in
% each region

% For Corinne

function csv_c_reshaped()

path1 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts';
path2 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/Corinne/';

addpath(path1);
addpath(path2);

% Fix the readtable problem for the "state_noNREMS" colummn
%opts = detectImportOptions('active_labels.csv');
%opts.VariableTypes(11) = {'string'};% Problem happens when importing the 11th column
%sublabel = readtable('subs_labels.csv',opts);

%Initializing the subject string and carrying out calculations
sub = [521,551,552,632,634,664,681,682,686,694,699,700,704,706,713,714,720,721,739,740,750,751,766,789];

% Number of rows in the subject csv, so to get number of rows for the final
% large csv
for i = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));
    subdir = strcat(path2,subj,'/');
    addpath(subdir);
    datafile = strcat(subj,'_c_alert_drowsy_N2.csv');
    subfile = readtable(datafile);
    idx = strcmp(subfile.state_noNREMS,'alert') | strcmp(subfile.state_noNREMS,'drowsy');
    adsub = subfile(idx,:); % Just interested in the alert and drowsy states
    row_num = size(adsub.FP,1);
    rows = 6*row_num;

    subject = cell(rows,1);
    states = cell(rows,1);
    LZs = zeros(rows,1);
    seq = [1;2;3;4;5;6];
    regions = repmat(seq,row_num,1);
    subject(:,1) = adsub.subject(1);

    for j = 1:row_num
        idx1 = 6*j-5;
        idx2 = 6*j-4;
        idx3 = 6*j-3;
        idx4 = 6*j-2;
        idx5 = 6*j-1;
        idx6 = 6*j;
        states(idx1:idx6,1) = adsub.state_noNREMS(j);
        LZs(idx1,1) = adsub.FP(j);
        LZs(idx2,1) = adsub.F(j);
        LZs(idx3,1) = adsub.Cent(j);
        LZs(idx4,1) = adsub.Anpos(j);
        LZs(idx5,1) = adsub.Parie(j);
        LZs(idx6,1) = adsub.Occi(j);
    end
    % Tidy up in table
    subcol = cell2table(subject,'VariableNames',{'Subject'});
    reshape = table(states,regions,LZs,'VariableNames',{'State','Region','LZ'});
    final = [subcol reshape];
    savedir = strcat(subdir,'/',subj,'_reshape_ad.csv');
    writetable(final,savedir);


end



for i = 1:length(sub)
    subj = 'sub%d';
    subj = sprintf(subj,sub(i));
    subdir = strcat(path2,subj,'/');
    addpath(subdir);
    datafile = strcat(subj,'_reshape_ad.csv');
    subfile = readtable(datafile);
    Table = vertcat(subfile);
end


finaldir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/';
savefinal = strcat(finaldir,'Active_reshaped.csv');
writetable(Table,savefinal);

end


