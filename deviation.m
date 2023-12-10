function [odl diam xc yc XN YN] = deviation(xt,yt,xewN,yewN)

global fisymN;
global rbN;
x=xt;
y=yt;
delyN = diff(yewN);
delxN = diff(xewN);

k=1;
for j=1:length(xewN)-1;
    for i=1:length(xt)-1;
        a=-1/(delyN(j)/delxN(j));
        b=yewN(j)-a*xewN(j);

        if y(i)<=a*x(i)+b && y(i+1)>=a*x(i+1)+b
            c=(y(i)-y(i+1))/(x(i)-x(i+1));
            d=y(i)-c*x(i);
            xC=(d-b)/(a-c);
            yC=c*xC+d;

            f=xC*cos(pi+fisymN-sqrt(xC^2+yC^2-rbN^2)/rbN)+yC*sin(pi+fisymN-sqrt(xC^2+yC^2-rbN^2)/rbN)-rbN;
            if f>0
                odl(k)=sqrt((xC-xewN(j))^2+(yC-yewN(j))^2);
            else
                odl(k)=-sqrt((xC-xewN(j))^2+(yC-yewN(j))^2);
            end

            diam(k)=2*sqrt(xewN(j)^2+yewN(j)^2);
            xc(k)=xC;
            yc(k)=yC;
            XN(k)=xewN(j);
            YN(k)=yewN(j);
            K(k)=k;
            k=k+1;
        else
        end
    end
end

end

