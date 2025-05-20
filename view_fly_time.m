function [t, file_names] = view_fly_time(folder)
    files = get_path(folder, "fly*.mat");
    for i = 1:length(files)
        file = files(i);
        load(file);
        t(i,1) = fly.time(1);
        t(i,2) = fly.time(end);
        fprintf("%s; start: %s; end: %s\n", file, fly.time(1), fly.time(end));
    end
    t = table(t(:,1), t(:,2), 'VariableNames', {'start', 'stop'});
    file_names = erase(files, '.mat');
    file_names = erase(file_names, ' ');
end