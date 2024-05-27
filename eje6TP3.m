%A+B=>R+S
%RFP
V=100;%lt volumen
P=1;%atm presion
T=160;%C temperatura
K=250;%ltmol/min
%reaccion de oreden 2
F0=87;%mol/min cuadal molar total de alimentacion
%40A y 60B
Ya0=0.4;
Yb0=0.6;

%constantes universales
R=0.082; % atm.lt/(molgr.K)

%cuentas
T0=T+273;% C a K
CA0=(Ya0*P)/(R*T0);%molgr/lt
CA00=CA0*1000;%molgr/m3
CB0=(Yb0*P)/(R*T0);%molgr/lt
CB00=CB0*1000;%molgr/m3

cociente=CA00/CB00;%0.666 y la inversa da 1.5
coc=CB00/CA00;%1.5

Q0=(F0*Ya0)/CA0;%lt/min

%resolucion de coeficiente de integral

INTEGRAL=(K*CA0*V)/(Q0);%  0.0912 deberia ser 0.89 tal vez 0.089
INTEGRALOBTENIDA=INTEGRAL;
z=0;%valor inicial del limite superior de la integral
zpaso=0.01;%paso
zobtenida=z;
error=1000;
%dale 30 iteraciones z=0 y zpaso=0.1 [luego] z= lo que dio-0.1 y zpaso=0.01 [luego] z= lo que dio-0.01 y zpaso=0.001  
for i=1:30% de 1:10 es 10 iteraciones
z=z+zpaso;
digits(5)%necesario
syms x%necesario
funcion= 1/((1-x)*(coc-x));%la funcion a integrar0 REVISAR
limiteinf= 0;%limite inferior0.4737
limitesup= z;%limite superior//0.6
f=int(funcion, x, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral0 =vpa(f,5);
%disp('error original')
%disp(error)
%disp('error cal')
errorCal=((integral0-INTEGRAL)/INTEGRAL)^2;
%disp(errorCal)
if errorCal<=error
    %disp('integral original')
    %disp(INTEGRAL);
    %disp('integral cal')
    %disp(integral0);
    INTEGRALOBTENIDA=integral0;
    %disp('variable obtenida')
    %disp(z);
    zobtenida=z;
    error=errorCal;
end
end
disp('xA')
disp(zobtenida)

%z=0.1
%z=0.12 dberia dar 0.12 para 0.089
%
%

%%segunda parte
X=0.9;
digits(5)%necesario
syms x%necesario
funcion2= 1/((1-x)*(coc-x));%la funcion a integrar0 REVISAR
limiteinf= 0;%limite inferior0.4737
limitesup= X;%limite superior//0.6
f=int(funcion2, x, limiteinf, limitesup);%(funcion , variable, limite inferior, limite superior)
integral2 =vpa(f,5);

VOL=(integral2*Q0)/(K*CA0)%deberia dar 3030lt me dio 3040lt

Num=VOL/V% casi 31



