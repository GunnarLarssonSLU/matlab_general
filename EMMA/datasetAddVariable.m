function [ dataset ] = datasetAddVariable( dataset,txtDay,txtVariablename,arrayData )
%DATASETADDVARIABLE Adds a variable txtVariablename, containing the data arrayData  to the dataset of day txtDay 
%   Detailed explanation goes here

id = arrayFindSets( dataset, txtDay)
%append txtVariablename to fielddataheaders 
cellarrayHeaders=dataset.fielddataheaders{id};
cellarrayHeaders=[cellarrayHeaders txtVariablename];
dataset.fielddataheaders{id}=cellarrayHeaders;

%append the data
matrixFielddata=dataset.fielddata{id};
[sx sy]=size(matrixFielddata)
s=length(arrayData);
arrayData=[arrayData;nan(sx-s,1)];          %fill with nans if not of the same length as other data
matrixFielddata=[matrixFielddata arrayData];
dataset.fielddata{id}=matrixFielddata;