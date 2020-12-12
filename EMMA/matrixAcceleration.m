function [ arrayData ] = matrixAcceleration( arrayHeaders,matrixData )
%MATRIXACCELERATION Calculates acceleration from EMMA-data

radar= arrayReadVariable( matrixData,'radar',arrayHeaders,10 );
    arrayData=[0;diff(radar)];
end

