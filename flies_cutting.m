root = pwd + "\08112024_flies\";
ext = "*.e32";
fly_list = get_path(root, "fly*.mat");

pth_master = root + "master\";
pth_slave = root + "slave\";

% import_flytime;

for i = 10:10 %length(fly_list)
    load(fly_list(i))
    
    bias = seconds(24.1470);
    utc_plus = hours(3) + bias;
    t_start = string(fly.time(1));
    t_end = string(fly.time(end));

    T_master = find_sg(t_start, t_end, pth_master, ext, utc_plus);
    
    % save_name = erase(fly_list(i), root + "fly_");
    % save_name = erase(save_name, '.mat');
    % save_name = erase(save_name, ' ');
    save_name = sprintf("phantom_%02d", i);
    
    % if (T.Time(end) < fly.time(end))
    %     fly = fly(1:find(fly.time >= T.Time(end), 1), :);
    %     save(strcat(root, match_table.fly(i)), "fly", "-v7.3");
    % end
    %
    % if any(fly.lat == 0)
    %     fly = fly(find(fly.lat ~= 0), :);
    %     save(strcat(root, match_table.fly(i)), "fly", "-v7.3");
    %     T = T(find(T.Time >= fly.time(1)), :);
    % end
  
    t_bias = seconds(42.4808);
    
    T_slave = find_sg(t_start, t_end, pth_slave, ext, utc_plus-t_bias);
    
    if (length(T_slave.Time) > length(T_master.Time))
        if (T_master.Time(end) < T_slave.Time(end))
            T_slave = T_slave(1:end-1,:);
        elseif (T_master.Time(1) > T_slave.Time(1))
            T_slave = T_slave(2:end,:);
        end
    elseif (length(T_slave.Time) < length(T_master.Time))
        if (T_master.Time(end) > T_slave.Time(end))
            T_master = T_master(1:end-1,:);
        elseif (T_master.Time(1) < T_slave.Time(1))
            T_master = T_master(2:end,:);
        end
    end

    save(strcat(pth_master, "pan1_", save_name), "T_master", "-v7.3");
    audiowrite(strcat( pth_master, "pan1_", save_name, '_14.wav'), T_master.Signal_14, 16e3);

    save(strcat(pth_slave, "pan2_", save_name), "T_slave", "-v7.3");
    audiowrite(strcat(pth_slave, "pan2_", save_name, '_14.wav'), T_slave.Signal_14, 16e3);
    
    % idxs = 20*16e3-1000:20*16e3+1000-1;
    % [r, lags] = xcorr(T_master.Signal_14(idxs), T_slave.Signal_14(idxs));
    % figure; plot(lags,r); xlim([lags(1) lags(end)])

    % figure; plot(T_master.Signal_synch(end-20000:end)); hold on; plot( T_slave.Signal_synch(end-20000:end));
    % sg14 = T_master.Signal_14;
    % signalAnalyzer(sg14);
end
