function [ arrayData ] = matrixEfficiency( arrayHeaders,matrixData )
%MATRIXEFFICIENCY Calculates the engine efficiency from EMMA-data
    in= arrayReadVariable( matrixData,'power_fuel',arrayHeaders,10 );
    out= arrayReadVariable( matrixData,'power_engine',arrayHeaders,10 );
    arrayData=out./in;
end

