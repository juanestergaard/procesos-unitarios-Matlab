
%%reaccion reversible
%RFP
%V=cte
% A => 0.5 B + 3 C

%. Se pide determinar el volumen del reactor para alcanzar una conversión 
%igual al 80% de la conversión de equilibrio asumiendo una cinética de primer orden respecto de A.

clc;

T=200+273;% K 473
Q=55;%lt/min caudal volumetrico
Fa0=10;% mol/min flujo molar alimentacion
%80%A
%5% B
%15 inertes
%Xa=0.8;%convercion deseada MAL
%volumen de reactor???


kc1=0.15;%(mol/min)^5/2 % para 373K
T1=373;%K
delta_H=-10000;%joule/mol
Ea=50000;%jolue/mol
k1=0.01;%(1/min)

R=8.314;%
%ra=k1*Ca

CA0=(Fa0*0.8)/Q;%mol/lt
CB0=(Fa0*0.05)/Q;
Cin0=(Fa0*0.15)/Q;
CC0=0;


%pag32 o 21 pdf1
kc2=kc1*(exp((-delta_H/R)*((1/T)-(1/T1))))%esta el keq a 473

%pag59 o 23 pdf2
titaA=CA0/CA0
titaB=CB0/CA0
titain=Cin0/CA0
titaC=CC0/CA0

a=1;
b=0.5;
c=3;
%busco la convercion de equilibrio (x)que es XA
%funcion fzero determinar la raiz buscar raiz
%CA=(CA0*(1-x))
%CB=(CA0*(titaB+(b*x)))
%CC=(CA0*(titaC+(c*x)))
f = @(x) kc2 - ((((CA0*(titaB+(b*x)))^b)*((CA0*(titaC+(c*x)))^c))/((CA0*(1-x))^a));
x0= 0.61;% valor inicial de x, anda probando entre 0 y 1
x=fzero(f,x0);%convercion de equilibrio
disp(x)
XA=x*0.8

%pato esta mal debio usar arenius para obtner k0
k0=exp(log(k1)+(Ea/(R*T1)));

k2=k0*(exp(-Ea/(R*T)))


%balance rfp
digits(5)%necesario
syms xa%necesario
funcion= 1/(1-xa);%la funcion a integrar0 REVISAR
limiteinf= 0;%limite inferior
limitesup= XA;%limite superior
f=int(funcion, xa, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral0 =vpa(f,5);%LN(CA/CA0)
V=(Q/k2)*integral0%lt




%reactor RFP isotermico
%2021
%ejercicio5 TP1 
% A=>B
% rA= -kCa
% rB= kCa
%

%{
clc;
v0 = 10;% caudal (lt/min)
k = 0.23;% constante cinetica (1/min)
Vf = 200;%Volumen total del reactor (lt)
Vi = [0 Vf]; %Escala longitudinal del reactor
C0 = [2 0]; %2 es la concentracion inicial puede ser cualquiera

%ecuaciones diferenciales
dC = @(V,C) [-k*C(1)/v0;
      k*C(1)/v0];
%voy poniendo las ecuaciones diferenciales 
%ode resuelve las ecuaciones diferenciales por Runge-Kutta
[V,C] = ode45(dC,Vi,C0);
% dC es ecuacion diferencial
% V es el termino independiente
% C el termino dependiente
%Perfiles de concentracion en funcion de la posicion
plot(V,C(:,1), V,C(:,2),'.-')
legend('CA','CB')
xlabel('V (long,m)')
ylabel('Conc. (kmol/m^3)')
%}