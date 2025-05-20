function plot_dk02_coords(dk02_num)

opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ";";

% Specify column names and types
opts.VariableNames = ["Latitude", "Longitude", "Label", "AzimuthGrad"];
opts.VariableTypes = ["double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Label", "TrimNonNumeric", true);
opts = setvaropts(opts, "Label", "ThousandsSeparator", ",");

% Import the data
fly = readtable("./26112024_flies/fly" + dk02_num + ".csv", opts);
clear opts
%%
pan_l = [fly.Latitude(1), fly.Longitude(1)];
az_l = deg2rad(90-fly.AzimuthGrad(1));
pan_r = [fly.Latitude(2), fly.Longitude(2)];
az_r = deg2rad(90-fly.AzimuthGrad(2));

% Длина стрелки (можно менять в зависимости от нужного масштаба)
distance = 0.005; 

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

text(pan_l(1), pan_l(2), "ПАН2", 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', "white");
text(pan_r(1), pan_r(2), "ПАН1", 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'Color', "white"); 

% Plot shots
for i = 3:length(fly.Latitude)
    geoplot(fly.Latitude(i), fly.Longitude(i), Marker="x", LineStyle="none", MarkerSize=12, Color="red", MarkerFaceColor="white");
    text(fly.Latitude(i), fly.Longitude(i), "Д"+string(i-2), ...
             'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'Color', "white");
    % if i == 4
    %     text(fly.Latitude(i), fly.Longitude(i), "П"+string(i-2), ...
    %         'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'Color', "white", "FontSize",8);
    % elseif i == 8 || 10
    %     text(fly.Latitude(i), fly.Longitude(i), "П"+string(i-2), ...
    %         'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', "white", "FontSize",8);
    % elseif i == 9
    %     text(fly.Latitude(i), fly.Longitude(i), "П"+string(i-2), ...
    %         'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', "white", "FontSize",8);
    % else
    %     text(fly.Latitude(i), fly.Longitude(i), "П"+string(i-2),...
    %         'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'Color', "white", "FontSize",8);
    % end
end
geobasemap satellite
gx.ZoomLevel = gx.ZoomLevel-.2;
hold off;

filename = sprintf("./26112024_flies/fly" + string(dk02_num) +'.png');
exportgraphics(fig, filename);
