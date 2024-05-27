%eje7TP6
%A+B=>producto
%TAC fase liquida
%elemental
Fa0=3;%kmol/hr todos los moles de A y B
%0.5 A y B
Q=1;%m3/hr
V=3;%m3
Calor=35000;%Kj/KmolA
kinf=10^15;
EaR=-13000;


%cuenta
Xa=0.7;
Va=V/2;%PORQUE ES 1.5????
K=(Xa*(Q^2))/(Fa0*((1-Xa)^2)*Va)%m3/grmol hr


T=(EaR)/(log(K/kinf))%K
%358
%esta bien que de 382

Fa00=Fa0*0.5;%solo los moles de A
QQ=Fa00*Calor*Xa%Kj/hr



