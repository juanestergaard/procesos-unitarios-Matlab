%eje88TP6

%en paralelo
%A=>B k1
%A=>C k2
clear all


k10=0.00012;
k20=0.0452;
Ea1=26000;
Ea2=10000;
T0=300;
T2=320;
R=8.314;

%k=k10*(exp((-Ea1/R)*((1/T2)+(1/T0))));


ya=-1;%coenficiente estequiometrico
yb=1;
yc=1;

v=25;%caudal volumetrico, lt/min
%constante de velocidad de reaccion
k1=k10*(exp((-Ea1/R)*((1/T2)-(1/T0))));
k2=k20*(exp((-Ea2/R)*((1/T2)-(1/T0))));
%concentraciones iniciales
Ca0=1.2;%C(1)
Cb0=0;
Cc0=0;
%tiempo
ti=0;
tf=55;
delta_t=5;
%rango_t=inicio:incremento:fin
rango_t=ti:delta_t:tf;%vector de rango de tiempo con incremento delta
C0=[Ca0 Cb0 Cc0];% vector de valores iniciales de concentracion
%ecuaciones diferenciales
dCdt=@(t,C) [-k1*C(1)-k2*C(1);%reaccion de A para dar B
k1*C(1);%formacion de B y desaparece B para dar C
k2*C(1)];%formacion de C
[t,C]=ode45(dCdt,rango_t,C0);
%grafico perfiles de concentracion
plot(t,C(:,1),'-',t,C(:,2),':',t,C(:,3),'--');
xlabel('tiempo(min)');
ylabel('concetracion(mol/lt)');
legend('A','B','C');
%determniacion tiempo de residencia para maximizar B
%Cbmax=max(C(:,2));%encuentra el valor del maximo
%tmax=t(find(C(:,2)==Cbmax));%aca busca que el tiempo que de == que el max
%Vol_reactor=v*tmax;

%z=size(C);
%C(z,2)
%for i=1:z(1,1)
    %C(1,2)%0
    %C(i,2)%casi 0
    %C(1,1)%1.2
    %C(i,1)%1.2
    %SB(i)=((C(1,2)-C(i,2))/yb)/((C(1,1)-C(i,1))/ya);
    %SC(i)=((C(1,3)-C(i,3))/yc)/((C(1,1)-C(i,1))/ya);
    %T(i)= T0+((-DHr0)*y(i,1))/(Cp_nb+thi_ip*Cp_ip);
    %Kc(i)= Kc_Tref*exp(DHr0/R*(1/Tref-1/T(i)));
    %k(i)= k1*exp(-Ea/R*(1/T(i)-1/T1));
    % Calculo valores conversión de equilibrio
    %Xe(i)= Kc(i)/(1+Kc(i));
    % Calculo de velocidad de reacción
    %ra(i)= -(k(i)*Ca0*(1-((1+1/Kc(i))*y(i,1))));
%end
%plot(t,SB,'-',t,SC,':');
%xlabel('tiempo(min)');
%ylabel('concetracion(mol/lt)');
%legend('A','B');
%print(SB)