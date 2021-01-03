function [ cellArraysRadar,cellArraysHjulhastighet,cellArraysKardan ] = structAnalyseVelocity( dataset,txtActivity,fMass )
%STRUCTANALYSEVELOCITY Calculates the velocity in various ways

[ cellArraysRadar ] = datasetReadVariable( dataset, 'radar',15);
[ cellArraysHjulhastighet ] = datasetReadVariable( dataset, 'hjulhastighet',15);
[ cellArraysKardan ] = datasetReadVariable( dataset, 'kardan ',15);
[ cellArraysTransmission ] = datasetReadVariable( dataset, 'utväxlingsförhållande ');

arraySets = arrayFindSets( dataset, txtActivity);
iSets=length(arraySets);
cellArraysRadar=cellArraysRadar(arraySets);
cellArraysHjulhastighet=cellArraysHjulhastighet(arraySets);
cellArraysKardan=cellArraysKardan(arraySets);
cellArraysDVRadar=cell(iSets,1);
cellArraysDVHjulhastighet=cell(iSets,1);
cellArraysDVKardan=cell(iSets,1);
for a=1:iSets
   dvRadar=diff(cellArraysRadar{a});
   cellArraysDVRadar{a}=dvRadar; 
   cellArraysDVRadar{a}=dvRadar*fMass; 
   dvHjulhastighet=diff(cellArraysHjulhastighet{a});
   cellArraysDVHjulhastighet{a}=dvHjulhastighet; 
   cellArraysDVHjulhastighet{a}=dvHjulhastighet*fMass; 
   dvKardan=diff(cellArraysKardan{a});
   cellArraysDVKardan{a}=dvKardan; 
   cellArraysDVKardan{a}=dvKardan*fMass; 
end

