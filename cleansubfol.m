% This is a function to clear the folders
% I will use them to clear the subject folders first
% Can run this directly on matlab, no need to write another bash.

function cleansubfol()


for ID = 7:32
    if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
    end

    asdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/',subj);
    awdir = strcat('/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/',subj);
    delete(fullfile(asdir,'*.*'));
    delete(fullfile(awdir,'*.*'));

end


end


