function [ cellArrays ] = datasetReadVariable( dataset, txtVariablename,iWindowsize)
%DATASETREADVARIABLE Reads and filter a variable from a dataset
%   dataset             dataset containing all information
%   txtVariablename     name of the variable
%   iWindowsize         size of the filtering window

cellArrays=cell(dataset.iFieldtests,1); 

%b = (1/iWindowsize)*ones(1,iWindowsize);
%a=1;
for c=1:dataset.iFieldtests
    arrayHeaders=dataset.fielddataheaders{c};
    arrayData = arrayReadVariable( dataset.fielddata{c},txtVariablename,arrayHeaders,iWindowsize );
    cellArrays{c}=arrayData;
end