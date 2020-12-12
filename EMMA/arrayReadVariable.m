function [ arrayData ] = arrayReadVariable( arrayData,txtVariablename,arrayHeaders,iWindowsize )
%ARRAYREADVARIABLE Reads (already imported) EMMA data
%   Detailed explanation goes here
%   arrayData           the data (imported)
%   txtVariablename     name of the variable for which data will be
%                       extracted
%   arrayHeaders        imported variable headers
%   iWindowsize         window size (for filtering)


    %find the column associated with the variablename
    %strcmp returns an array which is 1 if the elements match and 0
    %otherwise, find returns the position of the ones, i.e. the position of the right column. 
    iColumn=strcmp(txtVariablename,arrayHeaders);
    if (isempty(find(iColumn)))
        msgID = 'arrayReadVariable:incorrectVariablename';
        msg = ['No header with the chosen txtVariablename (' txtVariablename ') exists.'];
        throw(MException(msgID,msg));
    end

    %Read data for the column
    arrayData=arrayData(:,iColumn);
    if (isempty(find(arrayData)))
        msgID = 'arrayReadVariable:emptyDataset';
        msg = 'The wanted dataset contains no useful data (only zeros).';
        throw(MException(msgID,msg));
    end
    
    %apply filter if a window size has been given
    if (iWindowsize) 
        a=1;
        b=ones(1,iWindowsize)/iWindowsize;
        arrayData=filter(b,a,arrayData);
    end
end

