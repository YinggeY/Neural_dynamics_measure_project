% Function for counting the detected channels in each HGSN division region
% In case we need to normalise the LZ measure in each region
% Input is a nchan*1 array of strings from EEG.chanlocs.labels of the data
% Output is 6*1 array of integers counting detected channels in each region

function numbs = numHGSN(labels)

numbs = zeros(6,1); % Not 7 since we have to concatenate Anterior and Posterior frontal

% Frontal pole
front_p = [1;2;3;8;9;10;14;15;16;17;18;21;22;23;25;26;32;33;38;121;122;125;126];
% Frontal
front = [3;4;5;6;11;12;13;19;20;23;24;26;27;28;111;112;116;117;118;123;124];
% Central
cent = [6;7;13;20;27;28;29;30;31;34;35;36;37;40;41;42;46;55;80;87;93;102;103;104;105;106;109;110;111;112;116;117;118;123];
% Anterior temporal
an_tem = [1;32;33;34;38;39;40;43;44;45;48;49;108;109;113;114;115;116;119;120;121;122];
% Posterior temporal
pos_tem = [39;40;44;45;46;49;50;51;56;57;58;59;64;91;95;96;97;99;100;101;102;107;108;109;113;114;115];
% Concatenate Anterior and Posterior temporal
anpos = cat(1,an_tem,pos_tem);
% Parietal
parie = [47;51;52;53;54;59;60;61;62;67;77;78;79;85;86;91;92;97;98];
% Occipital-inion
occi = [60;62;65;66;67;69;70;71;72;74;75;76;77;82;83;84;85;89;90;91];

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