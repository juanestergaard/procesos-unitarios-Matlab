
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



