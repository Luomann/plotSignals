%% Information for signals to plot.

shotNumbers = [54901];
signalNames = {'pcrl01','lmsr','lmsz','pcic1'};
mdsTrees = {'pcs_east','pcs_east','pcs_east','pcs_east'};
plotColors= ['blue ']; % number of plotColors should consistent with shotNumbers
lineWidths = 2;
idxSubplots = [];
signalYlabels = {'IP [kA]', 'R [m]', 'Z [m]', 'IC [kA]'};
signalScales = {1e-3, 1, 1, 1e-3};