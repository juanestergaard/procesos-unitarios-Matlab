function dXdV= Fogler_8_6_ODEfun(Vol,Xconv);
% Ejemplo 8-6 Fogler 3rd Edition (Page 454)
% Llamada por el script "FOGLER.m"
% Xconv= conversión
% Vol= volumen
X= Xconv;
% Datos y cálculos
% --------------
% A= n-butano
% B= i-butano
R= 8.314; %cte de gases ideales
xmol_nb= 0.9;
xmol_ip=0.1;
Ca0= 9.3;
F0= 163; % Flujo molar de entrada
Fa0= xmol_nb*F0; % Flujo molar de A
DHr0= -6900; % Reacción exotérmica
Cp_nb= 141;
Cp_ib= 141;
Cp_ip= 161;
T0= 330; % (valor original= 330)
k1= 31.1; % Cte de velocidad de reacción a T=360K [1/h]
T1= 360; %K
Kc_Tref= 3.03; % cte de velocidad de reacción a T=60°C
Tref= 333; %K 60+273
Ea= 65700; % Energía de activación (valor original) [J/mol]
DCp_m= Cp_ib-Cp_nb; % Delta Cp medios
thi_ip=xmol_ip/xmol_nb; % theta del i-pentano
%%%%%%%%%%%%%%%%
%hasta a es una copia de los Datos para Calcular
T=T0+((-DHr0)*X)/(Cp_nb+thi_ip*Cp_ip);
Kc= Kc_Tref*exp(DHr0/R*(1/Tref-1/T1));
k= k1*exp(-Ea/R*(1/T-1/T1));
Xe= Kc/(1+Kc);
ra= -(k*Ca0*(1-((1+1/Kc)*X)));
%ra esta un poco mas trabajada la formula
%
% Ecuación diferencial RFP 
dXdV= -(ra/Fa0);
end