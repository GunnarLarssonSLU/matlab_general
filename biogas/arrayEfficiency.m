function [ arrayReturn ] = arrayEfficiency( arrayEnergyIn,arrayEnergyOut )
%ARRAYEFFICIENCY Calculates engine efficiency based on filtered data on energy in and out
    LENGTH=20;
    arrayReturn=filter(ones(1,LENGTH)/LENGTH,1,arrayEnergyOut)./filter(ones(1,LENGTH)/LENGTH,1,arrayEnergyIn);
end


