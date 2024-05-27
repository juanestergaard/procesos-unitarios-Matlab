
%reactor RFP isotermico
%2021
%ejercicio5 TP1 
% A=>B
% rA= -kCa
% rB= kCa
%

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