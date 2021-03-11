%plotting numerical ERP:
%choose the arousal state in the TF.m file.

clear
% Testing padeorders and balred
BodeOpts = bodeoptions;
BodeOpts.Title.FontSize = 16;
BodeOpts.Title.String='';
BodeOpts.XLabel.FontSize = 16;
BodeOpts.YLabel.FontSize = 16;
BodeOpts.YLabel.Interpreter='latex';
BodeOpts.TickLabel.FontSize = 14;
BodeOpts.PhaseVisible = 'off';
BodeOpts.MagUnits='abs';
BodeOpts.FreqUnits = 'Hz';
BodeOpts.Grid='off';
side=0;
pade_order=8;
modeNum=1;
mu=1;
sym=0;
s = tf('s');

T=TF(side,modeNum,s,sym);
%bodeplot(T,BodeOpts); % plot the transfer function

sysx=pade(T,pade_order);
impulse(sysx) 
set(findall(gcf,'type','line'),'linewidth',1.3)

