function [fEnergy_kWh_kg]=fPressurize(structProduction,structGas,structCompressor)
%FPRESSUREIZE Calculates the energy needed to pressurise gas
p_in=structProduction.fPressure;
p_out=structGas.fPressure;
MW=0.016;                   %Molecular weight of methane
R=8.31/MW;
n=1.3;                      %
T_in=298.15;                %Assumed temperature in
flow_mol_h=101325*structCompressor.flow_nm3_h/(8.31*298.15);    %Flow in mol/h
flow_mol_s=flow_mol_h/3600;                                     %Flow in mol/s
flow_kg_s=flow_mol_s*MW;                                        %Flow in kg/s
n=1.307*structGas.CH4.fShare+1.304*(1-structGas.CH4.fShare);
tmp1=(n-1)/n;
tmp2=1-((p_out/p_in)^tmp1);
fPower_W=-structCompressor.iSteps*flow_kg_s*R*T_in*tmp2/tmp1;
fEnergy_J_kg=fPower_W/flow_kg_s;
fEnergy_kWh_kg=fEnergy_J_kg/3600000;
