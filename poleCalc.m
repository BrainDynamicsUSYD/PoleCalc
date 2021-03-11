function [r, p, k] = poleCalc(side,mu,sym,pade_order,balred_order)
s=tf('s');

transfer_fun=TF(side,mu,s,sym);
sysx=pade(transfer_fun,pade_order);
rsys=balred(sysx,balred_order,'StateElimMethod','Truncate'); 

[num, den]=ss2tf(rsys.A,rsys.B,rsys.C,rsys.D);
[Tnum, Tden]=ss2tf(transfer_fun.A,transfer_fun.B,transfer_fun.C,transfer_fun.D);
[r,p,k]=residue(num,den);



% Return residues and poles multiplied by i such that the denominator in
% the expansion is of the form (omega)-i*(pole). 

r=r.*1i;
p=p.*1i;

end

