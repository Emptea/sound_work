t_bias1 = seconds(679692/16e3);
t_bias2 = seconds(683760/16e3);
t_bias3 = seconds(677600/16e3);

root = pwd + "\depart_08112024\";
pth_slave = root + "slave\";
master_list = get_path(root, "*_master.mat");
ext = "*.e32";

t_gtc_bias = [24.338-0.191;... 
              24.338-0.819; ...
              24.338-0.119-1];

for i = 1:length(master_list)
    load(master_list(i))

    if i < 12 
        bias = t_bias1;
    elseif i < 22 
        bias = t_bias2;
    else 
        bias = t_bias3;
    end
    
    t_start = T.Time(1);
    t_end = T.Time(end);
    T_slave = find_sg(t_start, t_end, pth_slave, ext, utc_plus-bias);
    
    save_name = erase(master_list(i), root + "master\");
    save_name = erase(save_name, 'master.mat');
    save_name = erase(save_name, ' ');

    save(strcat(pth_slave, save_name, "_slave"), "T_slave", "-v7.3");
    audiowrite(strcat(pth_slave, save_name, "_slave", '_14_biased.wav'), T_slave.Signal_14, 16e3);

    T_master = T;
    save(strcat(root, save_name, "_master"), "T_master", "-v7.3");
end