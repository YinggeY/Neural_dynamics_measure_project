% Function for adding LZ for specific brain region divisions
% Input is nchan*nepochs temporal LZ measures
% Output is 6*nepochs LZ measures for 6 brain regions
% Following HGSN division of electrodes

function LZ_HGSN = HGSN_LZ(LZ_electrodes,labels)


LZ_HGSN = zeros(6,size(LZ_electrodes,2)); %Not 7 since we have to concatenate Anterior and Posterior temporal


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

% Not only should append complexity together, but also should count the
% number of electrodes in the region for further average.
 

% LZ of the frontal pole
% Use front_p

for i = 1:size(front_p)
    index = find(labels == "E"+string(front_p(i)));
    if isempty(index) == false
        LZ_HGSN(1,:) = LZ_HGSN(1,:) + LZ_electrodes(index,:);
    end
end

     
% LZ of the front
% Use front
for i = 1:size(front)
    index = find(labels == "E"+string(front(i)));
    if isempty(index) == false
        LZ_HGSN(2,:) = LZ_HGSN(2,:) + LZ_electrodes(index,:);
    end
end


% LZ of the Central
% Use cent
for i = 1:size(cent)
    index = find(labels == "E"+string(cent(i)));
    if isempty(index) == false
        LZ_HGSN(3,:) = LZ_HGSN(3,:) + LZ_electrodes(index,:);
    end
end

% LZ of the Anterior and Posterior temporal
% Use anpos
for i = 1:size(anpos)
    index = find(labels == "E"+string(anpos(i)));
    if isempty(index) == false
        LZ_HGSN(4,:) = LZ_HGSN(4,:) + LZ_electrodes(index,:);
    end
end

% LZ of Posterior temporal
% Use pos_tem
%for i = 1:size(LZ_electrodes,2)
    %for j = 1:size(pos_tem)
        %index = find(labels =="E"+string(pos_tem(j)));
        %if index~= 0
            %LZ_HGSN(5,i) = LZ_HGSN(5,i)+LZ_electrodes(index,i);
        %end
    %end
%end


% LZ in Parietal
% Use parie
for i = 1:size(parie)
    index = find(labels == "E"+string(parie(i)));
    if isempty(index) == false
        LZ_HGSN(5,:) = LZ_HGSN(5,:) + LZ_electrodes(index,:);
    end
end

% LZ in Occipital-inion
% Use occi
for i = 1:size(occi)
    index = find(labels == "E"+string(occi(i)));
    if isempty(index)== false
        LZ_HGSN(6,:) = LZ_HGSN(6,:) + LZ_electrodes(index,:);
    end
end


end

