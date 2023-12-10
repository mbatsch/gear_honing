function [xt yt zt] = transverse(xNN, yNN, zNN)
zA=0;
rozm=size(xNN);
imax=rozm(1);
jmax=rozm(2);
k=1;
for j=1:jmax+1;
    for i=1:imax;
        if j<jmax
            if zA>=zNN(i,j) && zA<=zNN(i,j+1)
                x1=xNN(i,j);
                y1=yNN(i,j);
                z1=zNN(i,j);
                x2=xNN(i,j+1);
                y2=yNN(i,j+1);
                z2=zNN(i,j+1);

                xt(k)=(zA-z1)/(z2-z1)*(x2-x1)+x1;
                yt(k)=(zA-z1)/(z2-z1)*(y2-y1)+y1;
                zt(k)=zA;
                flag=1;
                k=k+1;
            else

            end
        end
    end
end

end

