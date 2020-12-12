function [ arrayData ] = matrixSlip( arrayHeaders,matrixData )
%MATRIXSLIP Calculates wheel slip from EMMA-data
    hjul= arrayReadVariable( matrixData,'kardan ',arrayHeaders,0 );
    radar= arrayReadVariable( matrixData,'radar',arrayHeaders,0 );
    arrayData=(hjul-radar)./hjul;
end

