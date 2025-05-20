function plot_track()
path = './08102024_flies/2_diag/';
files = string(ls(strcat(path,'fly_*.mat')));

% rep = [56.102343 35.884162];
% fly_start = [56.0977249689059 35.8759022040024];
% pan_l = [56.09855167 35.874385];
% pan_r = [56.09771450 35.875883];
% 
% pan = [55.1795132, 82.8114200];

pan_l = [54.743611, 83.3175];
az_l = deg2rad(251);
pan_r = [54.744444, 83.316944];
az_r = deg2rad(240);

% Длина стрелки (можно менять в зависимости от нужного масштаба)
distance = 0.001; 

d_l = [distance * cos(az_l), distance * sin(az_l)];
d_r = [distance * cos(az_r), distance * sin(az_r)];
% Вычисляем смещение по широте и долготе
end_l = pan_l + d_l;
end_r = pan_r + d_r;

q_pan_l = [pan_l; end_l];
q_pan_r = [pan_r; end_r];

for i = 1:length(files)
    load(strcat(path,files(i)));
    fig = figure;
    gx = geoaxes;
    % x = [rep(1), pan_l(1), pan_r(1)];
    % y = [rep(2), pan_l(2), pan_r(2)];

    x = [pan_l(1), pan_r(1)];
    dx = [d_l(1), d_r(1)];
    y = [pan_l(2), pan_r(2)];
    geoplot(x, y, Marker="x", LineStyle="none", MarkerSize=12, Color="red", MarkerFaceColor="red");
    hold on;
    geoplot([q_pan_l(1,1), q_pan_l(2,1)], [q_pan_l(1,2), q_pan_l(2,2)], 'k', 'LineWidth', 2, 'MarkerSize', 5)
    geoplot([q_pan_r(1,1), q_pan_r(2,1)], [q_pan_r(1,2), q_pan_r(2,2)], 'k', 'LineWidth', 2, 'MarkerSize', 5)
    % geoplot(pan(1), pan(2), Marker="x", LineStyle="none", MarkerSize=6, Color="red", MarkerFaceColor="red");
    % Добавление подписей к маркерам
    hold on;
    % % text(rep(1), rep(2), "Репер", 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'Color', "white");
    text(pan_l(1), pan_l(2), "ПАН2", 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'Color', "white");
    text(pan_r(1), pan_r(2), "ПАН1", 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', "white");    
    %text(pan(1), pan(2), "ПАН", 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', "white");    
    hold off;


    hold on;
    geoplot(fly.lat, fly.lon,'Color', 'r', 'LineWidth', 2);
    geobasemap satellite
    gx.ZoomLevel = 14.9;
    hold off;

    filename = sprintf(strcat(path,erase(erase(files(i), '.mat'), ' '), '.png'));
    exportgraphics(fig, filename);
end
end