folder = "19052025_flies";
common_name = "250519_1713 render 001";
copter_name = "fpv_plane";
savename = folder + "\done" + "\mic4_" + copter_name + "_01";

[sgs,fs] = read_tetraedr(folder, common_name);
start_time = "17:13:19";
date =regexp(common_name, '^(\d{6})', 'match', 'once');
start_datetime = datetime(date + " " + start_time, ...
    'InputFormat', 'ddMMyy HH:mm:ss', ...
    'Format',"HH:mm:ss.SSS");
t = start_datetime + seconds((0:length(sgs)-1)/fs);

idxs_to_cut = 55736928:92962799;
T = form_sg_table(sgs(idxs_to_cut,:),t(idxs_to_cut));

save(savename, "T", "-v7.3");
audiowrite(folder + "" + "\check.wav", T.Signal_1, fs);
    