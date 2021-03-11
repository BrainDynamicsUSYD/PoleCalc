%this code enables to evaluate the approximated ERP and plot it vs time.

clear
% Code that runs poleCalc with specific inputs. 

% select cortical hemisphere (left=0 or right=1)
side=0;
% Select mode 
mu=1;

% Select symmetric (+1) or antisymmetric (-1) BH modal activity
sym=0;
s=tf('s');
% Select approximation orders 
pade_order=8;
balred_order=10; % This determines how many poles there are in the expansion (M in the documentation)


[residues, poles] = poleCalc(side,mu,sym,pade_order,balred_order);
x=real(poles);
y=imag(poles);
%scatter(x,y): used to determine pole locations figures (e.g. FIG.4&FIG.7)

%formula for the ERP

% traverse the poles vector and make two vectors, I, Q (I refers to
% oscillatory poles and Q to purely damped poles)
I=0;
Q=0;
t=0:0.001:2;
t_0=0;

for n=1:length(poles)
    if real(poles(n))==0
        Q(end+1)=poles(n);
    else
        I(end+1)=poles(n);
    end
end
Q(1)=[];
I(1)=[];

I_res=0;
Q_res=0;

for n=1:length(residues)
    if real(residues(n))==0
        Q_res(end+1)=residues(n);
    else
        I_res(end+1)=residues(n);
    end
end
Q_res(1)=[];
I_res(1)=[];
erp1=0;
for n=1:2:length(I)
    erp1=erp1+2.*exp(imag(I(n)).*(t-t_0)).*((imag(I_res(n)).*cos((real(I(n))).*(t-t_0)))-(real(I_res(n)).*sin(real(I(n)).*(t-t_0))));         
end

erp2=0;
for n=1:2:length(Q)

erp2=erp2+(imag(Q_res(n)).*exp(imag(Q(n)).*(t-t_0)))+(imag(Q_res(n+1)).*exp(imag(Q(n+1)).*(t-t_0)));
end
erp=erp1+erp2;
plot(t,erp) 




%in order to plot FIG.6 we need to get the formula of the ERP upon considering poles at specific frequencies such that:

erp_Beta=0;

    erp_Beta=erp_Beta+2.*exp(imag(I(9)).*(t-t_0)).*((imag(I_res(9)).*cos((real(I(9))).*(t-t_0)))-(real(I_res(9)).*sin(real(I(9)).*(t-t_0))));   
    
erp_alpha=0;

 erp_alpha=erp_alpha+2.*exp(imag(I(11)).*(t-t_0)).*((imag(I_res(11)).*cos((real(I(11))).*(t-t_0)))-(real(I_res(11)).*sin(real(I(11)).*(t-t_0))));
    
erp_low=0;

erp_low=erp_low+(imag(Q_res(1)).*exp(imag(Q(1)).*(t-t_0)))+(imag(Q_res(2)).*exp(imag(Q(2)).*(t-t_0)));

erp_high=0;
 

erp_high=erp_high+2.*exp(imag(I(1)).*(t-t_0)).*((imag(I_res(1)).*cos((real(I(1))).*(t-t_0)))-(real(I_res(1)).*sin(real(I(1)).*(t-t_0))))+2.*exp(imag(I(3)).*(t-t_0)).*((imag(I_res(3)).*cos((real(I(3))).*(t-t_0)))-(real(I_res(3)).*sin(real(I(3)).*(t-t_0))))+2.*exp(imag(I(5)).*(t-t_0)).*((imag(I_res(5)).*cos((real(I(5))).*(t-t_0)))-(real(I_res(5)).*sin(real(I(5)).*(t-t_0))))+2.*exp(imag(I(7)).*(t-t_0)).*((imag(I_res(7)).*cos((real(I(7))).*(t-t_0)))-(real(I_res(7)).*sin(real(I(7)).*(t-t_0))));


% %plotting FIG6
% figure()
% plot(t,erp)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% hold on 
% plot(t,erp_low)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% hold off
% xlim([0 1])
% xlabel \itt(seconds);
% ylabel ERP(\itt)
% figure()
% plot(t,erp)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% hold on 
% plot(t,erp_alpha)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% hold off
% xlim([0 1])
% xlabel \itt(seconds)
% ylabel ERP(\itt)
% figure()
% plot(t,erp)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% hold on 
% plot(t,erp_Beta)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% hold off
% xlim([0 1])
% xlabel \itt(seconds)
% ylabel ERP(\itt)
% figure()
% plot(t,erp)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% hold on 
% plot(t,erp_high)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% hold off
% xlim([0 1])
% xlabel \itt(seconds)
% ylabel ERP(\itt)
% figure()
% plot(t,erp_low+erp_alpha+erp_Beta)
% set(findall(gcf,'type','line'),'linewidth',1.3)
% xlim([0 1])
% xlabel \itt(seconds)
% ylabel ERP(\itt)

