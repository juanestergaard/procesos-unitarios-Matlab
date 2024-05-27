% Procesos Unitarios UNPSJB - 2021 %
% ---------------------------
%
% Testeo de catalizadores para una reacción en fase gaseosa en un RLF &
% A + B  ---> C + D
% Se cuenta con distitos modelos cinéticos para distintos catalizadores
% Todos los modelos indican control por reacción superficial
clear
clc
% Datos
% -------------
Ca0=1; % mol/lt
Cb0=1; % mol/lt
Fa0=1.5; % mol/lt
k=10; % lt^6/(kg.min)
ka=1; % mol/lt
kb=2; % lt/mol
kc=20; % lt/mol
wf=8; % masa final catalizador
wint= [0 wf]; % vector de rango de masa de catalizador
% x0= [0 0 0 0]; vector de valores iniciales de conversión
x0= [0 0 0]; % convesiones
% 
kfc= k*Ca0*Cb0/Fa0;
dxdw= @(w,x) [kfc*(1-x(1))^2/(1+ka*Ca0*(1-x(1)));
    kfc*(1-x(2))^2/(+ka*Ca0*(1-x(2))+kc*Ca0*x(2));
    kfc*(1-x(3))^2/(1+ka*Ca0*(1-x(3))+kb*Ca0*(1-x(3)))^2];
%
%
[w x]=ode45(dxdw,wint,x0)
% plot(w,x(:,1),w,x(:,2),':',w,x(:,3),'.-', w,x(:,4),'--') % 4
% catalizadores
plot(w,x(:,1),w,x(:,2),':',w,x(:,3),'.-') % 3 catalizadores
xlabel('W(kg)')
ylabel('X')
legend('x_1','x_2','x_3')