function [ arrayOperations ] = arrayDetectActivityPlowing( matrixFielddata,arrayHeaders,matrixFieldborder, txtHeadlandaction)
%ARRAYDETECTACTIVITYPLOWING Returns detected type of operation as an array
%of integers
%   Detailed explanation goes here
%   Input arguments
%       matrixFielddata             matrix with all field data
%       arrayHeaders                array of Cells with the Header names
%       matrixFieldborder           coordinates of the field border (Nx2
%                                   matrix, where every row have the x and
%                                   y coordinate of a point
%       txtHeadlandaction           type of strategy used to drive around
%                                   the field ('loop' or 'around' at the
%                                   moment)

%Read data (corresponding to reference to the right column in Excel)
%X= arrayReadVariable( matrixFielddata,'Easting',arrayHeaders,0 );
%Y= arrayReadVariable( matrixFielddata,'Northing',arrayHeaders,0 );

X= arrayReadVariable( matrixFielddata,'OV',arrayHeaders,0 );
Y= arrayReadVariable( matrixFielddata,'NS',arrayHeaders,0 );

arrayRemove=isnan(X);           %check the data is not a number
COMPARELENGTH=10;               %the "stepsize" used for detections (i.e. comparison will not be done between two values right after one another but between two values separated COMPARELENGTH places. This is done to limit the influence of noise)
l=length(X)-COMPARELENGTH+1;

[in,~] = inpolygon(X,Y,matrixFieldborder(:,1),matrixFieldborder(:,2));  % check if coordinates X,Y are within an area described by matrixFieldborder. If not it is outside the field (and will be considered transport to/from the field)

%remove data that is numbers
%also translates the coordinate system so that origo is at the first
%measuring point (rather than the origo used for the GPS data, making it
%easier to read plotted data)
XX=X;
YY=Y;
XX(arrayRemove)=[];
YY(arrayRemove)=[];
X=X-XX(1);
Y=Y-YY(1);

%array to fill with this function
arrayOperations=zeros(l,1);

%angle of the path relative the coordinate system
arrayAngle=zeros(l,1);
for i=1:l
     dx=X(i+COMPARELENGTH-1)-X(i);  
     dy=Y(i+COMPARELENGTH-1)-Y(i);
     xAngle=atan(dy/dx);
     if (dx<0)
         xAngle=pi+xAngle;
     else
         if (dy<0)
             xAngle=2*pi+xAngle;
         end
     end
     arrayAngle(i)=xAngle;
end

arrayAngle(~in)=nan;    %% to avoid processing as part of line

figure(99)
plot(X,Y);
hold on

%calculate in different ways depending on type of strategy used to drive
%around the field
switch(txtHeadlandaction)
    case 'loop'       
        
        %% START STRAIGHT ROWS
        %find rows over the field where arrayAngle does not deviate by more
        %than 0.03 from the first angle over the field and where the drives
        %over the field include at least 12 elements

        %The values of 0.03 and 12 are from trial and error on an example
        %field, might need to change for other fields and/or drivers
%        arrayOutput = arrayWithinRangeAdv( arrayAngle,0.03,12,X,Y)>0;
        arrayOutput = arrayWithinRangeAdv( arrayAngle,0.06,10,X,Y)>0;
        
        %set the operation for all the values that are within the range to
        %1 (driving over the field)
        arrayOperations(arrayOutput)=1;
        
        plot(X(arrayOutput),Y(arrayOutput),'k*');

        %% STOP STRAIGHT ROWS


        arrayNonRows=1-arrayOutput;                                 %look at the part that is not in rows
        arrayNumberedNonRows = arrayNumberSeries( arrayNonRows );   %give each such stretch a number
        iNonRows=max(arrayNumberedNonRows);                         %count the number of strecthes, to allow for looping
        for i=1:iNonRows
            arrayRun=arrayNumberedNonRows==i;                       %just look at strecth no i
            arrayNos=find(arrayRun);                                %get their position in the entire day's work
            iFirst=min(arrayNos);                                   %want to look at the first position of the strecth
            iLast=max(arrayNos);                                    %..and the last one
            arrayDirectionFirst=arrayAngle(iFirst);                 %want to know their angles
            arrayDirectionLast=arrayAngle(iLast);                   %       -    :    -
            fDirectiondifference=mod(arrayDirectionFirst-arrayDirectionLast,2*pi);  %the difference between the angle in and out
            fAngleComparedToOppositeDirection=abs(pi-fDirectiondifference);         %and how much they differ from being opposite to each other
            if (fAngleComparedToOppositeDirection<(pi/4)) %is turn if direction in is different from direction out
                arrayOperations(arrayRun)=2;    %% 180 degree turn
                plot(X(arrayRun),Y(arrayRun),'r*');
            else
                if (fAngleComparedToOppositeDirection>(3*pi/4)) %is turn if direction in is different from direction out
                    arrayOperations(arrayRun)=1;  %% action before continuing forward
    %                arrayOperations(arrayRun)=3;  %% action before continuing forward
    %                plot(X(arrayRun),Y(arrayRun),'g*');
                    plot(X(arrayRun),Y(arrayRun),'k*');
                else
%                    arrayOperations(arrayRun)=4;  %% turn
%                    plot(X(arrayRun),Y(arrayRun),'g*');
                    arrayOperations(arrayRun)=1;  %% turn
                    plot(X(arrayRun),Y(arrayRun),'k*');
                end
            end
        end
    case 'around'
        %find rows over the field where arrayAngle does not deviate by more
        %than 0.15 from the first angle over the field and where the drives
        %over the field include at least 12 elements
        
        %The values of 0.15 and 12 are from trial and error on an example
        %field, might need to change for other fields and/or drivers
        arrayOutput = arrayWithinRangeAdv( arrayAngle,0.15,12,X,Y)>0;

        %set the operation for all the values that are within the range to
        %1 (driving over the field)        
        arrayOperations(arrayOutput)=1;
        plot(X(arrayOutput),Y(arrayOutput),'k*-');
        hold on
                
        arrayNonRows=1-arrayOutput;                                 %look at the part that is not in rows
        arrayNumberedNonRows = arrayNumberSeries( arrayNonRows );   %give each such stretch a number
        iNonRows=max(arrayNumberedNonRows);                         %count the number of strecthes, to allow for looping
        for i=1:iNonRows
            arrayRun=arrayNumberedNonRows==i;                       %just look at strecth no i
            arrayNos=find(arrayRun);                                %get their position in the entire day's work
            iFirst=min(arrayNos);                                   %want to look at the first position of the strecth
            iLast=max(arrayNos);                                    %..and the last one
            arrayDirectionFirst=arrayAngle(iFirst);                 %want to know their angles
            arrayDirectionLast=arrayAngle(iLast);                   %       -    :    -
            fDirectiondifference=mod(arrayDirectionLast-arrayDirectionFirst,2*pi);  %the difference between the angle in and out
            i
            if (fDirectiondifference>(pi/2-0.5) && fDirectiondifference<(pi/2+0.5) ) %is turn if direction in is different from direction out
                arrayOperations(arrayRun)=2;    %% 90 degree turn
                plot(X(arrayRun),Y(arrayRun),'r*');
            else
                arrayOperations(arrayRun)=3;    %% other
                plot(X(arrayRun),Y(arrayRun),'g*');
            end
            pause
        end
end
rpm= arrayReadVariable( matrixFielddata,'EngineSpeed',arrayHeaders,0 );
%rpm= arrayReadVariable( matrixFielddata,'motorvarv',arrayHeaders,0 );
idle=(rpm<=830) & (rpm>0);
arrayOperations(idle)=5;
plot(X(idle),Y(idle),'y*');
off=rpm==0;
arrayOperations(off)=6;
plot(X(off),Y(off),'y*');

arrayOperations(~in)=7; %road and other things outside of fields
plot(X(~in),Y(~in),'b+');

end