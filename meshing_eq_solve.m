load data.mat

tetak=b/r*tan(Beta)/2;
tetap=-tetak;

global a sigma zN z H fisym rb Cmt Cma Cmf
global teta t
global rfor rfo raeff rar

k=1;
fiNp=0;
j=1;
Nteta=36;
dteta=(tetak-tetap)/(Nteta-1);
Nt=30;
dt=(ta-tfo)/(Nt-1);
for teta=tetap:dteta:tetak;
    for t=tfo:dt:ta+0.05;  %było dt 001

        fiNO=0;
        lpO=0;
        x0 = [fiNO,lpO];
        options=optimset('Display','iter','MaxFunEvals',200,'MaxIter',200,'Algorithm','levenberg-marquardt');

        x=rb*(cos(t)+t*sin(t));
        y=-rb*(sin(t)-t*cos(t));
        ry=sqrt(x^2+y^2);
        if ry<=rfor
            Cmy=(rfor-ry)*(Cmf-Cmt)/(rfor-rfo)+Cmt;
            [x,fval] = fsolve(@row_zaz_1,x0,options);
        else
            if ry>=rar
                Cmy=(ry-rar)*(Cma-Cmt)/(raeff-rar)+Cmt;
                [x,fval] = fsolve(@row_zaz_2,x0,options);
            else
                Cmy=Cmt;
                [x,fval] = fsolve(@row_zaz_3,x0,options);
            end
        end

        fiN=x(1);
        lp=x(2);
        FIN(i,j)=fiN;
        LP(i,j)=lp;
        FIK(i,j)=fiN*zN/z;
        TETA(i,j)=teta;
        T(i,j)=t;
        fik=fiN*zN/z;
        deltafiN=lp*2*pi/H;

        rNN=[(cos((fiN*zN)/z + (2*lp*pi)/H)*cos(fiN) - sin((fiN*zN)/z + (2*lp*pi)/H)*cos(sigma)*sin(fiN))*(Cmy*sin(fisym - t + teta) + rb*cos(fisym - t + teta) - rb*t*sin(fisym - t + teta)) - (sin((fiN*zN)/z + (2*lp*pi)/H)*cos(fiN) + cos((fiN*zN)/z + (2*lp*pi)/H)*cos(sigma)*sin(fiN))*(rb*sin(fisym - t + teta) - Cmy*cos(fisym - t + teta) + rb*t*cos(fisym - t + teta)) - a*cos(fiN) + lp*sin(fiN)*sin(sigma) + (H*teta*sin(fiN)*sin(sigma))/(2*pi);
            (cos((fiN*zN)/z + (2*lp*pi)/H)*sin(fiN) + sin((fiN*zN)/z + (2*lp*pi)/H)*cos(fiN)*cos(sigma))*(Cmy*sin(fisym - t + teta) + rb*cos(fisym - t + teta) - rb*t*sin(fisym - t + teta)) - (sin((fiN*zN)/z + (2*lp*pi)/H)*sin(fiN) - cos((fiN*zN)/z + (2*lp*pi)/H)*cos(fiN)*cos(sigma))*(rb*sin(fisym - t + teta) - Cmy*cos(fisym - t + teta) + rb*t*cos(fisym - t + teta)) - a*sin(fiN) - lp*cos(fiN)*sin(sigma) - (H*teta*cos(fiN)*sin(sigma))/(2*pi);
            lp*cos(sigma) + cos((fiN*zN)/z + (2*lp*pi)/H)*sin(sigma)*(rb*sin(fisym - t + teta) - Cmy*cos(fisym - t + teta) + rb*t*cos(fisym - t + teta)) + sin((fiN*zN)/z + (2*lp*pi)/H)*sin(sigma)*(Cmy*sin(fisym - t + teta) + rb*cos(fisym - t + teta) - rb*t*sin(fisym - t + teta)) + (H*teta*cos(sigma))/(2*pi);
            1];
        xNN(i,j)=rNN(1);
        yNN(i,j)=rNN(2);
        zNN(i,j)=rNN(3);

        k=k+1;
        i=i+1;
    end
    i=1;
    j=j+1;
end

figure
surf(xNN,yNN,zNN,'FaceColor','green','MeshStyle','column')
hold on
grid on
axis equal

i=1;
j=1;
for par=0:0.1:2*pi;
    for dl=0:20;
        okrN=[rN*cos(par);rN*sin(par);dl;1];
        xokrN(i,j)=okrN(1);
        yokrN(i,j)=okrN(2);
        zokrN(i,j)=okrN(3);
        i=i+1;
    end
    i=1;
    j=j+1;
end

figure
surf(xNN,yNN,zNN,'FaceColor','green','MeshStyle','column')
hold on
surf(xokrN,yokrN,zokrN,'FaceColor','green','MeshStyle','column')
surf(xokrkN,yokrkN,zokrkN,'FaceColor','red','MeshStyle','column')
hold off
grid on
axis equal

figure
surf(T,TETA,FIN,'FaceColor','blue')
xlabel('t')
ylabel('teta')
zlabel('fiN')

figure
surf(T,TETA,LP,'FaceColor','blue')
xlabel('t')
ylabel('teta')
zlabel('lp')

save T.mat T
save TETA.mat TETA
save FIN.mat FIN
save LP.mat LP

save X.mat xNN
save Y.mat yNN
save Z.mat zNN



