
%eje3
%tp4
%uso de funcion 'nlinfit'
%uso de fsolver
%ajuste no lineal nlinfit(x,y,funcion,valores_iniciales)
clc
clear
%datos de X e Y
t=[0,50,100,150,200,250,300];%t en min
Ca=[0.05,0.038,0.0306,0.0256,0.0222,0.0195,0.0174];%Ca en mol/dm3

%graficar los datos experimentales
subplot(1, 2, 1);
hold on;%retiene el grafico actual cuando se haga otro graficos
%priemro hago un grafico de los datos experimentales o puntos XY
plot(t,Ca,'ro','markersize',4,'markerfacecolor','r')

Ca0=Ca(1);
inic=[0.5,2];
%param=fsolve(@regresion,inic,[],t,Ca0,Ca)
% Usar fsolve para encontrar los parámetros del modelo
param = fsolve(@(x) regresion(x, t, Ca(1), Ca), inic)
%param=nlinfit(t,Ca,@regresion,inic)
%param=fitnlm(t,Ca,@regresion,inic)%parametros calculado que devuelve la funcion
%obtengo 2 parametros


% Calcular el modelo ajustado usando los parámetros encontrados
%sigo
%defino una funcion con el modelo de ajuste (g)para graficar
%junto con los datos experimentales
%g*@(t)((-1)*param(1)*t(i)*(1-param(2))+Ca0^(1-param(2)))^(1/(1-param(2)))
n=length(t);
for i =1:n
g(i)=((-1)*param(1)*t(i)*(1-param(2))+Ca0^(1-param(2)))^(1/(1-param(2)));
end



%fplot(g,[t(1),t(end)])
plot(t,g,'b+','markersize',4,'markerfacecolor','b')
title('ajuste no lineal')
xlabel('t')
ylabel('Ca')
legend('experimental','modelo')
grid on
hold off


% Calcular el error residual
residuals = Ca - g;

% Graficar el error residual
subplot(1, 2, 2);
plot(g, residuals, 'ko', 'markersize', 4);
title('Plot of residuals vs fitted values');
xlabel('Fitted values');
ylabel('Residuals');
grid on;








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