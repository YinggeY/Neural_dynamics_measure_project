% Function for adding LZ for specific brain region divisions
% Input is nchan*nepochs temporal LZ measures
% Output is 6*nepochs LZ measures for 6 brain regions
% Following GSN division of electrodes

function LZ_GSN = GSN_LZ(LZ_electrodes,labels)


LZ_GSN = zeros(6,size(LZ_electrodes,2));% Not 7 since we have to concatenate an_tem and pos_tem


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

% Not only should append complexity together, but also should count the
% number of electrodes in the region for further average.
 

% LZ of the frontal pole
% Use front_p
for i = 1:size(LZ_electrodes,2)
    for j = 1:size(front_p)
        index = find(labels =="E"+string(front_p(j)));
        if index~= 0
            LZ_GSN(1,i) = LZ_GSN(1,i)+LZ_electrodes(index,i);
        end
    end
end

     
% LZ of the front
% Use front
for i = 1:size(LZ_electrodes,2)
    for j = 1:size(front)
        index = find(labels =="E"+string(front(j)));
        if index~= 0
            LZ_GSN(2,i) = LZ_GSN(2,i)+LZ_electrodes(index,i);
        end
    end
end

% LZ of the Central
% Use cent
for i = 1:size(LZ_electrodes,2)
    for j = 1:size(cent)
        index = find(labels =="E"+string(cent(j)));
        if index~= 0
            LZ_GSN(3,i) = LZ_GSN(3,i)+LZ_electrodes(index,i);
        end
    end
end


% LZ of the Anterior & Posterior temporal
% Use an_tem
for i = 1:size(LZ_electrodes,2)
    for j = 1:size(anpos)
        index = find(labels =="E"+string(anpos(j)));
        if index~= 0
            LZ_GSN(4,i) = LZ_GSN(4,i)+LZ_electrodes(index,i);
        end
    end
end


% LZ of Posterior temporal
% Use pos_tem
%for i = 1:size(LZ_electrodes,2)
   %for j = 1:size(pos_tem)
        %index = find(labels =="E"+string(pos_tem(j)));
        %if index~= 0
           % LZ_GSN(5,i) = LZ_GSN(5,i)+LZ_electrodes(index,i);
        %end
    %end
%end


% LZ in Parietal
% Use parie
for i = 1:size(LZ_electrodes,2)
    for j = 1:size(parie)
        index = find(labels =="E"+string(parie(j)));
        if index~= 0
            LZ_GSN(5,i) = LZ_GSN(5,i)+LZ_electrodes(index,i);
        end
    end
end


% LZ in Occipital-inion
% Use occi
for i = 1:size(LZ_electrodes,2)
    for j = 1:size(occi)
        index = find(labels =="E"+string(occi(j)));
        if index~= 0
            LZ_GSN(6,i) = LZ_GSN(6,i)+LZ_electrodes(index,i);
        end
    end
end



end

