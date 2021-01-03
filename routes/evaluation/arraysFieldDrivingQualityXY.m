function [ arrayStraightness,arrayAngles,arrayDistances ] = arraysFieldDrivingQualityXY( Xcell,Ycell)
%ARRAYSFIELDSDRIVINGQUALITY Asses how straight the pahts over a field are based on various methods
%Need to add comments!

LENGTH=length(Xcell);

arrayStraightness=zeros(LENGTH,1);
arrayAngles=zeros(LENGTH,1);
arrayDistances=zeros(LENGTH-1,1);
arrayCoefs=zeros(LENGTH,5);

for a=1:LENGTH
    X = Xcell{a};
    Y = Ycell{a};
    [linearCoef,S] = polyfit(X,Y,1);                
    arrayCoefs(a,:)=[linearCoef min(X) max(X) min(Y)];
    arrayAngles(a)=atan(linearCoef(1));
    [linearFit,delta] = polyval(linearCoef,X,S);
    arrayStraightness(a)=mean(delta);
end

%Total driven distance
for b=1:LENGTH-1
    X2A=arrayCoefs(b,4);                % max
    X1A=arrayCoefs(b,3);                % min
    slopeA=arrayCoefs(b,1);             % slope
    Y1A=arrayCoefs(b,2)+X1A*slopeA;     % y @ x-min
    Xpos=(X1A+X2A)/2;                   % middle-x
    Ypos=Y1A+(Xpos-X1A)*slopeA;         % middle-y
    slopeB=-1/slopeA;                   % perpendicular slope
    Y1B=-(slopeB*Xpos-Ypos);            

    X2C=arrayCoefs(b+1,4);
    X1C=arrayCoefs(b+1,3);
    slopeC=arrayCoefs(b+1,1);
    Y1C=arrayCoefs(b+1,2)+X1C*slopeC;
    Y1Cq=arrayCoefs(b+1,2);
  
    XX=(Y1Cq-Y1B)/(slopeB-slopeC);
    YY=(slopeB*(XX))+Y1B;
    arrayDistances(b)=sqrt((XX-Xpos)^2+(YY-Ypos)^2);
end
end

