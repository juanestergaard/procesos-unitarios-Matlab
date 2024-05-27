
%reactor TAC en serie 3
% evolucion de la convercion global y parcial
%se puede modificar los volumens de los reactores para ver el
%efecto de los cambios de tamano y el orden de los mismos
%2021
%reaccion simple segundo orden
% A + B => C
%ra=KCACB
clc;
va0=6; %caudal volumetrico entrada de cada corriente (A y B)
vb0=6;
v=va0+vb0;%(lt/min0) caudal volumetrico salida
V1=200;%(lts) volumen de cada reactor TAC 3
V2=200;
V3=200;
%concentraciones iniciales
Ca0=2;%(molgr/lts)
Cb0=2;%(molgr/lts)
%constante de velocidad de reaccion
k=0.5;
%tiempo
tau1=V1/v;
tau2=V2/v;
tau3=V3/v;
tau=(V1+V2+V3)/v;
t1=0;
tf=20;
delta_t=1;
%rango_t=inicio:incremento:f10
rango_t = t1:delta_t:tf ;%vector de rango de tiempos con incremento delta
%identificacion de concentraciones en vector C
% C(1) = Ca1
% C(2) = Cb1
% C(3) = Ca2
% C(4) = Cb2
% C(5) = Ca3
% C(6) = Cb3
%vector de valores iniciales de concentracion
C0=[Ca0 Cb0 0 0 0 0];  
%ecuacion diferenciales
dCdt = @(t,C)[
(va0*Ca0-v*C(1)-k*V1*C(1)*C(2))/V1; %Ca1 primer reactor
(vb0*Cb0-v*C(1)-k*V1*C(1)*C(2))/V1; %Cb1 primer reactor
(v*C(1)-v*C(3)-k*V2*C(3)*C(4))/V2; %Ca2 primer reactor
(v*C(2)-v*C(4)-k*V2*C(3)*C(4))/V2; %Cb2 primer reactor
(v*C(3)-v*C(5)-k*V3*C(5)*C(6))/V3; %Ca3 primer reactor
(v*C(4)-v*C(6)-k*V3*C(5)*C(6))/V3]; %Cb3 primer reactor
[t,C] = ode45(dCdt,rango_t,C0);
%Perfiles de Ca a la salida de los reactores
plot(t,C(:,1),'-',t,C(:,3),':',t,C(:,5),'--');
legend('C_(A1)','C_(A2)','C_(A3)')
%
%perfilees de Cb a la salida de los reactores
%plot(t,C(:,2),'*',t,C(:,4),'o',t,C(:,6),'.');
%legend('C_(B1)','C_(B2)','C_(B3)')
%
%perfiles de Ca y Cb a la salida de cada reactor
%plot(t,C(:,1),'-',t,C(:,3),':',t,C(:,5),'--',t,C(:,2),'*',t,C(:,4),'o',t,C(:,6),'.');
%legend('C_(A1)','C_(A2)','C_(A3)','C_(B1)','C_(B2)','C_(B3)')
xlabel('Tiempo(min)');
ylabel('Concentracion(mol/lt)');
%
%calculo de concentracion global y parcial
%
CA1=C(20,1)
CB1=C(20,2)
CA2=C(20,3)
CB2=C(20,4)
CA3=C(20,5)
CB3=C(20,6)
XA1=(Ca0*va0-CA1*v)/(Ca0*va0) %concentracio global 1er reactor
XA1p=(Ca0*va0-CA1*v)/(Ca0*va0) %concentracio parcial 1er reactor
%
XA2=(Ca0*va0-CA2*v)/(Ca0*va0) %concentracio global 2do reactor
XA2p=(CA1-CA2)/(CA1) %concentracio parcial 2do reactor
%
XA3=(Ca0*va0-CA3*v)/(Ca0*va0) %concentracio global 3er reactor
XA3p=(CA2-CA3)/(CA2) %concentracio parcial 3er reactor







