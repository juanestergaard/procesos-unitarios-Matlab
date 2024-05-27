% Procesos Unitarios UNPSJB - 2021
% ----------------------------------
%
% Ejercicio 8-6 Fogler 3rd Edition (Page 454)
% Isomerización de normal butano en fase líquida
% Reactor RFP adiabático
% Reacción exotérmica (DH<0)
% A = n-butano (C4H10)
% B = i-butano
% A <-----> B
% La reacción se lleva a cabo alimentando una mezcla
% 90% n-butano
% 10% i-pentano
%
clear
clc
% Datos para calculos
% --------------------
R= 8.314; % cte de los gases [J/(mol.K)]
xmol_nb= 0.9; % Porcentaje molar de n-butano
xmol_ip= 0.1; % Porcentaje molar del i-pentano
Ca0= 9.3; % Concentración inicial de Ca (n-butano)
F0= 163; % Flujo molar de entrada
Fa0= xmol_nb*F0; % Flujo molar de A
v0= 100000; % Galeones/día equicalente a 163 kgmol/h con los xmol indicados
DHr0= -6900; % Reacción exotérmica
Cp_nb= 141;
Cp_ib= 141;
Cp_ip= 161;
T0= 330; % Temperatura ingreso al reactor (valor original=330)
k1= 31.1; % Cte de velocidad de reacción a T=360K [1/h]
T1= 360; %K
Kc_Tref= 3.03; % cte de velocidad de reacción a T=60°C
Tref= 333; % 60+273
Ea= 65700; % Energía de activación (valor original) [J/mol]
DCp_m= Cp_ib-Cp_nb; % Delta Cp medios
thi_ip=xmol_ip/xmol_nb; % theta del i-pentano
%
% Rango posible de volumen del reactor
Vspan= [0 3.6]; % [0 3.6] valor original /el rango de graficos e integracion
% Valores iniciales de Y (conversión)
y0= [0];
% Llamado a la función dx/dV
% v= volumen (V) dependiente
% y= conversión (X) independiente
[v,y]=ode45(@Fogler_8_6_ODEfun,Vspan,y0); %funcion ode45
%
% Asignación resultados para graficar
z=size(y);
for i=1:z(1,1)
    T(i)= T0+((-DHr0)*y(i,1))/(Cp_nb+thi_ip*Cp_ip);
    Kc(i)= Kc_Tref*exp(DHr0/R*(1/Tref-1/T(i)));
    k(i)= k1*exp(-Ea/R*(1/T(i)-1/T1));
    % Calculo valores conversión de equilibrio
    Xe(i)= Kc(i)/(1+Kc(i));
    % Calculo de velocidad de reacción
    ra(i)= -(k(i)*Ca0*(1-((1+1/Kc(i))*y(i,1))));
end

subplot(1,3,1) % Grafico de conversión
plot(v,y,v,Xe)
xlabel('V(m3) ')
ylabel('X')
legend('X','X_e')
title('RFP Adiabatico: evolución de la conversión')

subplot(1,3,2) % Grafico de temperaturas
plot(v,T)
xlabel('V (m3) ')
ylabel('T (K)')
legend('T')
title('RFP Adiabatico: perfil de temperaturas')

subplot(1,3,3) % Grafico de velocidad de reacción
plot(v,-ra)
xlabel('V(m3) ')
ylabel('-ra (kmol/m3.hr)')
legend('rate')
title('RFP Adiabatico: perfil de velocidad de reacción')
