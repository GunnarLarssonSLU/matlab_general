function [dataset]=LoadEMMAData(startfolder,datafile)
%läs excelfil för tillgängliga mätningar + info om mätningar
[num,txt,raw]=xlsread(datafile);
[sx sy]=size(txt);
headers=txt(1,:)';
info=raw(2:sx,:)
dataset=struct();
dataset.arrayHeaders=headers;
dataset.info=info;
dataset.iFieldtests=sx-1;
fielddataheaders=cell(dataset.iFieldtests,1);
fielddata=cell(dataset.iFieldtests,1);
for a=1:dataset.iFieldtests
    letter=dataset.info{a,3};
    day=dataset.info{a,4};
    %txtFilename=[startfolder '\fielddata\' day '\' day letter '.xlsx']
    txtFilename=[startfolder '\fielddata\' day '\' day '.xlsx']
    [num,txt,raw]=xlsread(txtFilename);
    [~,iHeaders]=size(txt);
    [~,iHeaders2]=size(num);
    if (iHeaders~=iHeaders2)
        [iHeaders iHeaders2]
        'Data and headers to not match - check!'
        pause
    end
    
%    fielddataheaders{a}=txt(1,2:iHeaders);
    fielddataheaders{a}=txt(1,:);
    fielddata{a}=num;
%    fielddata{a}=raw;
end
dataset.fielddataheaders=fielddataheaders;
dataset.fielddata=fielddata;
%få tag på filnamn i foldern
%ladda radhuvud till radhuvudsmatris
%ladda fil till databmatris

