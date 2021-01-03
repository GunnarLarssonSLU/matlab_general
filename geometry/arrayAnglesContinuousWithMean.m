function [ arrayAngle ] = arrayAnglesContinuousWithMean( arrayAngle,fAngle )
%ARRAYANGLESCONTINUOUS Returns a smooth curve of angles (i.e. one that does not jump by pi 
%arrayAngle     Angle for each semgent
%fAngle         Angle for entire line (last-first element)

la=length(arrayAngle);
for i=1:la
    da=arrayAngle(i)-fAngle;                    % change
    if (da>pi)
        arrayAngle(i)=arrayAngle(i)-2*pi;
    else
        if (da<(-pi))
            arrayAngle(i)=arrayAngle(i)+2*pi;
        end
    end
end