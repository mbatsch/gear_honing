clear all
close all
clc

load dane.mat

global fisymN;
global rbN;

load X.mat
load Y.mat
load Z.mat

figure
surf(xNN,yNN,zNN,'FaceColor','red','FaceAlpha',0.5);%,'MeshStyle','column')
hold on
% t=0:0.01:2*pi;
% plot(rN*cos(t),rN*sin(t),'-r')
% hold on
% plot(rfoN*cos(t),rfoN*sin(t),'-b')
% hold on
% plot(raefN*cos(t),raefN*sin(t),'-g')
xlabel('x_N')
ylabel('y_N')
zlabel('z_N')
title('powierzchnia dzia豉nia narzedzia')
grid on
axis equal


% Przekr鎩 czo這wy powierzchni dzialania narz璠zia
[xt yt zt] = czolowy(xNN, yNN, zNN);
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
hold on
% [X,Y,Z] = cylinder(rfoN,100);
% surf(X,Y,bN*Z-bN/2);

% Przekr鎩 normalny narz璠zia obwiednia
% [xn yn zn] = normalny(xNN, yNN, zNN,BetaN);
% Wn=[xn;yn;zn]';
% Wnsort=sortrows(Wn,2);
% xn=Wnsort(:,1);
% yn=Wnsort(:,2);
% zn=Wnsort(:,3);
% figure
% plot3(xn,yn,zn,'-o')
% title('przekroj normalny powierzchni dzia豉nia')
% grid on
% axis equal
% hold on
% [X,Y,Z] = cylinder(rfoN,100);
% surf(X,Y,bN*Z-bN/2);

% hold on
% plot(Xtsort,Ytsort,'-','Linewidth',2)
% grid on
% axis equal
% title('Przekr鎩 czo這wy powierzchni dzia豉nia 2D');
% hold on
% plot(rfoN*cos(t),rfoN*sin(t),'-b')

% czysta ewolwenta narz璠zia
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
%odch


[odl diam xc yc XN YN] = odchylka(xt,yt,xewN,yewN);
figure
plot(odl/0.001,diam,'-')

%porownanie w przekro czolowym
figure
plot(xt,yt,'-r')
hold on
plot(xewN,yewN,'-b')
title('porownanie przekr czolowy')
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
% hold on
% [X,Y,Z] = cylinder(rfoN,100);
% surf(X,Y,bN*Z-bN/2);

%apprx. 

Diam=[daefN darN dforN dfoNeff];
MODmin=-[4 0 0 11.5];
MODmax=-[8 2.8 2.8 19];

% odchylenie od ewolwenty w przekroju czolowym
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
%title('odchylka w przekr czolowym')
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
set(gca,'xtick',[-20:5:5])%,'xticklabel',[])
axis tight

