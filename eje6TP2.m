%TP2
%ejercicio 6
%primer orden
%BATCH
%V=cte
T=340;%K temperatura
P=202.6;%Kpa presion
P1=P*1000;%pa
Kc=0.1;%mol/dm3 cte de equil a 340k
Kc1=Kc*(1000/1);%mol/m3
delta=2-1;
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
