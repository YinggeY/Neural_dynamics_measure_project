
% Function for generating box plot for active and passive datasets

function box_ap()


pdir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Passive';
adir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/LZ/EEG/Active';
addpath(pdir, adir);

aa = readtable('average_active_alert.csv');
ad = readtable('average_active_drowsy.csv');

regions = {'FP','F','Cent','Anpos','Parie','Occi'};

for i = 1:6
    figure;
    alert = aa.(regions{i})(:,1);
    drowsy = ad.(regions{i})(:,1);
    data = [alert,drowsy];
    group = [zeros(size(alert)); ones(size(drowsy))];
    boxplot(data,group,'Labels',{'Alert','Drowsy'});
    ylabel('LZ values');
    titl = strcat('Active dataset',' (',regions{i},')');
    title(titl);
end

bhd = {'_a','_d'};
p_avg = readtable('average_passive.csv');

for j = 1:6
    figure;
    prop_a = strcat(regions{j},bhd{1});
    prop_d = strcat(regions{j},bhd{2});
    alert = p_avg.(prop_a)(:,1);
    drowsy = p_avg.(prop_d)(:,1);
    data = [alert, drowsy];
    group = [zeros(size(alert)); ones(size(drowsy))];
    boxplot(data,group,'Labels',{'Alert','Drowsy'});
    ylabel('LZ values');
    titl = strcat('Passive dataset',' (',regions{j},')');
    title(titl);
end


  




end

