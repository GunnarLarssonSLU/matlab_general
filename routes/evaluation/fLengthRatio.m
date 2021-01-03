function [ fRatio,fLengthAsaBird,fAngle,fLRMSE ] = fLengthRatio( Xs,Ys )
%FLENGTHRATIO Rate between driven distance and distance as the bird flies
%   Detailed explanation goes here
%   fRatio                          Kvot mellan körd längd och längd
%                                   fågelvägen
%   fLengthAsaBird                  Längd mellan start och slutpunkt,
%                                   fågelvägen
%   fAngle                          Vinkel på linjen
%   fLRMSE                          RMS-värde för körvinkel (relativt
%                                   vinkel på linjen)

%Remove cases when the tractor is not moving
notok=find(1-(diff(Xs) | diff(Ys)));
Xs(notok+1)=[];
Ys(notok+1)=[];

iLast=length(Xs);

%Driven distance for each segment
arrayLengthParts(1:iLast-1,1)=sqrt((Xs(2:iLast)-Xs(1:iLast-1)).^2+(Ys(2:iLast)-Ys(1:iLast-1)).^2);
%Total driven distance
fTotalLength=sum(arrayLengthParts);

%Distance and angle between last and first items
[fLengthAsaBird,fAngle]=GetAngle(Xs(iLast)-Xs(1),Ys(iLast)-Ys(1));
%Radio between total driven distance and distance between first and last
%item
fRatio=fTotalLength/fLengthAsaBird;
%Angle between each segment
[~,arrayAngles]=GetAngle(diff(Xs),diff(Ys));
%Make sure that the angles are "smooth" (do not jump by pi)
arrayAngles=arrayAnglesContinuousWithMean(arrayAngles,fAngle);
%Remove the mean
arrayAngles=arrayAngles-fAngle;
%Get the root mean square of the angles
fLRMSE=sqrt(sum(arrayAngles.^2)/(iLast-1));
%Make sure the angle for the entire line is -pi < value < pi
fAngle=mod(fAngle,pi);
end