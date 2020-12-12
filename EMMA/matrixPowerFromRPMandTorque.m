function [ arrayData ] = matrixPowerFromRPMandTorque( arrayHeaders,matrixData )
%MATRIXPOWERFROMRPMANDTORQUE Calculates power from the engine (from rpm & torque) from EMMA-data

    rpm= arrayReadVariable( matrixData,'motorvarv',arrayHeaders,10 );
    torque= arrayReadVariable( matrixData,'vevaxelmoment ',arrayHeaders,10 );
    arrayData=2*pi*rpm.*torque/60;
end

