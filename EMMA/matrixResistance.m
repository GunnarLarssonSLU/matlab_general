function [ arrayData ] = matrixResistance( arrayHeaders,matrixData )
%MATRIXRESISTANCE Calculates resistance from EMMA-data
    torque= arrayReadVariable( matrixData,'vevaxelmoment ',arrayHeaders,10 );
    gr= arrayReadVariable( matrixData,'gearratio',arrayHeaders,10 );
    arrayData=torque./gr;

end

