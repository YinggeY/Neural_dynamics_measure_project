% Function for extracting electrode labels for subject at the same EEG experiment
% Input is the EEG struct data

function labels = getlabels(EEG)

% Get a nchan*1 column of channel labels for future brain division
% As it is hard to pend different variables (i.e. string and single) into
% one array, we can pend them into Excel or MAT if needed
labels = string(zeros(EEG.nbchan,1));

for i = 1:EEG.nbchan
    labels(i,1) = EEG.chanlocs(i).labels;
end

end