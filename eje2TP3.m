%2A=>P+Q
%TAC
Q=125;%ft3/hr
CA0=3;%lbmol/hr
kequ=16;
K=12;%ft3/hr*lbmol

%
%VOL=???
X=0.85;
%VOL=3nose solo pongo
CA=CA0*(1-X);
ra=K*(CA^2);
t=CA0*X/ra;
VOL=t*Q

%Numero de reactores
CAn=CA;
V1=VOL*0.05;%ft3
t1=V1/Q;%hr
n1=(log(CA0/CAn))/(log(1+(t1*K)))


V2=VOL*0.1;
t2=V2/Q;
n2=(log(CA0/CAn))/(log(1+(t2*K)))

%n2<n1 
%un TAD grande, 2TAD pequenos, 3TAD aun mas pequenos