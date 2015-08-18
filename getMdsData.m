function [time,data] = getMdsData(signal,shot,scale,tree, dserver)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SYNTAX: [time, data] = getMdsData(signal,shot,tree, dserver)
%
% PURPOSE:
%  Function to retrieve MDS+ data
%
% VARIABLES:
%  signal  (Input) --- signal name
%  shot    (Input) --- shot number
%  scale   (Input) --- Scale value (for units transfer)
%  tree    (Input) --- MDS+ tree name
%  dserver (Input) --- MDS+ data server
%
%  time   (Output) --- Time coordinate of the given signal in MDS+
%  data   (Output) --- Data value of the given signal in MDS+
%
% NOTES:
%  Written by lz 07/04/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin < 4)
    tree = 'pcs_east';
    dserver = '202.127.204.12';
elseif (nargin < 5)
    dserver = '202.127.204.12';
end

mdsconnect(dserver);
mdsopen(tree,shot);

time = mdsvalue(['dim_of(\',signal,')']);
data = mdsvalue(['\',signal])*scale;