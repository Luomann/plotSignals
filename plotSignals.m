%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SYNTAX: plotSignals
%
% PURPOSE:
%  Script to plot multiple signals in one figure with only one time
% coordinates.
%
% VARIABLES:
%
% NOTES:
%  Written by lz 07/04/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Create input structure
[signalStructs, signalInforms] = createSignalStructs;
% if 1 % 4 debugging
% 	[signalStructs, signalInforms] = createSignalStructsExample;
% end

%% Decomposition the structure
shotNumber = signalStructs.shotNumbers;
numSignals = signalStructs.numSignals;
numShots = length(shotNumber);
numSubplots = signalStructs.numSubplots;

%% Retrieving data from MDS+
disp('Retrieving data from MDS+ ...');
for i=1:numSignals
	for j=1:numShots
		[timeTemp,dataTemp] = getMdsData(signalInforms{i}.signalName, ...
			shotNumber(j), signalInforms{i}.signalScale, ...
			signalInforms{i}.mdsTree, signalInforms{i}.mdsServer);
		timeVec{j} = timeTemp;
		dataVec{j} = dataTemp;
	end
	signalTime{i} = timeVec;
	signalData{i} = dataVec;
end

%% plot figure
titleName = [];
figure(1);clf
for i=1:numSignals
	eval(['h',int2str(i),'=subplot(',int2str(numSubplots),',1,',...
		int2str(signalInforms{i}.idxSubplot),');']);
	eval(['pos',int2str(i),'=get(h',int2str(i),',''position'');']);
	eval(['set(h',int2str(i),',''fontsize'',14);']);

	if numShots > 1
		hold on
	end
	for j=1:numShots % plot multi-shots
		plot(signalTime{i}{j},signalData{i}{j},...
			'linewidth',signalInforms{i}.lineWidth,...
			'color',signalInforms{i}.plotColor(j,:));

		titleName = [titleName,[' {\color{',signalInforms{i}.plotColor(j,:),'}',int2str(shotNumber(j)),'}']];
	end
	hold off
	box on
	if (i==1)
		title(titleName)
	end
	if (i==numSignals)
		xlabel('Time [s]')
	end
	if mod(i,2)==0
		eval(['h',int2str(i),'.YAxisLocation=','''right'';']);
	end
	ylabel(signalInforms{i}.signalYlabel);
		
end

% Re-scale
while (1)
	timeMinMax = input('Input rescaling time range as: [1 2] or 0  ');
	if timeMinMax == 0
		disp('No scaling ...');
		break;
	else
		for in=1:numSignals
			eval(['subplot(',int2str(numSignals),',1,',int2str(in),');']);
			xlim([timeMinMax(1) timeMinMax(end)])
		end
	end
end


% delete the blank between two subplots.
for i=1:numSignals-1
	eval(['pos',int2str(i+1),'(3)=pos',int2str(i),'(3);']);
	eval(['pos',int2str(i+1),'(2)=pos',int2str(i),'(2)-pos',int2str(i+1),'(4);']);
	eval(['set(h',int2str(i+1),',''position'',pos',int2str(i+1),');'])
	eval(['pos',int2str(i+1),'=get(h',int2str(i+1),',''position'');']);
end