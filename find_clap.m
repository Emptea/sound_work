root = pwd + "\depart_08112024\";
ext = "*.e32";
fly_list = get_path(root, "*.mat");

pth_master = root + "master\";
pth_slave = root + "slave\";

utc_plus = hours(3) + seconds(24.338-0.119-1);
% t_start = "09:52:35.000";
% t_end = "09:57:35.000";
t_start = "11:58:57.100";
t_end = "12:06:43.300";
num = 679692+12000+1611+73;
t_bias1 = seconds(679692/16e3);
t_bias2 = seconds(683760/16e3);
t_bias3 = seconds(677600/16e3);
T_master = find_sg(t_start, t_end, pth_master, ext, utc_plus);
T_slave = find_sg(t_start, t_end, pth_slave, ext, utc_plus-t_bias3);

sg14_master = T_master.Signal_14;
sg14_slave = T_slave.Signal_14;

signalAnalyzer(sg14_master, sg14_slave)

figure; plot(T_master.Signal_synch);
hold on; plot(T_slave.Signal_synch);