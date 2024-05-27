%ejercicio 11

%%A=>B+C
%rA=-kCa

clc
R=0.082; % atm.lt/(molgr.K)
D=6; %diametro del reactor (plg)
mA0= 500; %(lb/hr)caudal
PMA=359%lb/lbmol peso molecular
T=773;%K temp
P= 5;%atm presion
Area=pi()*((D*0.0254)^2)/4 %0.0254 convercion de unidad
Xa=0.9%convercion final
k=7.8E09*exp(-19229/T);
Fa0=(mA0/PMA)*454/3600;%pasamos lbmol/hr a molgr/seg
CA0=P/R*T;
v0=Fa0/CA0;
digits(5)

%determinamos la longitud sin considerar la variacion de moles
%resolucion de la integral de conversion con V=constante

syms x
f=int(1/(1-x), x, 0, Xa);
integral =vpa(f,5);

%determinacion de la longitud
Li = integral*Fa0/(k*CA0*Area)% en litros
CA=CA0*(1-Xa);
%fprintf('Longitud RFP(a volumen cte)=%5.2f litros');

%determinacion de la longitud considerando la variacion de moles
%resolucion de la integral V=variavle
CA=CA0*(1-Xa)/(1+Xa);
syms x %symbolic operations comand
f=int((1+x)/(1-x), x, 0, Xa);
integral=vpa(f,5);
%determinacion de la longitud
L2=integral*Fa0/(k*CA0*Area)%litros
%fprintf('Longitud RFP(a volumen variable)=%5.2f litros',L2);
print('anda');


Vf=3690;% voloune total del reactor, lt
Vi=[0 Vf]; %escal de longitud del reactor
C0= [CA0];
%ecuacion diferenciales
dC= @(Z,C)[-k*C(1)*Area];
%odc resuelve ecuaciones diferenciales por runge kutta
[Z,C]=ode45(dC,Vi,C0);
%perfiles de concentracion en funcion de la posicion
plot(Z,C(:,1),'.-')
legend('CA')
xlabel('Z(vol,m3)')
ylabel('Conc,[mol/m3]')










