function [transfer_function, C,D,I]=TF(side,modeNum,s,sym)

load Eigenmodes.mat
if side==0
    kSq=k_eta_sqs_L(modeNum);
else
    kSq=k_eta_sqs_R(modeNum);
end
s=tf('s');

%define parameters of the model

gamma_e=116;% Cortical damping rate 116 s^-1

%gain parameters:

Stage='EO'; %choose the stage 
switch (Stage)
    case 'EC'
        G_es=0.77; % Taken from R.G Abeysuriya et al (2015)
        G_se=7.77;
        G_sr=-3.30;
        G_rs=0.20;
        G_re=0.66;
        G_sn=8.10;
        G_ee=2.07;
        G_ei=-4.11;

       G_ese= G_es*G_se;
       G_erse=G_es*G_sr*G_re;
       G_srs= G_sr*G_rs;
       G_esn=G_es*G_sn;
       %t_0=0.085; %  Corticothalamic loop delay  0.085 Second
       t_0=0.08;

       alpha=80; %  Inverse synaptodendritic decay time 83.3 S^-1 (wake) 
       beta=320;  %  Inverse synaptodendritic rise time 770 S^-1 (wake)   
       r_e=86;% excitatory axon range (0.086 m) These units need to match those of k^2 (mm)
       G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
       t_LR=0.02; 
        
    case 'EO'
        G_es=1.21; % Taken from R.G Abeysuriya et al (2015)
        G_se=5.78;
        G_sr=-2.83;
        G_rs=0.25;
        G_re=0.85;
        G_sn=14.23;
        G_ee=10.50;
        G_ei=-13.22;

       G_ese= G_es*G_se;
       G_erse=G_es*G_sr*G_re;
       G_srs= G_sr*G_rs;
       G_esn=G_es*G_sn;
       t_0=0.08; %  Corticothalamic loop delay  0.085 Second

       alpha=80; %  Inverse synaptodendritic decay time 83.3 S^-1 (wake) 
       beta=320;  %  Inverse synaptodendritic rise time 770 S^-1 (wake)   
       r_e=86;% excitatory axon range (0.086 m) These units need to match those of k^2 (mm)
       G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
       t_LR=0.02; 
       
    case 'EO-T.B'
      G_es=1.7; % Taken from R.G Abeysuriya et al (2015)
        G_se=2.5;
        G_sr=-1.9;
        G_rs=0.19;
        G_re=1;
        G_sn=0.8;
        G_ee=6.8;
        G_ei=-8.1;

       G_ese= G_es*G_se;
       G_erse=G_es*G_sr*G_re;
       G_srs= G_sr*G_rs;
       G_esn=G_es*G_sn;
       t_0=0.08; %  Corticothalamic loop delay  0.085 Second

       alpha=80; %  Inverse synaptodendritic decay time 83.3 S^-1 (wake) 
       beta=320;  %  Inverse synaptodendritic rise time 770 S^-1 (wake)   
       r_e=86;% excitatory axon range (0.086 m) These units need to match those of k^2 (mm)
       G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
       t_LR=0.02;
       
    case 'REM'
       G_es=0.21; % Taken from R.G Abeysuriya et al (2015)
        G_se=0.66;
        G_sr=-0.28;
        G_rs=4.59;
        G_re=2.08;
        G_sn=0.68;
        G_ee=5.87;
        G_ei=-6.61;

       G_ese= G_es*G_se;
       G_erse=G_es*G_sr*G_re;
       G_srs= G_sr*G_rs;
       G_esn=G_es*G_sn;
       t_0=0.08; %  Corticothalamic loop delay  0.085 Second

       alpha=80; %  Inverse synaptodendritic decay time 83.3 S^-1 (wake) 
       beta=320;  %  Inverse synaptodendritic rise time 770 S^-1 (wake)   
       r_e=86;% excitatory axon range (0.086 m) These units need to match those of k^2 (mm)
       G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
       t_LR=0.02;  
       
    case 'S1'
      
       G_es=0.31; % Taken from R.G Abeysuriya et al (2015)
        G_se=1.67;
        G_sr=-0.40;
        G_rs=4.44;
        G_re=7.47;
        G_sn=3.90;
        G_ee=7.45;
        G_ei=-8.30;

       G_ese= G_es*G_se;
       G_erse=G_es*G_sr*G_re;
       G_srs= G_sr*G_rs;
       G_esn=G_es*G_sn;
       t_0=0.08; %  Corticothalamic loop delay  0.085 Second

       alpha=80; %  Inverse synaptodendritic decay time 83.3 S^-1 (wake) 
       beta=320;  %  Inverse synaptodendritic rise time 770 S^-1 (wake)   
       r_e=86;% excitatory axon range (0.086 m) These units need to match those of k^2 (mm)
       G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
       t_LR=0.02; 
    case 'S2'
       G_es=3.89; % Taken from R.G Abeysuriya et al (2015)
        G_se=0.07;
        G_sr=-0.14;
        G_rs=8.33;
        G_re=4.96;
        G_sn=2.38;
        G_ee=16.86;
        G_ei=-17.93;

       G_ese= G_es*G_se;
       G_erse=G_es*G_sr*G_re;
       G_srs= G_sr*G_rs;
       G_esn=G_es*G_sn;
       t_0=0.08; %  Corticothalamic loop delay  0.085 Second

       alpha=80; %  Inverse synaptodendritic decay time 83.3 S^-1 (wake) 
       beta=320;  %  Inverse synaptodendritic rise time 770 S^-1 (wake)   
       r_e=86;% excitatory axon range (0.086 m) These units need to match those of k^2 (mm)
       G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
       t_LR=0.02; 
    case 'SWS'
        G_es=5.30; % Taken from R.G Abeysuriya et al (2015)
        G_se=0.22;
        G_sr=-0.22;
        G_rs=1.35;
        G_re=1.90;
        G_sn=1.70;
        G_ee=19.52;
        G_ei=-19.74;

       G_ese= G_es*G_se;
       G_erse=G_es*G_sr*G_re;
       G_srs= G_sr*G_rs;
       G_esn=G_es*G_sn;
       t_0=0.08; %  Corticothalamic loop delay  0.085 Second

       alpha=80; %  Inverse synaptodendritic decay time 83.3 S^-1 (wake) 
       beta=320;  %  Inverse synaptodendritic rise time 770 S^-1 (wake)   
       r_e=86;% excitatory axon range (0.086 m) These units need to match those of k^2 (mm)
       G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
       t_LR=0.02; 
      case 'Spindle'
        G_es=2.55; % Taken from R.G Abeysuriya et al (2015)
        G_se=0.73;
        G_sr=-0.26;
        G_rs=16.92;
        G_re=4.67;
        G_sn=2.78;
        G_ee=18.52;
        G_ei=-18.96;

       G_ese= G_es*G_se;
       G_erse=G_es*G_sr*G_re;
       G_srs= G_sr*G_rs;
       G_esn=G_es*G_sn;
       t_0=0.08; %  Corticothalamic loop delay  0.085 Second

       alpha=80; %  Inverse synaptodendritic decay time 83.3 S^-1 (wake) 
       beta=320;  %  Inverse synaptodendritic rise time 770 S^-1 (wake)   
       r_e=86;% excitatory axon range (0.086 m) These units need to match those of k^2 (mm)
       G_ee_LR=0.7665; %interhemispheric coupling to have I_ee=0.15
       t_LR=0.02; 
       
end




L=(1/(1.0+(s)/alpha))*(1/(1.0+(s)/beta));

C= (L^2*G_esn*exp(-s*t_0/2))/((1-L^2*G_srs)*(1-L*G_ei));

D= (1+(s)/gamma_e)^2-1/(1-L*G_ei)*(L*G_ee+((L^2*G_ese+L^3*G_erse)*exp(-s*t_0)/(1-L^2*G_srs)));

I= (L*G_ee_LR*exp(-s*t_LR))/(1-L*G_ei);



transfer_function= (0.0557)*(C/(D-sym*I+r_e^2*kSq));%Note that "0.0557" is the normalization factor for the EO state, so for the other states of arousal please change it according to the values given below.

%normalization factors:
%E0:0.0557
%EC:0.0647
%REM:5.7202
%S1:0.9084
%S2:0.1610
%SWS:0.0892
%Spindle:0.3614



end


