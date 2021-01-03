function [ dataset ] = datasetNumberActivities( dataset,txtDay )
%UNTITLED Summary of this function goes here

%   Read the activity of the day
arrayActivity = arrayReadVariableDay(dataset,txtDay,'activity',0);
iActivities=max(arrayActivity);

%Loop through all types of activities
for a=1:iActivities
    %Find elements during which activity a takes place (arrayActivity==a)
    %and number them using arrayNumberSeries
    arrayNumbered = arrayNumberSeries( arrayActivity==a);
    %Add the resulting array to the dataset and give it the name ['activityno' num2str(a)]
    dataset=datasetAddVariable(dataset,txtDay,['activityno' num2str(a)],arrayNumbered);
end


end

