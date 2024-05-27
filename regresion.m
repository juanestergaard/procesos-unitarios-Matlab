% Definir la función de regresión
%otro matalab
function f=regresion(x,t,Ca0,Ca)
%x(1)=k
%x(2)=n
 n=length(t);
%f = zeros(n, 1);
 for i=1:n
     %f(i) = x(1) * (1 - x(2)) * t(i) - (Ca0^(1 - x(2)) - Ca(i)^(1 - x(2)));
 f(i,1)=x(1)*(1-x(2))*t(i)-(Ca0^(1-x(2))-Ca(i)^(1-x(2)));
 end
end