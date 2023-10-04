% Function for calculating LZ from EEG electrodes
% Input is the clean dataset for subject with his/her ID, calling EEG.data
% Input is the EEG struct data
% Output is a nchan*nepoch array of LZ measure 

function LZ_electrodes = LZ_elect(EEG)

% Add the working directory
workdir = '/rds/project/tb419/rds-tb419-bekinschtein/Yingge/Scripts/';
addpath(workdir);
%Input is the EEG struct data

% Retrieve parameters to input in the for-loop
% nelecs is the number of electrodes
% spoint is the sampling points
% nepochs is the number of epochs
[nelecs,spoints,nepochs] = size(EEG.data);

% Initiate the output array
LZ_electrodes = zeros(nelecs,nepochs);

% Initializing LZ76
%mex COPTIMFLAGS="-O3" LZ76.c;

% Enter the large for-loop
for epoch = 1:nepochs % Enter the epoch loop
    for electrode = 1:nelecs % Enter the electrode loop
        sampling = EEG.data(electrode,1:spoints,epoch);
        result = zeros(1,spoints);
        average = mean(sampling);
        for index = 1:spoints % Change the sampling points into logicals
            if sampling(1,index) < average
                result(1,index) = 0; % Create a new result matrix instead
            else
                result(1,index) = 1;
            end
        end
        samplogi = logical(result);
        LZ_electrodes(electrode,epoch) = LZ76(samplogi)*log2(spoints)/spoints; % Get normalised LZ according to Pedro
    end
end


% Ending the function
% Returns a 96*480 array of normalised LZ measure
end
