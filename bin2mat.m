fldr_mavic = pwd + "\Выезд сберунивер 29102024\";
fldr_fly = pwd + "\29102024_flies\";

mavic_files = get_path(fldr_mavic, "*авик*.bin");
[t_fly, fly_files] = view_fly_time(fldr_fly);
save_names = erase(mavic_files, fldr_mavic);
save_names = erase(save_names, '.bin');
bias = duration('00:01:43');

for i = 9:length(mavic_files)
    filename = erase(mavic_files(i), fldr_mavic);
    [sg, t] = read_sg(mavic_files(i), filename, 0);
    t = t - hours(3) + bias;
    T = form_sg_table(sg, t);
    
    isInsideMatrix = T.Time >= t_fly.start' & T.Time <= t_fly.stop';
    [~, isInside] = max(sum(isInsideMatrix,1));
    try
        load(fly_files(isInside));
        % bias = fly.time(1) - T.Time(1);   

        idx_start = find(fly.time > T.Time(1), 1);
        idx_end = (find(fly.time > T.Time(end),1) - 1);
        if isempty(idx_end)
            idx_end = length(fly.time);
        end
        idxs = idx_start:idx_end;
        fly = fly(idxs,:);     
        
        save(fldr_mavic + "rdy\" + "pan_" + save_names(i), "T", "-v7.3");
        audiowrite(fldr_mavic + "rdy\" + "pan_" + save_names(i) + ".wav", T.Signal_14, 16e3);
        save(fldr_mavic + "rdy\" + "fly_" +save_names(i), "fly", "-v7.3");
    end
end