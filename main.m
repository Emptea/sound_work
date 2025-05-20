filepath = "./рассинхронизация/";
T = readtable(filepath+"bias.csv",ReadVariableNames=false);
bias = seconds(T.Var3+11.5/16e3);

slave_path = filepath + "короткие болты/";
master_path = filepath + "длинные болты/";
ext='*.e32';
utc_plus = duration("00:00:00");

t_start = "16:59:43.000";
t_end = "17:39:44.000";

T_master = find_sg(t_start, t_end, master_path, ext, utc_plus);
T_slave = find_sg(t_start, t_end, slave_path, ext, utc_plus+bias);