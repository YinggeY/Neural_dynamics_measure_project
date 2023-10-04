% Function for counting the detected channels in each GSN division region
% In case we need to normalise the LZ measure in each region
% Input is a nchan*1 array of strings from EEG.chanlocs.labels of the data
% Output is 6*1 array of integers counting detected channels in each region

function numbs = numGSN(labels)

numbs = zeros(6,1);% Not 7 since we have to concatenate Anterior and Posterior temporal

% Frontal pole
front_p = [1;2;3;8;9;10;14;15;16;17;18;19;22;23;24;26;27;33;34;39;116;121;122;125;126];
% Frontal
front = [3;4;5;6;11;12;13;20;21;24;25;28;29;35;112;113;117;118;119;123;124];
% Central
cent = [6;7;13;21;28;29;30;31;32;35;36;37;38;41;42;43;47;48;55;81;88;94;99;103;104;105;106;107;110;111;112;113;117;118;119;123];
% Anterior temporal
an_tem = [1;33;34;35;39;40;41;44;45;46;47;49;103;109;110;114;115;116;117;120;121;122];
% Posterior temporal
pos_tem = [45;46;47;49;50;51;52;56;57;58;59;64;65;92;93;96;97;98;99;100;101;102;103;108;109;114];
% Concatenate Anterior and Posterior temporal
anpos = cat(1,an_tem,pos_tem);
% Parietal
parie = [43;48;51;52;53;54;59;60;61;62;68;79;80;86;87;92;93;94;98;99];
% Occipital-inion
occi = [60;61;65;66;67;68;70;71;72;73;75;76;77;78;79;83;84;85;86;89;90;91];

% 1. Number of electrodes detected in frontal pole
% Use front_p
for i = 1:size(front_p)
    index = find(labels=="E"+string(front_p(i)));
    if index~= 0
       numbs(1) = numbs(1)+1;
    end
end

% 2. Number of electrodes detected in frontal 
% Use front
for i = 1:size(front)
    index = find(labels=="E"+string(front(i)));
    if index~= 0
       numbs(2) = numbs(2)+1;
    end
end


% 3. Number of electrodes detected in the Central
% Use cent
for i = 1:size(cent)
    index = find(labels=="E"+string(cent(i)));
    if index~= 0
       numbs(3) = numbs(3)+1;
    end
end


% 4. Number of electrodes in Anterior and Posterior temporal
% Use anpos
for i = 1:size(anpos)
    index = find(labels=="E"+string(anpos(i)));
    if index~= 0
       numbs(4) = numbs(4)+1;
    end
end

% 5. Number of electrodes in Posterior temporal
% Use pos_tem
%for i = 1:size(pos_tem)
    %index = find(labels=="E"+string(pos_tem(i)));
    %if index~= 0
       %numbs(5) = numbs(5)+1;
    %end
%end

% 6. Number of electrodes in Parietal
% Use parie
for i = 1:size(parie)
    index = find(labels=="E"+string(parie(i)));
    if index~= 0
       numbs(5) = numbs(5)+1;
    end
end

% 7. Number of electrodes in Occipital-inion
% Use occi
for i = 1:size(occi)
    index = find(labels=="E"+string(occi(i)));
    if index~= 0
       numbs(6) = numbs(6)+1;
    end
end



end