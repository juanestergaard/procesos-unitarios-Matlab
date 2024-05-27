%TP2
%ejercicio 4
%primer orden
d=900;% kg/m3 densidad
T=163;%C temperatura
t1=10;%min , tiempo de carga
t2=12;%min
t3=14;%min

mtotal=900; %tn
tiempoano=7000;%hs
x=0.97;%convercion



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