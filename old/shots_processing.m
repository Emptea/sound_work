path = "shots/PAN2/";
list = string(ls(strcat(path, "*.e67")));

pos = 5;
shot_num = 2;
i = 23;
[sg, t] = read_sg(strcat(path,list(i)), list(i));
sg_39 = sg(:,40);
audiowrite(path + "/pos" + string(pos) + "/" + "shot" + string(i) + ".wav", sg_39, 16000)

signalAnalyzer(sg_39)

%%
timeLimits = [3905085 4288619];
save_name = "pos2_shot4_all"; 

idxs = timeLimits(1):timeLimits(2);
T = form_sg_table(sg(idxs,:), t(idxs));
save(strcat(path,  "/pos",string(pos), "/", save_name), "T", "-v7.3");
audiowrite(path + "/pos" + string(pos) + "/" + save_name + ".wav", T.Signal_39, 16000)
%%
[sg_next, t_next] = read_sg(strcat(path,list(i+1)), list(i+1));
sg = [sg; sg_next];
t = [t t_next];

sg_39 = sg(:,40);
audiowrite(path + "shot" + string(i) + ".wav", sg_39, 16000)

clear sg_next t_next

signalAnalyzer(sg_39)
%%
temp_sg = sg; %(1.6e6:2.4e6,:);
temp_t = t; %(1.6e6:2.4e6);
%%
shots_amnt = 5;
for j = 1:shots_amnt
    save_name = "pos1_shot1_" + string(j); 
    start_idx =  find(temp_sg(:,40) > 1.1e4,1);
    idxs = (start_idx - 3e3):start_idx+7e4;

    T = form_sg_table(temp_sg(idxs,:), temp_t(idxs));

    save(strcat(path,  "/pos",string(pos), "/", save_name), "T", "-v7.3");
    audiowrite(path + "/pos" + string(pos) + "/" + save_name + ".wav", T.Signal_39, 16000)
    temp_sg = temp_sg(idxs(end):end,:);
    temp_t = temp_t(idxs(end):end);
end
%% 
path_pan1 = "shots/PAN1/";

% sg_39 = sg_39(3.5e5:end,:);
% t = t(3.5e5:end);

start_idx =  find(sg_39 > 2000,1) - 6e3;
time_start = t(start_idx);
load(path_pan1 +'pos'+ string(pos) +'/pos'+ string(pos) + '_shot'+ string(shot_num) + '_all');
time_end = T.Time(end);

time_start.Format='HH:mm:ss.SSS';
time_end.Format='HH:mm:ss.SSS';
T_pan2 = find_sg(time_start, time_end, path);
T_pan1 = find_sg(time_start, time_end, path_pan1);

signalAnalyzer(T_pan1.Signal_39)
signalAnalyzer(T_pan2.Signal_39)
%% 
save_name = "pos" + string(pos) +"_shot" + string(shot_num)+"_all"; 
save(strcat(path,  "/pos",string(pos), "/", save_name), "T_pan2", "-v7.3");
audiowrite(path + "/pos" + string(pos) + "/" + save_name + ".wav", T_pan2.Signal_39, 16000)

save(strcat(path_pan1,  "/pos",string(pos), "/", save_name), "T_pan1", "-v7.3");
audiowrite(path_pan1 + "/pos" + string(pos) + "/" + save_name + ".wav", T_pan1.Signal_39, 16000)