function plot_flies(filepath, save)
    files = string(ls(filepath + "fly*.mat"));
    for i = 1:length(files)
        fig = figure;
        gx = geoaxes;
        plot_pan_coords(filepath);
        hold on;
        load(filepath + files(i));
        geoplot(fly.lat, fly.lon)
        hold off

        if save == true
            filename = strcat(filepath, erase(erase(files(i), '.mat'), ' '), '.png');
            exportgraphics(fig, filename);
        end
    end
end