# PoleCalc:
Introduction:

This documentation helps you use the code to plot the analytical figures plotted in th “Modal-polar representation of ERPs in multiple arousal states” paper. In this document, we show you the steps needed to plot FIG.11 in that paper as an example although the code includes comments that help you plot the other figures too.

Installation:
-	To run this code, you need Matlab to be installed.
-	Download the eigenmodes.mat file together with the other Matlab scripts.

Steps:
To plot FIG.11a:
-	Open the rms_error.m file.
-	Choose the state of arousal by entering:
“ state=’EO’ “ for the eyes open state
-	Select the code from the beginning up to semilogx(f,abs(num_TF), then right click and evaluate selection.
 
Output: The above step plots the numerical transfer function vs frequency for the EO state.

-	Now, type in the command window: “hold on”
-	And repeat the previous step but enter “state=’EC’”to plot the transfer function for the eyes-closed state in the same figure
-	Type hold on again in the command window and do the same steps for the REM, S1, S2, SWS, and the Spindle states.

Output: You will get FIG.11a that shows the numerical transfer function vs. frequency for the different states of arousal.


To plot FIG.11b

-	Open the rms.m file.
-	Comment semilogx(f,abs(num_TF).
-	Choose the balred_order that you want which determines the number of poles in th expansion. (in FIG.11b we did a 10-pole approximation so you can type “balred_order=10”).
-	Choose the state of arousal by entering:
“ state=’EO’ “ for the eyes open state.




-	Select the code from the beginning up to semilogx(f,abs(T_app)), then right click and evaluate selection.



Output: The above step plots the numerical transfer function vs frequency for the EO state.

-	Now, type in the command window: “hold on”
-	And repeat the previous step but enter “state=’EC’” to plot the approximated transfer function for the eyes-closed state in the same figure
-	Type hold on again in the command window and do the same steps for the REM, S1, S2, SWS, and the Spindle states.

Output: You will get FIG.11b that shows the approximated transfer function vs. frequency for the different states of arousal.


To plot FIG.11c:


-	Open the TF.m file.
-	Type ‘EO’ next to stage to plot the approximated transfer function for the eyes-open state.
-	In the end of the TF.m script , multiply the “transfer_function” by the normalization factor of the chosen stage. (the normalization factors for each arousal state are given below the “transfer_function” formula, you will notice that it is multiplied it by 0.0557 that is the normalization factor of the EO state, so make sure to change this value for the other arousal states).
-	Open the plotting_TFs.m file and run it.
Output: you will get the ERP vs time for the EO state.
-	Type “hold on” in the command window, open TF.m file  and follow the same steps for the EC state (don’t forget to multiply transfer_function by the normalization factor specific for each state!).
-	Type “hold on” again and follow the same steps.

Output: You’ll get the numerical ERP vs time for the EO, EC, and REM states, that is FIG.11c.


To plot FIG.11d:
-	Open the TF.m file.
-	Type ‘EO’ next to stage to plot the approximated transfer function for the eyes-open state.
-	In the end of the TF.m script , multiply the “transfer_function” by the normalization factor of the chosen stage. (the normalization factors for each arousal state are given below the “transfer_function” formula, you will notice that it is multiplied it by 0.0557 that is the normalization factor of the EO state, so make sure to change this value for the other arousal states).



-	Open the testingPoleCalc2.m  file.
-	Choose the balred_order that you want which determines the number of poles in th expansion. (in FIG.11d we did a 10-pole approximation so you can type “balred_order=10”).
-	Run the code.
-	Type “hold on” in the command window, open the TF.m file and follow the same steps for the EC state (don’t forget to multiply transfer_function by the normalization factor specific for each state!).
-	Type “hold on” again and follow the same steps.
Output: You’ll get the approximated ERP vs time for the EO, EC, and REM states, that is FIG.11d.


To plot FIG.11f and FIG.11h:

Follow the same steps as for FIG.11d but for the S1 and S2 states in FIG.11f, and for SWS and Spindle states for FIG.11h.


To plot FIG.11e and FIG.11g:

Follow the same steps as for FIG.11c but for the S1 and S2 states in FIG.11e, and for SWS and Spindle states for FIG.11g.
