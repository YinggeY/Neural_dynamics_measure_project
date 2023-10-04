% RE-shape the active csvs so that they can be used for statistical
% analysis

% Note that LZ has already be averaged based on number of electrodes in
% each region

% For Corinne

function csv_aw_reshaped()

path1 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts';
path2 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/label';

addpath(path1);
addpath(path2);


% Fix the readtable problem for the "state_noNREMS" colummn
opts = detectImportOptions('subs_labels.csv');
opts.VariableTypes(11) = {'string'};% Problem happens in the 11th column
sublabel = readtable('subs_labels.csv',opts);


for ID = 7:32
    % Get subject string first
     if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
     end


     % Extract indices in CSV based on conditions
     idxsub = strcmp(sublabel.subject,subj);
     subtable = sublabel(idxsub,:); % Get subject table
     awidx = strcmp(subtable.dataset,'anat_wake');
     subaw = subtable(awidx,:);
     idxnum = ~isnan(subaw.clean_EEG_epoch_number); % Filter for subject and clean epochs
     subclean = subaw(idxnum,:);
     [~, uniqueIdx] = unique(subclean.clean_EEG_epoch_number);
     subunique = subclean(uniqueIdx,:);
     row_num = size(subunique.clean_EEG_epoch_number,1);
     rows = row_num*6; % Number of rows is number of clean epoch numbers * 6

     awdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj);

     % Add path to the computed LZ data versus epochs
    addpath(awdir);
    
    data = strcat('EEG_Passive_anat_wake_epoch_0_4_clean_',subj,'.mat');
    load(data,'LZ_HGSN');

    LZs = zeros(rows,1);
    subject = cell(rows,1);
    epochs = zeros(rows,1);
    seq = [1;2;3;4;5;6];
    regions = repmat(seq,row_num,1);
    subject(:,1) = subunique.subject(1);

    for j = 1:row_num
        idx1 = 6*j-5;
        idx6 = 6*j;
        clean_epoch = subunique.clean_EEG_epoch_number(j) + 1; % Python starts from 0
        epochs(idx1:idx6,1) = clean_epoch;
        LZs(idx1:idx6,1) = LZ_HGSN(1:6,clean_epoch);
    end


    % Tidy up in table
    subcol = cell2table(subject,'VariableNames',{'Subject'});
    reshape = table(epochs,regions,LZs,'VariableNames',{'epoch','Region','LZ'});
    final = [subcol reshape];
    savedir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/Reshaped/',subj,'_aw_reshape_clean.csv');
    writetable(final,savedir);


end



end