
%reactor RFP isotermico
%2021
%ejercicio5 TP3 
% A=>3B
% rA= -kCa2
% 
%

clc;

%VER SI SIRVEN
%v0 = 10;% caudal (lt/min)
%k = 0.23;% constante cinetica (1/min)
%Vf = 200;%Volumen total del reactor (lt)
%Vi = [0 Vf]; %Escala longitudinal del reactor / ecuacion diferencial
%C0 = [2 0]; %2 es la concentracion inicial puede ser cualquiera /ecuacion
%diferencial


%constantes universales
R=0.082; % atm.lt/(molgr.K)


%PARAMETROS

%diametro
%D1=6; %diametro del reactor (plg)
D2=2.5;%diametro del reactor (cm)
%D3=1;%diametro del reactor (m)
%longitud
%L1=6; %largo del reactor (plg)
%L2=2;%largo del reactor (cm)
L3=2;%largo del reactor (m)
%temperatura
%T1=5;% Temp en K
T2=350;% Temp en C
%T3=5;% Temp en F
%PRESION
P=25;%atm presion//5
%CAUDAL
Q1=320;%caudal en m3/hr //4000lt/h
%Q2=4;%caudal en m3/s


Xa=0.8;%convercion final //0.6
reactivos=1;%moles estequiometricos de reactivo
productos=3;%moles estequiometricos de producto
yA0=0.5;%//1
tita=1;%siempre es 1             REVISAR
vi=1;%siempre es 1
%VER
%mA0= 500; %(lb/hr)caudal
%PMA=359%lb/lbmol peso molecular


%CONVERSION
%conversion de diametros a metros
%D=D1*0.0254; %plg a m
D=D2*(1/100);% cm a m
%D=D3; %m a m

%conversion de largos a metros
%L=L1*0.0254; plg a m
%L=L2*(1/100);% cm a m
L=L3; %m a m

%convercion de temperatura
%T=T1;% K a K
T=T2+273;% C a K
%T=((T3-32)/1.8)+273;% F a K

%conversion de caudal
Q=Q1*(1/3600);% m3/hr a m3/s
%Q=Q2;% m3/s a m3/s



%CUENTAS
Vol=pi()*(D^2)*L/4;%volumen en m3
Area=pi()*(D^2)/4;%area en m2
vel=Q/Area;%velocidad m/s

delta=-reactivos+productos;%delta 

Ca00=(yA0*P)/(R*T);%concentracion en molgr/lt
CA0=Ca00*1000;%concentracion en molgr/m3

%VER
%k=7.8E09*exp(-19229/T);
%Fa0=(mA0/PMA)*454/3600;%pasamos lbmol/hr a molgr/seg
%CA=CA0*(1-Xa);
%v0=Fa0/CA0;


%ejemplo de integral
digits(5)%necesario
syms x%necesario
funcion=((1+(yA0*delta*x))/(tita-vi*x))^2;%la funcion a integrar0 REVISAR
limiteinf=0;%limite inferior
limitesup=0.8;%limite superior//0.6
f=int(funcion, x, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral0 =vpa(f,5)%anda

%la funcion a integrar1
funcion=(4*x)/((1-x)^2);
f=int(funcion, x, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral1 =vpa(f,5);

%la funcion a integrar2
funcion=(4*(x^2))/((1-x)^2);
f=int(funcion, x, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral2 =vpa(f,5);

intTotal=integral0+integral1+integral2;

%K=(Q1/Vol)*(1/CA0)*integral0 %constante de velocidad de reaccion en m3/molgr*hr

K1=204.17;%sale del programa experimental

VOL1=Q1*integral0/(K1*CA0)%m3

%VOL1=0.066375










%ecuaciones diferenciales
% dC = @(V,C) [-k*C(1)/v0;
  %    k*C(1)/v0];
%voy poniendo las ecuaciones diferenciales 
%ode resuelve las ecuaciones diferenciales por Runge-Kutta
%%[V,C] = ode45(dC,Vi,C0);
% dC es ecuacion diferencial
% V es el termino independiente
% C el termino dependiente
%Perfiles de concentracion en funcion de la posicion
%%plot(V,C(:,1), V,C(:,2),'.-')
%%legend('CA','CB')
%%xlabel('V (long,m)')
%%ylabel('Conc. (kmol/m^3)')







%determinacion de la longitud
%Li = integral*Fa0/(k*CA0*Area)% en litros
%CA=CA0*(1-Xa);
%fprintf('Longitud RFP(a volumen cte)=%5.2f litros');

%determinacion de la longitud considerando la variacion de moles
%resolucion de la integral V=variavle
%CA=CA0*(1-Xa)/(1+Xa);
%syms x %symbolic operations comand
%f=int((1+x)/(1-x), x, 0, Xa);
%integral=vpa(f,5);
%determinacion de la longitud
%L2=integral*Fa0/(k*CA0*Area)%litros
%fprintf('Longitud RFP(a volumen variable)=%5.2f litros',L2);
%print('anda');


%Vf=3690;% voloune total del reactor, lt
%Vi=[0 Vf]; %escal de longitud del reactor
%C0= [CA0];
%ecuacion diferenciales
%dC= @(Z,C)[-k*C(1)*Area];
%odc resuelve ecuaciones diferenciales por runge kutta
%[Z,C]=ode45(dC,Vi,C0);
%perfiles de concentracion en funcion de la posicion
%plot(Z,C(:,1),'.-')
%legend('CA')
%xlabel('Z(vol,m3)')
%ylabel('Conc,[mol/m3]')




