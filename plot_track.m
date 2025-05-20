function plot_track()
    path = './21032025_flies_flies/';
    files = string(ls(strcat(path, 'fly_*.mat')));

    n_pans = 2;
    
    % Длина стрелки (можно менять в зависимости от нужного масштаба)
    distance = 0.0001;

    pan = [55.844992, 37.013744];
    az = deg2rad(10);
    d = [distance * cos(az), distance * sin(az)];
    q_pan= [pan; (pan + d)];

    % pan_l = [55.84590916082602,37.004287365402035];
    % az_l = deg2rad(-52.3586);
    % 
    % pan_r = [55.845904633898954, 37.004311675050275];
    % az_r = deg2rad(-52.3586);

    % pan_l = [56.09771450, 35.875883];
    % az_l = deg2rad(90-45.0112);
    % 
    % pan_r = [56.09855167, 35.874385];
    % az_r = deg2rad(90-34.7577);

    % pan_l = [55.845040, 37.013472];
    % az_l = deg2rad(12);
    % pan_r = [55.845043, 37.013443];
    % az_r = deg2rad(12);

    rep = [];
    % rep = [56.10234300, 35.884162];

    d_l = [distance * cos(az_l), distance * sin(az_l)];
    d_r = [distance * cos(az_r), distance * sin(az_r)];
    % d_l = 10*([55.8459243840293,37.0046265607922] - [55.845925940404896,37.0043310653127]);
    % d_r = 10*([55.8459243840293,37.0046265607922] - [55.845925940404896,37.0043310653127]);
    % Вычисляем смещение по широте и долготе
    end_l = pan_l + d_l;
    end_r = pan_r + d_r;

    q_pan_l = [pan_l; end_l];
    q_pan_r = [pan_r; end_r];

    for i = 1:length(files)
        load(strcat(path, files(i)));
        fig = figure;
        gx = geoaxes;
    
        hold on;
        geoplot(fly.lat, fly.lon, 'Color', 'r', 'LineWidth', 2);

        hold on;
        if n_pans == 1
            geoplot([q_pan(1, 1), q_pan(2, 1)], [q_pan(1, 2), q_pan(2, 2)], 'k', 'LineWidth', 2, 'MarkerSize', 5, Color = "y")
            geoplot(pan(1), pan(2), Marker="x", LineStyle="none", MarkerSize=12, Color="red", MarkerFaceColor="red");
            % % Добавление подписей к маркерам
            hold on;
            text(pan(1), pan(2), "ПАН", 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', "white");
        elseif n_pans == 2
            geoplot([q_pan_l(1, 1), q_pan_l(2, 1)], [q_pan_l(1, 2), q_pan_l(2, 2)], 'k', 'LineWidth', 2, 'MarkerSize', 5, Color = "y")
            geoplot([q_pan_r(1, 1), q_pan_r(2, 1)], [q_pan_r(1, 2), q_pan_r(2, 2)], 'k', 'LineWidth', 2, 'MarkerSize', 5, Color = "y")
            
        
            geoplot(pan_r(1), pan_r(2), Marker="x", LineStyle="none", MarkerSize=12, Color="red", MarkerFaceColor="red");
            geoplot(pan_l(1), pan_l(2), Marker="x", LineStyle="none", MarkerSize=12, Color="red", MarkerFaceColor="red");
            
            % % Добавление подписей к маркерам
            hold on;
            text(pan_l(1), pan_l(2), "ПАН2", 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', 'Color', "white");
            text(pan_r(1), pan_r(2), "ПАН1", 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'Color', "white");
        end

        if ~isempty(rep)
            geoplot(rep(1), rep(2), Marker="x", LineStyle="none", MarkerSize=12, Color="red", MarkerFaceColor="red");
            % % Добавление подписей к маркерам
            hold on;
            text(rep(1), rep(2), "Рэпер", 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', "white");
        end

        
        geobasemap satellite
        gx.ZoomLevel = gx.ZoomLevel - 1;
        hold off;

        % filename = sprintf(strcat(path, erase(erase(files(i), '.mat'), ' '), '.png'));
        % exportgraphics(fig, filename);
    end

end
