%EJE 9
%en paralelo
%A=>B k1
%2A=>P k2   %%lo puse de orden 2 mierda
%rB=k1*CA
%rC=k2*CA^2

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
Xafin=0.5;
%Cbmax=max(C(:,2))%encuentra el valor del maximo
CAfin=Ca0*(1-Xafin)
%tmax=t(find(C(:,2)==Cbmax))%aca busca que el tiempo que de == que el max
%disp(C(:,1))
% Supongamos que tienes la matriz C y el valor objetivo es 0.6
%C = [0.6457; 0.6320; 0.6187; 0.6058; 0.5932; 0.5809; 0.5690];
valor_objetivo = CAfin;%el perfecto valor que quiero

% Encuentra el índice del valor más cercano
[valor_cercano, indice] = min(abs(C(:,1) - valor_objetivo));

% Extrae el valor correspondiente de la matriz C
valor_mas_cercano = C(indice, 1);%el valor mas cercano que voy a usar

% Puedes imprimir o usar el valor_mas_cercano según sea necesario
%fprintf('El valor más cercano a %.2f es %.4f\n', valor_objetivo, valor_mas_cercano);
CAfinfin=valor_mas_cercano;

tfin=t(find(C(:,1)==CAfinfin));%tiempo de cuando Ca llega a la convercion
CBfin=C(indice,2);
CCfin=C(indice,3);
disp(CBfin); %valor de Cb en ese tiempo(indice del array)
disp(CCfin); %valor de Cc en ese tiempo(indice del array)
fprintf('cuando la convercionde A alcanza %.2f en el instante t es  %.4f\n  la concentracion de A es %.6f de B es %.8f y de C es  %.10f\n', Xafin, tfin, CAfinfin, CBfin, CCfin);
%Vol_reactor=v*tmax
%Vol_reactor=v*tfin

%solo falta sacar la selectividad pero este ejercicio creo que no entra y
%lo tengo escrito en papel






