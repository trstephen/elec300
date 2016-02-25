%% Import data from text file.
% Auto-generated by MATLAB on 2016/02/24 21:09:11
%% Initialize variables.
filename = 'phase_lag_measurements.csv';
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column1: double (%f)
%	column4: double (%f)
%   column5: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%*s%*s%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
f = dataArray{:, 1};
magH = dataArray{:, 2};
phaseH = dataArray{:, 3};


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% Circuit elements
C = 0.01e-6;
R1 = 14324;
R2 = 1591;

%% Make poles and zeroes
K = R2 / (R1 + R2);
z = -1 / (C * R2);
p = -1 / (C * (R1 + R2) );

%% the business
s = tf('s');
H = K * (s - z) / (s - p);


%% Plotting
% Options for all plots
DefaultOpts = bodeoptions('cstprefs');
DefaultOpts.FreqUnits = 'Hz';

%% Mag plot
% I am a big dumb scrub and couldn't get these to work in a subplot
% Toggle between the mag and phase plot to get output
% hold on
% bodemag(H, 'b--')
% plot(f, magH, 'LineWidth', 2)
% hold off

%% Phase plot
PhasePlot = DefaultOpts;
PhasePlot.MagVisible = 'off';
PhasePlot.PhaseVisible = 'on';

hold on
bodeplot(H, 'b--', PhasePlot)
plot(f, argH, 'LineWidth', 2)
hold off