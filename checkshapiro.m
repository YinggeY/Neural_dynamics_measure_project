% Perform shapiro test on different datasets, 2 subjects each

function checkshapiro()

path1 = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts';
pathas = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_wake/';
pathaw = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive/anat_sleep/';
pathc = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active/Corinne';


addpath(path1);
addpath(pathas);
addpath(pathaw);
addpath(pathc);


 ID = 16;
    % Get subject string first
     if ID < 10
        subj = 'sub0%d';
        subj = sprintf(subj,ID);
    else
        subj = 'sub%d';
        subj = sprintf(subj,ID);
     end
    subdiraw = strcat(pathaw,subj,'/');
    subdiras = strcat(pathas,subj,'/');
    addpath(subdiraw,subdiras);


     % Extract indices in CSV based on conditions
     aaw = strcat(subj,'_aw_alert.csv');
     daw = strcat(subj,'_aw_drowsy.csv');
     aas = strcat(subj,'_as_alert.csv');
     das = strcat(subj,'_as_drowsy.csv');
     csvnames = {aaw,daw,aas,das};
     dsnames = {'aaw','daw','aas','das'};

     for i = 1:4
         subtable = readtable(csvnames{i});
         [~, uniqueIdx] = unique(subtable.clean_EEG_epoch_number);
         subunique = subtable(uniqueIdx,:);
         epochs = subunique.clean_EEG_epoch_number(:,1);
         names = {'FP','F','Cent','Anpos','Parie','Occi'};
         hs = zeros(6,1);
         ps = zeros(6,1);
         stats = zeros(6,1);
         for j = 1:6
             figure;
             data = subunique.(names{j});
             plot(epochs,data,'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'none', 'MarkerSize', 3);
             [h,p,stat] = swtest(data);
             hs(j,1) = h;
             ps(j,1) = p;
             stats(j,1) = stat;
             titl = strcat(dsnames{i},' for region ',names{j},' (',subj,')');
             title(titl);
             xlabel('Clean EEG epoch number');
             ylabel('LZ values');
         end
     end





             


end
 



