function [ arrayReturn ] = arrayNumberSeries( arrayInputseries )
%ARRAYNUMBERSERIES Summary of this function goes here
%   Detailed explanation goes here
   l1=length(arrayInputseries)
   
   %Fill and return an array of the same size as the original array
   arrayReturn=zeros(l1,1);
   
   %Fill an array with ones if the original array increased at that
   %location, zeros otherwise
   arrayChangesBinary=[0;diff(arrayInputseries)>0];
   
   %Find the location of the ones
   arrayChanges=find(arrayChangesBinary);
   
   %l2 = number of locations where arrayInputseries increased
   l2=length(arrayChanges);
   
   %loop through all positions where the original array increased
   for b=1:l2
       %from that position and onwards increase the value of the return
       %array with one (i.e. after a number of iterations it will develop
       %something like:
       %[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
       %[0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
       %[0 0 1 1 1 1 2 2 2 2 2 2 2 2 2 2]
       %[0 0 1 1 1 1 2 2 3 3 3 3 3 3 3 3]
       %
       %If arrayChanges starts with the values 2 6 8      
       arrayReturn(arrayChanges(b):l1)=arrayReturn(arrayChanges(b):l1)+1;
   end
   arrayReturn=arrayReturn.*arrayInputseries;
end

