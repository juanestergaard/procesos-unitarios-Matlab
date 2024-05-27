
%clear all

%TP8 EJE6
%fogler ejemplo 7-9 pag 402 o pdf pag 430
%REACTOR BATCH
%2:37:30
function TP8EJE6
clc
%
%DATOS PARA CALCULOS
%
CC0= 1; %gr/lt (concentración inicial de letadura) BIOMASA
Cs= 250; %gr/lt (Concentración de sustrato, glucosa) SUSTRATO
CP = 0;%%93; %gr/lt asterico PRODUCTO

%
%CUENTAS C CALCULOS 
%
% Rango posible de tolumen del reactor
tspan= [0 12]; %  el rango de graficos e integracion
% talores iniciales de C (contersión)
%C0= [0];
C0=[CC0 Cs CP];
%C(1) es Cc
%C(2) es Cs
%C(3) es Cp

[tspan,C]=ode45(@EDO,tspan,C0); %funcion ode45
%

c1=C(:,1);%conc biomasa Cc
c2=C(:,2);%conc sustrato Cs
c3=C(:,3);%conc producto Cp

% Asignación resultados para graficar
z=size(C);
for i=1:z(1,1)
    kobs(i)=umax*((1-(c3(i,1)/93))^0.52);
    rg(i)=kobs(i)*((c1(i,1)*c2(i,1))/(Ks+c2(i,1)));
    rsm(i)=m*c1(i,1);
    %rd=(Kd+(Kt*Ct))*C(i,1);
    rd(i)=c1(i,1)*kd;
end

subplot(2,2,1) 
plot(tspan,rg,tspan,rsm,tspan,rd)
xlabel('t(h) ')
ylabel('velocidad')
legend('rg','rsm','rd')
title('grafico1')

subplot(2,2,2) 
plot(tspan,c2,tspan,c3)
xlabel('t (h) ')
ylabel('conc ')
legend('Cs','Cp')
title('grafico2')

subplot(2,2,3) 
plot(tspan,kobs)
xlabel('t(h) ')
ylabel('kobs')
legend('kobs')
title('grafico3')

subplot(2,2,4) 
plot(tspan,c1)
xlabel('t(h) ')
ylabel('Cc')
legend('Cc')
title('grafico4')


function f=EDO(tspan,C)

%%datos
CCS= 1/0.08; %gr/gr  %%porque es 1/0.08 y no 0.08
Csc=CCS;
CPC= 5.6; %gr/gr
Cpc=CPC;
umax= 0.33; %(1/hr)telocidad específica máxima de crecimiento 
KS= 1.7; %gr/lt  constante de Monod,
Ks=KS;
kd= 0.01; %(1/hr)
m= 0.03 ;%(gr sustrato/gr cel.hr) (Sustrato de mantenimiento entre 0.01 C 0.05


%%cuentas
kobs=umax*((1-(C(3)/93))^0.52);
rg=kobs*((C(1)*C(2))/(Ks+C(2)));
rsm=m*C(1);
%rd=(Kd+(Kt*Ct))*C(i,1);
rd=C(1)*kd;
%%ECUACIONES DIFERENCIALES
f(1)=rg-rd;%d(Cc)/dt
f(2)=(CCS*(-rg))-rsm;%d(Cs)/dt
f(3)=CPC*rg;%d(Cp)/dt

f=[f(1);f(2);f(3)];
end
end




%CCS= 0.08; %gr/gr
%Csc=CCS;
%CPC= 5.6; %gr/gr
%Cpc=CPC;
%umax= 0.33; %(1/hr)telocidad específica máxima de crecimiento 
%KS= 1.7; %gr/lt  constante de Monod,
%Ks=KS;
%kd= 0.01; %(1/hr)
%m= 0.03 ;%(gr sustrato/gr cel.hr) (Sustrato de mantenimiento entre 0.01 C 0.05

%
%CUENTAS A USAR
%

%Ecuaciones del ejercicio
%rg=umax*((1-(Cp/CP))^0.52)*((Cc*Cs)/(Ks+Cs));
%rsm=m*Cc;
%rd=(Kd+(Kt*Ct))*Cc;

%Ecuaciones fogler
%1 
%balance de masa
%t*dCc/Dt =(rs-rd)t  %t*dCc/Dt =(rg-rd)t
%t*dCs/dt=(Csc*(-rg)*t)-(rm*t)
%tdCt/dt=Cpc*(rs*t)
%2
%rg=umax*((1-(Cp/CP))^0.52)*((Cc*Cs)/(Ks+Cs));
%rd=kd*Cc;
%rsm=m*Cc;
%3
%rp=Cpc*rg
%4
%estas ecuaciones diferenciales debo resolter
%dCc/dt=(umax*((1-(Cp/CP))^0.52)*((Cc*Cs)/(Ks+Cs)))-(kd*Cc);%
%dCs/dt=-Csc*(umax*((1-(Cp/CP))^0.52)*((Cc*Cs)/(Ks+Cs)))-(m*Cc)
%dCp/dt=Cpc*rg


%
%ANOTACIONES
%
%2:38:00
%tario el tiempo que taria Cc que taria al resto
%tiempo en hr de cero a 12
%grafico
%ratio ts tiempo para rg, rsm, rd %ECU DEL PROBLEMA 
%Conc ts tiempo para Cs C Cp   EC.DIF
%kobs ts tiempo
%Cs ts tiempo EC.DIF

%clear all
%t=25;%caudal tolumetrico, lt/min
%constante de telocidad de reaccion
%k1=0.56;
%k2=0.23;
% Llamado a la función dC/dt
% t= tiempo (t) independiente EJEX
% C= concentracion (C) dependiente EJEY
    %T(i)= T0+((-DHr0)*C(i,1))/(Cp_nb+thi_ip*Cp_ip);
    %Kc(i)= Kc_Tref*exp(DHr0/R*(1/Tref-1/T(i)));
    %k(i)= k1*exp(-Ea/R*(1/T(i)-1/T1));
    % Calculo talores contersión de equilibrio
    %te(i)= Kc(i)/(1+Kc(i));
    % Calculo de telocidad de reacción
    %ra(i)= -(k(i)*Ca0*(1-((1+1/Kc(i))*C(i,1))));

%{
%concentraciones iniciales
%Ca0=2.5;%C(1)
%Cb0=0;
%Cc0=0;
%tiempo
ti=0;
tf=12;
delta_t=0.5;
%rango_t=inicio:incremento:fin
rango_t=ti:delta_t:tf;%tector de rango de tiempo con incremento delta


C0=[CC0 Cs CP]% tector de talores iniciales de concentracion FALTA ARREGLAR
%C(1) es Cc
%C(2) es Cs
%C(3) es Cp
rg=umax*((1-(Cp/CP))^0.52)*((Cc*Cs)/(Ks+Cs));
%ecuaciones diferenciales
dCdt=@(t,C) [(umax*((1-(C(3)/CP))^0.52)*((C(1)*C(2))/(Ks+C(2))))-(kd*C(1));% tariacion Cc
-Csc*(umax*((1-(C(3)/CP))^0.52)*((C(1)*C(2))/(Ks+C(2))))-(m*C(1));%tariacion Cs
Cpc*rg];%tariacion Cp
[t,C]=ode45(dCdt,rango_t,C0);

%grafico perfiles de concentracion
plot(t,C(:,1),'-',t,C(:,2),':',t,C(:,3),'--');
xlabel('tiempo(min)');
Clabel('concetracion(mol/lt)');
legend('A','B','C');

%determniacion tiempo de residencia para maximizar B
Cbmax=max(C(:,2))
tmax=t(find(C(:,2)==Cbmax))
tol_reactor=t*tmax
%}



%{
COMENTE TODO ESTE CODIGO PORQUE NO LO tOC A USAR  

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
wint= [0 wf]; % tector de rango de masa de catalizador
% x0= [0 0 0 0]; tector de talores iniciales de contersión
x0= [0 0 0]; % contesiones
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
Clabel('X')
legend('x_1','x_2','x_3')
%}