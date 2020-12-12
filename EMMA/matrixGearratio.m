function [ arrayData ] = matrixGearratio( arrayHeaders,matrixData )
%MATRIXGEARRATION Calculates gear ratio from EMMA-data
    hjul= arrayReadVariable( matrixData,'hjul',arrayHeaders,0 );
    motorvarv= arrayReadVariable( matrixData,'motorvarv',arrayHeaders,0 );
    arrayData=(1000*hjul/3600)./(motorvarv/60);
end

