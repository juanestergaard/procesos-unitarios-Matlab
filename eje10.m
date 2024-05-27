%reaccion en serie %deberia ser como el EJE4 TP3
%{
haber son dos TAC del mismo tamano
Vol?
Vol=t*v
ver tambien la selectividad Y conversion X
armo 2 reactores itero t
saco el que me de mas B al final
CREO que no debo usar derivada 
No esta cambiando porque son cuentas de RFP

%}
%%A=> B => C
%   k1  k2
clear all
v=500;%caudal volumetrico, gal/hr
%constante de velocidad de reaccion
k1=0.5;
k2=0.5;
%concentraciones iniciales
Ca0=6;%C(1)mol/gal
Cb0=0;
Cc0=0;
%tiempo
ti=0;
tf=10;
delta_t=0.1;
%rango_t=inicio:incremento:fin
rango_t=ti:delta_t:tf;%vector de rango de tiempo con incremento delta
C0=[Ca0 Cb0 Cc0];% vector de valores iniciales de concentracion
%C02=[Ca0 Cb0 Cc0];%1,3 /fila , columna

vector_de_ceros1 = zeros(length(rango_t),3);
vector_de_ceros1(1,:)=[Ca0, Cb0, Cc0];
%disp(vector_de_ceros1)
vector_de_ceros2 = zeros(length(rango_t),3);
vector_de_ceros2(1,:)=[Ca0, Cb0, Cc0];
z=size(rango_t);
%disp(z)
for i=1:z(1,2)
    
    %primer tac
    vector_de_ceros1(i,1)=Ca0/(1+k1*rango_t(1,i));
    vector_de_ceros1(i,2)=((Ca0*k1*rango_t(1,i))/((1+k1*rango_t(1,i))*(1+k2*rango_t(1,i))))+(Cb0/((1+k2*rango_t(1,i))));
    vector_de_ceros1(i,3)=(vector_de_ceros1(i,2)*k2*rango_t(1,i))+Cc0;
    %disp(vector_de_ceros1(i,2));
    %disp(i)
    
    %if (i~=z(1,1))
    %C0 = vertcat(C0, [Ca0 Cb0 Cc0]);%agregar una fila
    %end
    %tac 2
    
    
    Ca02=vector_de_ceros1(i,1);%C(1)mol/gal
    Cb02=vector_de_ceros1(i,2);
    Cc02=vector_de_ceros1(i,3);
    vector_de_ceros2(i,1)=Ca02/(1+k1*rango_t(1,i));
    vector_de_ceros2(i,2)=((Ca02*k1*rango_t(1,i))/((1+k1*rango_t(1,i))*(1+k2*rango_t(1,i))))+(Cb02/((1+k2*rango_t(1,i))));
    vector_de_ceros2(i,3)=(vector_de_ceros2(i,2)*k2*rango_t(1,i))+Cc02;
    
    %if (i~=z(1,1))
    %C02 = vertcat(C02, [Ca02 Cb02 Cc02]);
    %end
end
%disp(vector_de_ceros1)
%disp(vector_de_ceros2)
%TAC2
%determniacion tiempo de residencia para maximizar B
Cbmax=max(vector_de_ceros2(:,2));
tmax=rango_t(vector_de_ceros2(:,2)==Cbmax)
Vol_reactor=v*tmax
% Buscar el índice donde Cb es igual a Cbmax
indice_Cbmax = find(vector_de_ceros2(:,2) == Cbmax);
% Obtener las concentraciones correspondientes de Ca y Cc en ese punto
Ca_en_Cbmax = vector_de_ceros2(indice_Cbmax, 1); % Concentración de A en Cbmax
Cc_en_Cbmax = vector_de_ceros2(indice_Cbmax, 3); % Concentración de C en Cbmax
% Mostrar los resultados
fprintf('Concentración de A cuando Cb es máximo: %f\n', Cbmax);
fprintf('Concentración de A cuando Cb es máximo: %f\n', Ca_en_Cbmax);
fprintf('Concentración de C cuando Cb es máximo: %f\n', Cc_en_Cbmax);


%grafico perfiles de concentracion
subplot(1, 2, 1);
plot(rango_t,vector_de_ceros1(:,1),'-',rango_t,vector_de_ceros1(:,2),':',rango_t,vector_de_ceros1(:,3),'--');
title('TAC1');
xlabel('tiempo(h)');
ylabel('concetracion(mol/gal)');
legend('A','B','C');

subplot(1, 2, 2);
plot(rango_t,vector_de_ceros2(:,1),'-',rango_t,vector_de_ceros2(:,2),':',rango_t,vector_de_ceros2(:,3),'--');
title('TAC2');
xlabel('tiempo(h)');
ylabel('concetracion(mol/gal)');
legend('A','B','C');

%{
%ecuaciones diferenciales
dCdt=@(t,C) [-k1*C(1);%reaccion de A para dar B
k1*C(1)-k2*C(2);%formacion de B y desaparece B para dar C
k2*C(2)];%formacion de C
[t,C]=ode45(dCdt,rango_t,C0);
%determniacion tiempo de residencia para maximizar B
Cbmax=max(C(:,2));
tmax=t(find(C(:,2)==Cbmax));
Vol_reactor=v*tmax;
% Buscar el índice donde Cb es igual a Cbmax
indice_Cbmax = find(C(:,2) == Cbmax);
% Obtener las concentraciones correspondientes de Ca y Cc en ese punto
Ca_en_Cbmax = C(indice_Cbmax, 1); % Concentración de A en Cbmax
Cc_en_Cbmax = C(indice_Cbmax, 3); % Concentración de C en Cbmax
% Mostrar los resultados
%fprintf('Concentración de A cuando Cb es máximo: %f\n', Ca_en_Cbmax);
%fprintf('Concentración de C cuando Cb es máximo: %f\n', Cc_en_Cbmax);

%segundo reactor
%CA2=C(find(C(:,2)==Cbmax),1)
%disp();

C02=[Ca_en_Cbmax Cbmax Cc_en_Cbmax]% vector de valores iniciales de concentracion
%ecuaciones diferenciales
dCdt2=@(t,C2) [-k1*C2(1);%reaccion de A para dar B
k1*C2(1)-k2*C2(2);%formacion de B y desaparece B para dar C
k2*C2(2)];%formacion de C
[t,C2]=ode45(dCdt2,rango_t,C02);

%}
