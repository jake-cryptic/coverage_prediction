SITES = readtable('unilaterals.csv', 'Format','auto');

disp(SITES)

names = {};
heights = [];
lats = [];
lngs = [];

id = 1;
for i = 1:height(SITES)
    if strcmp(SITES{i, 'Decision'}, 'refused') == 0
        names = [names SITES{i,'LPANumber'}];
        heights(id) = SITES{i, 'Height'};
        lats(id) = SITES{i, 'y'};
        lngs(id) = SITES{i, 'x'};
        id = id + 1;
    end
end

tx = txsite('Name', [names{:}], 'Latitude',lats,'Longitude',lngs,'AntennaHeight', heights,...
    'SystemLoss',20, 'TransmitterFrequency',3500e6, 'TransmitterPower',20);

strongSignal = -70;
strongSignalColor = "g";
mediumSignal = -80;
mediumSignalColor = "y";
weakSignal = -90;
weakSignalColor = "r";

coverage(tx, 'Type', 'power', ...
    'SignalStrengths',[strongSignal,mediumSignal,weakSignal], ...
    'Colors', [strongSignalColor,mediumSignalColor,weakSignalColor])