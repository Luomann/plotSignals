function [signalStructs, signalInforms]= createSignalStructs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SYNTAX: createSignalStructsExample
%
% PURPOSE:
%  Function to create a signalStructs structure to store the signals
% information for plotSignals.m (script)
%
% VARIABLES:
% signalStructs -- Structure about the shot information
% signalInforms -- Cell with signal information in a structure.
%
% NOTES:
%  Written by lz 07/04/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PART1: user setting
signalInformation_script

mdsServer = '202.127.204.12';

%%---------------------- Don't change the following content --------------
%PART2: create structure.
numSignals = length(signalNames);

if isempty(lineWidths)
	lineWidths = ones(1,numSignals);
elseif length(lineWidths)==1
	lineWidths = ones(1,numSignals)*lineWidths;
end

if isempty(idxSubplots)
	idxSubplots = 1:numSignals;
end

numSubplots = length(unique(idxSubplots));

signalInforms = {};
for i=1:numSignals
	signalInforms{i} = struct(...
		'signalName',signalNames{i}, ...
		'mdsTree',mdsTrees{i}, ...
		'plotColor',plotColors, ...
		'lineWidth',lineWidths(i), ...
		'idxSubplot',idxSubplots(i), ...
		'signalYlabel',signalYlabels{i}, ...
		'signalScale',signalScales{i}, ...
		'mdsServer',mdsServer);
end

descriptions = struct(...
	'shotNumbers','Vector of shot numbers', ...
	'numSignals','Number of signals to plot', ...
	'numSubplots','Number of subplots', ...
	'signalInforms','Cell of signal information for signals');

signalStructs =struct(...
	'shotNumbers',shotNumbers, ...
	'numSignals',numSignals, ...
	'numSubplots',numSubplots, ...
	'descriptions',descriptions);

%% Be careful, the signalStructs will be a 1xnumSignals