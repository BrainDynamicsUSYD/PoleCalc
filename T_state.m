function [transfer_Fun,C,D,I]=T_state(k,om,sym,state)
% calculates the transfer function for a mode (with eigenvalue k) at a specific frequency om,
% sym specifies whether there is sym/anti-sym interhemispheric coupling (or
% none at all, sym=0 for one hemisphere). 

switch state
    case 'EO' 
        alpha=80;
        beta=320;
        G_ee=10.5;
        G_ei=-13.22;
        G_es=1.21;
        G_se=5.78;
        G_sr=-2.83;
        G_sn=14.23;
        G_re=0.85;
        G_rs=0.25;       
       
    case {'EC'}
        alpha=80;
        beta=320;
        G_ee=2.07;
        G_ei=-4.11;
        G_es=0.77;
        G_se=7.77;
        G_sr=-3.3;
        G_sn=8.10;
        G_re=0.66;
        G_rs=0.20;
              
        
    case {'REM'}
        alpha=80;
        beta=320;
        G_ee=5.87;
        G_ei=-6.61;
        G_es=0.21;
        G_se=0.66;
        G_sr=-0.28;
        G_sn=0.68;
        G_re=2.08;
        G_rs=4.59;
        
        
    case {'S1'}
        alpha=80;
        beta=320;
        G_ee=7.45;
        G_ei=-8.30;
        G_es=0.31;
        G_se=1.67;
        G_sr=-0.4;
        G_sn=3.90;
        G_re=7.47;
        G_rs=4.44;
    case {'S2'}
        alpha=80;
        beta=320;
        G_ee=16.86;
        G_ei=-17.93;
        G_es=3.89;
        G_se=0.07;
        G_sr=-0.14;
        G_sn=2.38;
        G_re=4.96;
        G_rs=8.33;  
                
    case {'SWS'}
        alpha=80;
        beta=320;  
        G_ee=19.52;
        G_ei=-19.74;
        G_es=5.30;
        G_se=0.22;
        G_sr=-0.22;
        G_sn=1.70;
        G_re=1.90;
        G_rs=1.35;
    case {'Spindle'}
        alpha=80;
        beta=320;
        G_ee=18.52;
        G_ei=-18.96;
        G_es=2.55;
        G_se=0.73;
        G_sr=-0.26;
        G_sn=2.78;
        G_re=4.67;
        G_rs=16.92;
    otherwise
        warning('Please specify a valid brain state')
end


gamma_e=116; %s^-1
r_e=86; %m
% tau_es=0.045;
%tau_se=0.040;
tau_es=0.02;
tau_se=0.06;

G_ese= G_es*G_se;
G_erse=G_es*G_sr*G_re;
G_srs= G_sr*G_rs;
G_esn=G_es*G_sn;
G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
t_LR=0.02; %interhemispheric loop delay


%write all parameters in a file to output

L=(1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta));

C= (L.^2*G_esn.*(exp(1j*om*tau_es)))./((1-(L.^2.*G_srs)).*(1-(L.*G_ei)));

D= (1-(1j*om)/gamma_e).^2-(1./(1-(L.*G_ei))).*(L*G_ee+(((L.^2*G_ese+L.^3*G_erse)).*exp(1j*om*(tau_es+tau_se)))./(1-(L.^2*G_srs)));

I= (L*G_ee_LR.*exp(1j*om*t_LR))./(1-(L.*G_ei));


transfer_Fun= ((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_esn.*(exp(1j*om*tau_es)))./(((1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2.*G_srs)).*(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei))))./((1-(1j*om)/gamma_e).^2-(1./(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei))).*(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta)))*G_ee+(((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_ese+((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^3*G_erse)).*exp(1j*om*(tau_es+tau_se)))./((1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_srs))))-sym.*((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta)))*G_ee_LR.*exp(1j*om*t_LR))./(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei)))+r_e^2*k));

y= @(om) abs((((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_esn.*(exp(1j*om*tau_es)))./(((1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2.*G_srs)).*(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei))))./((1-(1j*om)/gamma_e).^2-(1./(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei))).*(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta)))*G_ee+(((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_ese+((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^3*G_erse)).*exp(1j*om*(tau_es+tau_se)))./((1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_srs))))-sym.*((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta)))*G_ee_LR.*exp(1j*om*t_LR))./(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei)))+r_e^2*k))).*abs(((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_esn.*(exp(1j*om*tau_es)))./(((1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2.*G_srs)).*(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei))))./((1-(1j*om)/gamma_e).^2-(1./(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei))).*(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta)))*G_ee+(((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_ese+((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^3*G_erse)).*exp(1j*om*(tau_es+tau_se)))./((1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).^2*G_srs))))-sym.*((((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta)))*G_ee_LR.*exp(1j*om*t_LR))./(1-(((1./(1-(1j*om)/alpha)).*(1./(1-(1j*om)/beta))).*G_ei)))+r_e^2*k))));
z=integral(y,0,200);
norm_fact=sqrt(1/z);
transfer_Fun=sqrt(1/z).*transfer_Fun;



end