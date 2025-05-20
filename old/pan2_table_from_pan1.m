function T_pan2 = pan2_table_from_pan1(path_pan1)
path_pan2 = strrep(path_pan1, 'PAN1', 'PAN2');
list = string(ls(strcat(path_pan1, "*.mat")));
for i = 42:length(list)
    T_pan1 = load(strcat(path_pan1,list(i)));
    T_pan2 = find_sg(T_pan1.T.Time(1), T_pan1.T.Time(end), "./shots/PAN2/");
    save_name = erase(list(i), ".mat");
    save(strcat(path_pan2, save_name), "T_pan2", "-v7.3");
    audiowrite(strcat(path_pan2, save_name) + ".wav", T_pan2.Signal_39, 16000)
end

