
%this code enables us to plot numerical and approximated transfer function,and calculate the rms error values.

clear all
pade_order=8;
balred_order=10; %choose the number of poles
k=0;
sym=0;
mu=1;
side=0;
t=0:0.001:2;
L=length(t);
om=linspace(0,300,L/2+1);
f=om./(2*pi);
state='EO';
% plot numerical transfer function
num_TF=T_state(k,om,sym,state);
semilogx(f,abs(num_TF))

%plot approximated transfer fuction
[r, p] = poleCalc(side,mu,sym,pade_order,balred_order);
T_app=0;
for n=1:1:length(p)
    T_app=T_app+(r(n)./(om-p(n)));
    
    
end
semilogx(f,abs(T_app))

%from the above code we can plot the analytical transfer function vs. approximated one (for the chosen number of poles) which was used to plot FIG.10 and do the transfer functions' plots in FIGs.8,9&11.
 

%Calculating rms error between analytical and approximated transfer functions:

 rms2=(sqrt(mean((abs(num_TF)-abs(T_app)).^2)))./sqrt(mean((abs(num_TF)).^2))%normalized rms 

%values of rms error for the different states of arousal for different
%number of poles up to 14 poles:
 
A=[1 2 3 4 5 6 7 8 9 10 11 12 13 14];
R1=[0.3156 0.4167 0.0856 0.1728 0.0373 0.0418 0.0196 0.0131 0.0151 0.0038 0.0078 0.0018 0.0021 8.5130e-04];%EO
R2=[0.4889 0.6428 0.1604 0.1631 0.0511 0.0817 0.0191 0.0188 0.0067 0.0070 0.0059 0.0022 0.0022 0.0017];%EC
R3=[0.5531 0.4878 0.2773 0.1597 0.0729 0.0421 0.0181 0.0141 0.0041 0.0040 0.0039 0.0010 8.3542e-04 6.4203e-04];%REM
R4=[0.5674 0.5361 0.3379 0.1791 0.0939 0.0457 0.0370 0.0202 0.0221 0.0062 0.0058 9.5631e-04 9.5858e-04 2.0025e-04];%S1
R5=[0.4963 0.2939 0.2830 0.0892 0.1289 0.0360 0.0336 0.0085 0.0168 0.0042 0.0040 6.2171e-04 6.2401e-04 1.4676e-04];%S2
R6=[0.3599 0.1284 0.1395 0.0392 0.0388 0.0168 0.0152 0.0042 0.0074 0.0020 0.0019 4.0036e-04 3.9989e-04 2.4850e-04];%SWS
R7=[0.5574 0.5247 0.3743 0.2876 0.1037 0.0550 0.0240 0.0276 0.0244 0.0080 0.0093 0.0024 0.0023 0.0011];%SWS
R8=[0.5674 0.6428 0.3743 0.2876 0.1289 0.0817 0.0370 0.0276 0.0244 0.0080 0.0093 0.0024 0.0023 0.0017];%Highest rms value across all the states for each indicated number of poles.

%plotting FIG.12
figure()
bar(A,R1)
hold off
xlabel('number of poles')
figure()
bar(A,R2)
hold off
xlabel('number of poles')
figure()
bar(A,R3)
hold off
xlabel('number of poles')
figure()
bar(A,R4)
hold off
xlabel('number of poles')
figure()
bar(A,R5)
hold off
xlabel('number of poles')
figure()
bar(A,R6)
hold off
xlabel('number of poles')
figure()
bar(A,R7)
hold off
xlabel('number of poles')
figure()
bar(A,R8)
hold off
xlabel('number of poles')















