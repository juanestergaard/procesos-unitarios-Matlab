
function graficoexcel
%minuto 4:00 muestra los graficos y las cuentas
%otro matlab INCOMPLETO

%pagina462
%ejemplo 8-7
% A + B => C
%A cetona; B cetena; C metano
%reaccion exotermica
%T de interes 1035
%esta todo en la unidad6

clear all
clc

%Datos
X0=0;
Ti=1035;
%nuevos
k10=1000;
k20=1000000;
E1=41570;
E2=83140;
R=8.314;%J/MolK   ya esta repetido
Ti0=573;%k
cpm=42;% kJ/(mol.K)
deltaHr=-41570;% kJ/kmol 
ya0=1;
tau1=13;
tau2=100;
tau3=1000;
%t= 50 100 .... 1200
%cuentas
%rango de temperatura
ti=50;
tf=1200;
delta_t=50;
rango_t=ti:delta_t:tf;
%r=0, equilibrio, 
z1=size(rango_t);
%disp(z1);
for i=1:z1(1,2);
    XAe0(i)=1/(1+(k20/k10)*(exp(-(E2-E1)/(R*rango_t(1,i)))));
    k1(i)=k10*exp(-E1/(R*rango_t(1,i)));
    k2(i)=k20*exp(-E2/(R*rango_t(1,i)));
    Xr13(i)=(tau1*k1(i))/((k1(i)*tau1)+(k2(i)*tau1)+1);
    Xr100(i)=(tau2*k1(i))/((k1(i)*tau2)+(k2(i)*tau2)+1);
    Xr1000(i)=(tau3*k1(i))/((k1(i)*tau3)+(k2(i)*tau3)+1);
    if (i<=z1(1,2))&&(i>1)
        %calcula la derivada
        dk1(i)=(k1(i)-k1(i-1))/delta_t;
        dk2(i)=(k2(i)-k2(i-1))/delta_t;
        %ra dejarla en k1,k2,x deriva con respecto T dk1/dT y dk2/dT
        %igualar a cero y depejar x
        Xmax(i)=dk1(i)/(dk1(i)+dk2(i));
    end
end

%disp(k1);
%disp(Xr13);
%grafico perfiles de concentracion
plot(rango_t,XAe0(1,:),'--',rango_t,Xr13(1,:),'-',rango_t,Xr100(1,:),':',rango_t,Xr1000(1,:),'*',rango_t,Xmax(1,:),'-');
xlabel('temperatura(k)');
ylabel('convercion(X)');
legend('Xae r=0','X tau13','X tau100','X tau1000','Xmax');



%ecuaciones diferenciales
%volumen
vi=0;
vf=5;
delta_v=0.25;
%rango_t=inicio:incremento:fin
rango_v=vi:delta_v:vf;%vector de rango de tiempo con incremento delta

       %x1  x2   
datos0=[Ti X0];% vector de valores iniciales temperatura y conversion

[rango_v,x]=ode45(@EcuDif,rango_v,datos0);

x1=x(:,1);%Temperatura T
x2=x(:,2);%convercion X

z=size(x);
for i=1:z(1,1)
    deltaH(i)=80776+6.8*(x1(i,1)-Tref)-5.75e-3*(x1(i,1)^2-Tref^2)-1.27e-6*(x1(i,1)^3-Tref^3);
    k(i)=exp(34.34-34222/x1(i,1));
    ra(i)=-((k(i)*CAO2*(1-x2(i,1)))/(1+x2(i,1)))*(Ti/x1(i,1));
    deltaCp(i)=deltaAlfa+deltaBeta*x1(i,1)+deltaYe*x1(i,1)^2;
    CpA(i)=26.63+0.183*x1(i,1)-45.86e-6*x1(i,1)^2;
    rainv(i)=1/ra(i);
end
%{
subplot(2,2,1)%N filas, Ncolumna , subindice del grafico
plot(rango_v, x1,'-r')% 'ko', 'markersize', 4);
hold on%todo lo anterior mantenlo voy a graficar algo nuevo
grid on%pone la cuadricula
%plot(rango_v,x2,'-b')
title('graf1');
xlabel('volumen m3');
ylabel('temperatura K');

subplot(2,2,2)
plot(rango_v, x2,'-r')% 'ko', 'markersize', 4);
grid on%pone la cuadricula
title('graf2');
xlabel('volumen m3');
ylabel('convercion X');

subplot(2,2,3)
plot(x1, x2,'-r')% 'ko', 'markersize', 4);
grid on%pone la cuadricula
title('graf3');
xlabel('temperatura K');
ylabel('convercion X');

subplot(2,2,4)
plot(x2, rainv,'-r')% 'ko', 'markersize', 4);
grid on%pone la cuadricula
title('graf4');
xlabel('convercion X');
ylabel('1/ra');
%este es el unico que esta mal deberia ser una recta acendente de 0.015 a 0.02 
%}

%%funcion que contiene el sistema de EDOs
function f=EcuDif(rango_v,x)
    
%cuentas
Tref=290;%K
T0=1035;% K
mA=8000;%kg/h caudal masico
pmA=58;%gmol peso molecular
R=8.314;
PA0=162;%kpa

%Calculos
FA0=mA/pmA;%kmol/h
FA02=FA0*(1/3600)*(1000/1);%mol/seg
CAO= PA0/(R*T0);%kmol/m3
CAO2=CAO*1000;%mol/m3
vo=FA02/CAO2;%m3/s
deltaAlfa=13.39+20.04-26.63;
deltaBeta=(0.077+0.0945-0.183);
deltaYe=(-18.71e-6-30.95e-6-(-45.86e-6));


%parametrsos del modelo
deltaH=80776+6.8*(x(1)-Tref)-5.75e-3*(x(1)^2-Tref^2)-1.27e-6*(x(1)^3-Tref^3);
k=exp(34.34-34222/x(1));
ra=-((k*CAO2*(1-x(2)))/(1+x(2)))*(T0/x(1));
deltaCp=deltaAlfa+deltaBeta*x(1)+deltaYe*x(1)^2;
CpA=26.63+0.183*x(1)-45.86e-6*x(1)^2;


%ecuacione diferenciales
f(1)=(-ra)*(-deltaH)/(FA02*(CpA+x(2)*deltaCp));%dT/dV
f(2)=-ra/FA02;%dX/dV



f=[f(1);f(2)];
end
end


%Tref=290;%K
%T0=1035;% K
%mA=8000;%kg/h caudal masico
%pmA=58;%gmol peso molecular
%R=8.314;
%PA0=162;%kpa

%Calculos
%FAO=mA/pmA;%kmol/h
%FA02=FAO*(1/3600)*(1000/1);%mol/seg
%CAO= PA0/(R*T0);%kmol/m3
%CAO2=CAO*1000;%mol/m3
%vo=FA02/CAO2;%m3/s

%dHOA=-216670;%delta H formacion acetona , J/mol
%dHOB=-61090;%delta H formacion cetona , J/mol
%dHOC=-74810;%delta H formacion hetano , J/mol
%deltaHOr=dHOC+dHOB-dHOA;%J/mol

%CpA=alfaA+betaA*T+gamaA*T^2
%CpA=26.63+0.183*T0-45.86e-6*T0^2;
%CpB=alfaB+betaB*T+gamaB*T^2
%CpB=20.04+0.0945*T0-30.95e-6*T0^2;
%CpC=alfaC+betaC*T+gamaC*T^2
%CpC=13.39+0.077*T0-18.71e-6*T0^2;

%DeltaCP=CpC+CpB-CpA;

%alfaA=26.63;
%betaA=0.183;
%gamaA=-45.86e-6;

%deltaAlfa=13.39+20.04-26.63;
%deltaBeta=(0.077+0.0945-0.183);
%deltaBeta2=deltaBeta/2;
%deltaYe=(-18.71e-6-30.95e-6-(-45.86e-6));
%deltaYe3=deltaYe/3;
%deltaCp=deltaAlfa+deltaBeta2*T0+deltaYe3*T0^2;


%k=exp(34.34-34222/T0);
%deltaH0=80776+6.8*(T0-Tref)-5.75e-3*(T0^2-Tref^2)-1.27e-6*(T0^3-Tref^3);
%k0=exp(34.34-34222/T0);
%ra0=-((k0*CAO2*(1-X0))/(1+X0))*(T0/T0);
%deltaCp0=deltaAlfa+deltaBeta*T0+deltaYe*T0^2;
%CpA0=26.63+0.183*T0-45.86e-6*T0^2;
%dx0=(-ra0)/FA02;
%dt0=(-ra0)*(-deltaH0)/(FA02+X0*deltaCp0)


%{
d(T)/d(U)=-ra*(-deltaH)/(Fa0+X*deltaCp)
d(X)/d(U)=-ra/Fa0
dH=80776+6.8*(T-Tref)-5.75e-3*(T^2-Tref^2)-1.27e-6(T^3-Tref^3);
ra=-((k*CAO*(1-X))/(1+X0))*(T0/T)

v0=0
vf=5
%}

%{
7:35 tiempo del video

%este seria un matlab parecido
T=X(4);

YA=X(1)./(X(1)+X(2)+X(3)+FN2);

CA=1000*YA*P/(R*T);
k=exp(34.34-34222/T);
Tref=298;
dH=80776+6.8*(T-Tref)-5.75e-3*(T^2-Tref^2)-1.27e-6(T^3-Tref^3);
CpA=26.63+0.183*T-45.86e-6*T^2;
CpB=20.04+0.945*T-30.95e-6*T^2;
CpC=13.39+0.077*T-18.7e-6*T^2;
CpN2=6.25+0.00878*T-2.1e-8*T^2;
rA=-k.*CA;
dXdV=[rA;
-rA;
-rA;
-rA*(-dH)./(X(1)*CpA+X(2)*CpB+X(3)*CpC+FN2*CpN2);];
end

%}


%{
%en paralelo
%A=>B k1
%A=>C k2   %%lo puse de orden 2 mierda

clear all
v=25;%caudal volumetrico, lt/min
%constante de velocidad de reaccion
k1=1.5;
k2=1;
%concentraciones iniciales
Ca0=1.2;%C(1)
Cb0=0;
Cc0=0;
%tiempo
ti=0;
tf=1;
delta_t=0.01;
%rango_t=inicio:incremento:fin
rango_t=ti:delta_t:tf;%vector de rango de tiempo con incremento delta
C0=[Ca0 Cb0 Cc0]% vector de valores iniciales de concentracion
%ecuaciones diferenciales
dCdt=@(t,C) [-k1*C(1)-k2*(C(1)^2);%reaccion de A para dar B
k1*C(1);%formacion de B y desaparece B para dar C
k2*(C(1)^2)];%formacion de C
[t,C]=ode45(dCdt,rango_t,C0);
%grafico perfiles de concentracion
plot(t,C(:,1),'-',t,C(:,2),':',t,C(:,3),'--');
xlabel('tiempo(min)');
ylabel('concetracion(mol/lt)');
legend('A','B','C');
%determniacion tiempo de residencia para maximizar B
Cbmax=max(C(:,2))%encuentra el valor del maximo
tmax=t(find(C(:,2)==Cbmax))%aca busca que el tiempo que de == que el max
Vol_reactor=v*tmax
%}


