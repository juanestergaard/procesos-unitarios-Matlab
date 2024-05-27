%eje3TP3
%A+B=>E

CA0=1.5;%mol/ft3
CB0=1.5;%mol/ft3
k=2;%ft3/mol*hr
FA0=50;%mol lb/hr

%CUENTAS
Q=FA0/CA0;%ft3/hr caudal
V=10;%ft3 volumen
t=V/Q;%hr tiempo de residencia
XA1=1-(1/((k*CA0*V/Q)+(1/1-0)))%0.47

XA2=1-(1/((k*CA0*V/Q)+(1/(1-XA1))))%0.64

Q1=0.6*Q;
Q2=0.4*Q;
XA3=1-(1/((k*CA0*V/Q1)+(1/1-0)))%0.6
XA4=1-(1/((k*CA0*V/Q2)+(1/1-0)))%0.692

FA1=CA0*Q1*(1-XA3)%11.9
FA2=CA0*Q2*(1-XA4)%6.19
FAT=FA1+FA2%18.18

XAG=((CA0*Q)-FAT)/(CA0*Q)%0.637


%bucle for cambiando el limite de integracion y sabiendo el resultado de la
%z1=0;

%for i=[1 2 3 4 5 9]
   %disp('respuesta')
   %disp(i)
   %fprintf('texto e %d \n',i);
   %z1=z1+10;
%end

INTEGRAL=(k*CA0*V)/(Q2);
INTEGRALOBTENIDA=INTEGRAL;
z=0.5;%valor inicial del limite superior de la integral
zpaso=0.01;%paso
zobtenida=z;
error=1000;
%dale 30 iteraciones z=0 y zpaso=0.1 [luego] z= lo que dio-0.1 y zpaso=0.01 [luego] z= lo que dio-0.01 y zpaso=0.001  
for i=1:30% de 1:10 es 10 iteraciones
z=z+zpaso;
digits(5)%necesario
syms x%necesario
funcion= 1/((1-x)^2);%la funcion a integrar0 REVISAR
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
%disp('integral calculada')
%disp(INTEGRALOBTENIDA)
%disp()
%disp('error')
%disp(error)


%1:20 da [1 2 ... 20]
%integral calcular error
%ejemplo de integral
