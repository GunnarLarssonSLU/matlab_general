function [ matrixValues ] = arrayISOValues( structsBiogas,structsBiogasVariable,txtVariableName,minRPM,nominalRPM,maxRPM,maxTorque_nominalRPM,maxTorque_maxRPM )
%ARRAYISOVALUES Estimates value of a chosen engine variable (such as
%exhaust) at the ISO8178 torques and rpms, based on measurement from
%'structBiogas'
%   structsBiogas           struct containing data on rpm (K_16_n_FR)
%                           and torque (K_15_M_FR) 
%   structsBiogasVariable   struct containg data on engine output
%   txtVariableName         name of the variable within the struct
%   minRPM,
%   nominalRPM,
%   maxRPM,
%   maxTorque_nominalRPM,
%   maxTorque_maxRPM        Engine data


ISO8178.torque=maxTorque_maxRPM*0.01*[100 	75 	50 		10 0 0 0 0]+maxTorque_nominalRPM*0.01*[0 0 0 0 100 	75 	50 	0]+[0 0 0 0 0 0 0 100];
ISO8178.rpm=[maxRPM maxRPM maxRPM maxRPM nominalRPM nominalRPM nominalRPM minRPM];

matrixValues=zeros(8,5);    % Not sure why 5..
for i=1:5
    arrayEngineRPM=structsBiogas(i).K_16_n_FR;
    arrayEngineTorque=structsBiogas(i).K_15_M_FR;
    arrayEngineVariable=structsBiogasVariable(i).(txtVariableName);
    matrixValues(:,i) = griddata(arrayEngineRPM,arrayEngineTorque,arrayEngineVariable,ISO8178.rpm,ISO8178.torque);
end

