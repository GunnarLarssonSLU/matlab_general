function [dist, angle]=GetAngle3(x,y)
%[dist angle]=GETANGLE(x,y) converts x and y into polar coordinates

dist=sqrt(x.*x+y.*y);
[s1 s2]=size(x);
angle=zeros(s1,s2);
if (s1==0)
    dist=[];
    angle=[];
else
    for a=1:s1
        for b=1:s2
        if (dist(a,b)>0)
            angle(a,b)=asin(y(a,b)./dist(a,b));
                if (~(dist(a,b)>0))
                    angle(a,b)=0;
                end
                if (x(a,b)<0) 
                    angle(a,b)=pi-angle(a,b);
                end
                if (angle(a,b)<0) 
                    angle(a,b)=2*pi+angle(a,b);
                end
                if ((x(a,b)==0) && (y(a,b)==0))
                    angle(a,b)=0;
                end
            else
                angle(a,b)=0;
            end
        end
    end 
end
