load data.mat

global fisymN;
global rbN;

load X.mat
load Y.mat
load Z.mat

% --- Transverse section of tool surface of action

[xt yt zt] = transverse(xNN, yNN, zNN);
Wt=[xt;yt;zt]';
Wtsort=sortrows(Wt,2);
xt=Wtsort(:,1);
yt=Wtsort(:,2);
zt=Wtsort(:,3);

figure
plot(xt,yt,'-k','Linewidth',1.5)
hold on
fi=(180-5)*pi/180:0.001:(180+5)*pi/180;
plot(dN/2*cos(fi),dN/2*sin(fi),'-.k')
hold on
plot(dfoN/2*cos(fi),dfoN/2*sin(fi),'-k')
hold on
plot(daefN/2*cos(fi),daefN/2*sin(fi),'-k')
hold on
plot(darN/2*cos(fi),darN/2*sin(fi),'-k')
hold on
plot(dforN/2*cos(fi),dforN/2*sin(fi),'-k')
title('przekroj czolowy powierzchni dzia豉nia')
grid on
axis equal

% --- Unmodified involute of tool

snN=en;
enN=sn;
stN=snN/cos(BetaN);
etN=enN/cos(BetaN);
fisymN=gammatN+stN/rN/2;

alfataN=acos(dbN/daefN);
gammataN=tan(alfataN)-alfataN;
taefN=gammataN+alfataN;

alfatfoN=acos(dbN/dfoN);
gammatfoN=tan(alfatfoN)-alfatfoN;
tfoN=gammatfoN+alfatfoN;

tN=tfoN:0.0001:taefN;
xewN=rbN*(cos(tN)+tN.*sin(tN));
yewN=-rbN*(sin(tN)-tN.*cos(tN));
rsymN=rot2na2(pi)*rot2na2(fisymN)*[xewN;yewN];
xewN=rsymN(1,:);
yewN=rsymN(2,:);

figure
plot(xewN,yewN,'-r')
title('czysta ewolwenta narzedzia')
grid on
axis equal
hold on
[X,Y,Z] = cylinder(rfoN,100);
surf(X,Y,bN*Z-bN/2);

% --- Deviation

[odl diam xc yc XN YN] = dev(xt,yt,xewN,yewN);
figure
plot(odl/0.001,diam,'-')

% --- Visualisation of transverse profiles

figure
plot(xt,yt,'-r')
hold on
plot(xewN,yewN,'-b')
grid on
axis equal
hold on
fi=(180-5)*pi/180:0.001:(180+5)*pi/180;
plot(dfoN/2*cos(fi),dfoN/2*sin(fi))
hold on
plot(daefN/2*cos(fi),daefN/2*sin(fi))
hold on
plot(darN/2*cos(fi),darN/2*sin(fi))
hold on
plot(dforN/2*cos(fi),dforN/2*sin(fi))
hold on
plot(xc,yc,'o')
hold on
plot(XN,YN,'o')

% --- Approximation 

Diam=[daefN darN dforN dfoNeff];
MODmin=-[4 0 0 11.5];
MODmax=-[8 2.8 2.8 19];

% --- Deviation from involute in transverse plane

figure
plot(odl/0.001,diam,'-b')
hold on;
plot(MODmin,Diam,'-r')
hold on;
plot(MODmax,Diam,'-r')
hold on;
plot([15 -15],[dfoN, dfoN],'--b')
hold on;
plot([15 -15],[dforN, dforN],'--b')
hold on;
plot([15 -15],[darN, darN],'--b')
hold on;
plot([15 -15],[daefN, daefN],'--b')
ylabel('d_y_T [mm]')
xlabel('dist [um]')
grid on

figure
plot(MODmin,Diam,'-black')
hold on;
plot(MODmax,Diam,'-black')
hold on
plot([5 -20],[dforN, dforN],'--black')
hold on;
plot([5 -20],[darN, darN],'--black')
grid on
ylabel('d_y_N [mm]')
xlabel('C_\alpha_T [um]')
namesy = {['d_f_o_N=' num2str(dfoN)]; ['d_C_f_o_N=' num2str(dforN)]; ['d_C_a_N=' num2str(darN)]; ['d_a_N=' num2str(daN)]};
set(gca,'ytick',[dfoN dforN darN daefN],'yticklabel',namesy)
set(gca,'xtick',[-20:5:5])
axis tight

