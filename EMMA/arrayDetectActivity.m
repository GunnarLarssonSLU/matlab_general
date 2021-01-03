function [ arrayOperations ] = arrayDetectActivity( dataset,txtDay, txtHeadlandaction )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
id = arrayFindSets( dataset, txtDay);
arrayHeaders=dataset.fielddataheaders{id};
matrixData=dataset.fielddata{id};
txtOperation=dataset.info{id,1};
switch txtOperation
    case 'harv'
        arrayOperations = arrayDetectActivityPlowing( matrixData,arrayHeaders, txtHeadlandaction );
    case 'plog'
        arrayOperations = arrayDetectActivityPlowing( matrixData,arrayHeaders, txtHeadlandaction );
    case 'direktsåmaskin'
        arrayOperations = arrayDetectActivityPlowing( matrixData,arrayHeaders, txtHeadlandaction );
    case 'Fastgödselspridare'
        arrayOperations = arrayDetectActivityPlowing( matrixData,arrayHeaders, txtHeadlandaction );
    case 'Urinspridare'
        arrayOperations = arrayDetectActivityPlowing( matrixData,arrayHeaders, txtHeadlandaction );
    case '?'
        arrayOperations = arrayDetectActivityPlowing( matrixData,arrayHeaders, txtHeadlandaction );
end

