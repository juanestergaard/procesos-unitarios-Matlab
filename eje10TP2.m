clc
%TP2
%ejercicio 10
%clc
%A+B=>C
%TAD
T=400;% c temp
T1=T+273;%K
P=1;%atm presion
P1=P*101300;%Pa
YA0=0.4;
YB0=0.4;
YC0=0.11;
Yinerte0=0.09;

k=2;%lt/molmin orden2
V=5000;%lt;
ycf=0.45;
R=8.314;%R

CA0=(YA0*P1)/(R*T1);%mol/m3
CB0=(YB0*P1)/(R*T1);%mol/m3
CC0=(YC0*P1)/(R*T1);%mol/m3
Cinerte0=(Yinerte0*P1)/(R*T1);%mol/m3
CA01=CA0/1000%mol/lt

%funcion fzero determinar la raiz buscar raiz
%yc=nc/nt
%nc=nto*(yco+ya0*x)
%nt=nto*(1-yao*x) eso es a+b da c pierdo un mol entotal cada vez que
%reacciona
f =@(x) ycf-((YC0+(YA0*x))/(1-(YA0*x)));
x0= 0.5;% valor inicial de x
x=fzero(f,x0)%convercion de equilibrio

%resuelve integrales
digits(5)%necesario
syms X1%necesario
funcion1= (1-YA0*X1)/((1-X1)^2);%la funcion a integrar0 REVISAR
limiteinf= 0;%limite inferior
limitesup= x;%limite superior/0.586
f1=int(funcion1, X1, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral0 =vpa(f1,5)%
Vrfp1=(1/(k*CA01))*integral0%lt


%{
FA0=5;%mol/hr flujo molar
v0=10;%lt/hr caudal
x=0.9;
k0=0.05;
CA0=FA0/v0;%0.5


%%%%%%orden 0 cero

%TAC
%FB0*X=k*V
k1=k0;
Vtac1=(FA0*x)/(k1)%lt

%
%RPF
digits(5)%necesario
syms X1%necesario
funcion1= 1/(1);%la funcion a integrar0 REVISAR
limiteinf= 0;%limite inferior
limitesup= x;%limite superior/0.9
f1=int(funcion1, X1, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral0 =vpa(f1,5);%
Vrfp1=(FA0/k1)*integral0%lt


%%%%%%orden 1 uno

%TAC
%FB0*X=k*V
k2=k0;
Vtac2=(FA0*x)/(k2*(CA0*(1-x)))%lt 


%
%RPF
digits(5)%necesario
syms X2%necesario
funcion2= 1/((CA0*(1-X2)));%la funcion a integrar0 REVISAR
limiteinf= 0;%limite inferior
limitesup= x;%limite superior/0.9
f2=int(funcion2, X2, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral1 =vpa(f2,5);%
Vrfp2=(FA0/k2)*integral1%lt

%%%%%%orden 2 dos

%TAC
%FB0*X=k*V
k3=k0;
Vtac3=(FA0*x)/(k3*((CA0*(1-x))^2))%lt

%
%RPF
digits(5)%necesario
syms X3%necesario
funcion3= 1/((CA0*(1-X3))^2);%la funcion a integrar0 REVISAR
limiteinf= 0;%limite inferior
limitesup= x;%limite superior/0.9
f3=int(funcion3, X3, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral2 =vpa(f3,5);%
Vrfp3=(FA0/k3)*integral2%lt
%}

%{
%elemental
%A+B=>C
%BATCH
%V=cte
delta=1-2;
%corriente1
v1=5%L/min
CA01=2;%M
CB01=1.5;%M
%corriente2
v2=5%L/min
CA02=0.5;%M
CB02=0.75;%M
CINERTE=0.3;%M

T=300%K temperaatura
K=0.07%Lmin a 300k K cinetica
Ea=20%kcal/mol energia de activacion
Ea2=Ea*4186.8%joule/mol
x=0.9%convercion


Q0=v1+v2;
CA0=((CA01*v1)+(CA02*v2))/Q0
CB0=((CB01*v1)+(CB02*v2))/Q0

T2=70+273;%K temperatura max
R=8.314;%pam3/molK o joule/mol

%funcion fzero determinar la raiz buscar raiz
f =@(k2) -(log(K/k2))-((Ea2/R)*((1/T)-(1/T2)));
k20= 4.7;% valor inicial de x
k2=fzero(f,k20)%convercion de equilibrio
%k2 lt/min

k1=K*exp(((-Ea2/R)*((1/T2)-(1/T))))


%B limitante
%TAC
%FB0*X=k*CA*CB*V
CA=CA0-CB0*x;
CB=CB0*(1-x);
FB0=Q0*CB0;%mol/min
Vtac=(FB0*x)/(k1*CA*CB)%lt

%
%RPF
digits(5)%necesario
syms X%necesario
funcion= 1/((CA0-CB0*X)*(CB0*(1-X)));%la funcion a integrar0 REVISAR
limiteinf= 0;%limite inferior
limitesup= x;%limite superior/0.9
f=int(funcion, X, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral0 =vpa(f,5);%
Vrfp=(FB0/k1)*integral0%lt
%}


%{
T=340;%K temperatura
P=202.6;%Kpa presion
P1=P*1000;%pa
Kc=0.1;%mol/dm3 cte de equil a 340k
Kc1=Kc*(1000/1);%mol/m3

R=8.314;%pam3/molK

%cuentas
CA0=P1/(R*T)%mol/m3
%ecuancion 
%Kc=no2^2/n2o4
%no2=nb0+2na0X
%n2o4=na0(1-X)

%funcion fzero determinar la raiz buscar raiz
f =@(x) Kc1-((4*CA0*(x^2))/(1-x));
x0= 0.5;% valor inicial de x
x=fzero(f,x0)%convercion de equilibrio

CA=CA0*(1-x)
CB=0+(2*CA0*x)
PA=CA*R*T%pa
PB=CB*R*T%pa
Pf=PA+PB%pa
pf2=(1+(1*delta*x))*P1%pa %es lo mismo se puede aplicar
%}

%{
%A=>P
%orden1
K=2.5;%(1/hr)
XA=0.9;%
CA0=2;%mol/lt
Q=5;%m3/hr
Q0=Q*1000;%lt/hr

%RPF
CA=CA0*(1-XA);%mol/lt
digits(5)%necesario
syms x%necesario
funcion= 1/(x);%la funcion a integrar0 REVISAR
limiteinf= CA0;%limite inferior0.4737
limitesup= CA;%limite superior//0.6
f=int(funcion, x, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral0 =vpa(f,5);%LN(CA/CA0)
V=(-Q0/K)*integral0%lt


%TAC
FA0=CA0*Q%mol/hr
ra=K*CA0
V=FA0*XA/(ra)%lt


%}
