function plot_shot_coords(shot_num)

opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Latitude", "Longitude", "Description", "Label", "PlacemarkNumber"];
opts.VariableTypes = ["double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Description", "Label"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["Description", "Label"], "ThousandsSeparator", ",");

% Import the data
shot = readtable("F:\work\sound_work\shots\shot" + string(shot_num)+".csv", opts);
clear opts
%%
pan_l = [shot.Latitude(1), shot.Longitude(1)];
az_l = deg2rad(346);
pan_r = [shot.Latitude(2), shot.Longitude(2)];
az_r = deg2rad(350);

% Длина стрелки (можно менять в зависимости от нужного масштаба)
distance = 0.001; 

d_l = [distance * cos(az_l), distance * sin(az_l)];
d_r = [distance * cos(az_r), distance * sin(az_r)];
% Вычисляем смещение по широте и долготе
end_l = pan_l + d_l;
end_r = pan_r + d_r;

q_pan_l = [pan_l; end_l];
q_pan_r = [pan_r; end_r];

fig = figure;
gx = geoaxes;
% x = [rep(1), pan_l(1), pan_r(1)];
% y = [rep(2), pan_l(2), pan_r(2)];

x = [pan_l(1), pan_r(1)];
dx = [d_l(1), d_r(1)];
y = [pan_l(2), pan_r(2)];
geoplot(x, y, Marker="x", LineStyle="none", MarkerSize=12, Color="white", MarkerFaceColor="white");
hold on;
geoplot([q_pan_l(1,1), q_pan_l(2,1)], [q_pan_l(1,2), q_pan_l(2,2)], 'yellow', 'LineWidth', 2, 'MarkerSize', 5)
geoplot([q_pan_r(1,1), q_pan_r(2,1)], [q_pan_r(1,2), q_pan_r(2,2)], 'yellow', 'LineWidth', 2, 'MarkerSize', 5)

text(pan_l(1), pan_l(2), "ПАН2", 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'Color', "white");
text(pan_r(1), pan_r(2), "ПАН1", 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'Color', "white"); 

% Plot shots
for i = 3:length(shot.Latitude)
    geoplot(shot.Latitude(i), shot.Longitude(i), Marker="x", LineStyle="none", MarkerSize=12, Color="white", MarkerFaceColor="white");
    if i == 7
        text(shot.Latitude(i), shot.Longitude(i), "В"+string(i-2), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center', 'Color', "white");
    else
        text(shot.Latitude(i), shot.Longitude(i), "В"+string(i-2), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'Color', "white");
    end
end
geobasemap satellite
gx.ZoomLevel = 16.1;
hold off;

filename = sprintf("./shots/shot" + string(shot_num) +'.png');
exportgraphics(fig, filename);
