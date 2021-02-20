SITES = readtable('tmo-site.csv');

disp(SITES)

names = {};
heights = [];
lats = [];
lngs = [];

id = 1;
for i = 1:height(SITES)
    names = [names string(SITES{i,'Var2'})];
    heights(id) = SITES{i, 'Var4'};
    lats(id) = SITES{i, 'Var11'};
    lngs(id) = SITES{i, 'Var12'};
    id = id + 1;
end

pm = propagationModel("longley-rice", 'TimeVariabilityTolerance', 0.7) + ...
       propagationModel("gas");

tx = txsite('Name', [names{:}], 'Latitude',lats,'Longitude',lngs,'AntennaHeight', heights,...
    'SystemLoss',20, 'TransmitterFrequency',1831e6, 'TransmitterPower',18);

strongSignal = -70;
strongSignalColor = "g";
mediumSignal = -80;
mediumSignalColor = "y";
weakSignal = -90;
weakSignalColor = "r";
eeIndoorSignal = -100;
eeIndoorSignalColor = "m";
eeNoSignal = -110;
eeNoSignalColor = "b";

coverage(tx, 'PropagationModel', pm, 'Type', 'power', ...
    'SignalStrengths',[strongSignal,mediumSignal,weakSignal,eeIndoorSignal, eeNoSignal], ...
    'Colors', [strongSignalColor,mediumSignalColor,weakSignalColor,eeIndoorSignalColor,eeNoSignalColor])