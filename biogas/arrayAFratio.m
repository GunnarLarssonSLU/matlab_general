function [ arrayReturn ] = arrayAFratio( arrayAir,arrayFuel )
%arrayAFratio Calculates air/fuel-ratio using filtered data for mass of air
%and mass of fuel
    LENGTH=10;
    arrayReturn=filter(ones(1,LENGTH)/LENGTH,1,arrayAir)./filter(ones(1,LENGTH)/LENGTH,1,arrayFuel);
end

