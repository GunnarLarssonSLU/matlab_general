function [ arrayData ] = matrixPowerFromFuel( arrayHeaders,matrixData )
%MATRIXPOWERFROMFUEL Calculates power to the engine (from the fuel) from EMMA-data

    fuel= arrayReadVariable( matrixData,'bränsleförbr',arrayHeaders,10 );
    fDensity=0.8;               % Values for Diesel
    fEnergydensity=46.2e6;      % Values for Diesel
    arrayData=fuel*fDensity*0.001*fEnergydensity;
end

