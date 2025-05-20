% filepath = "F:\work\sound_work\11042025 istok\";
% filename = "matrice";
% load(filepath+"pan1_"+filename+".mat")
% T1 = T;
% load(filepath+"pan2_"+filename+".mat")
% T2 = T;
% clear T
% 
% sync1_straight = unwrap_int16(T1.Signal_synch,4);
% sync2_straight = unwrap_int16(T2.Signal_synch,1);
% to_cal = find(diff(sync2_straight) ~= 16);

test = [];
t_test = [];
t_start = seconds(0);
path = ".\11042025\raw\Records\ПАН правый короткие\";
files = string(ls(path + "*.e32"));

for i = 1:length(files)
    [data, time] = sync_read(path, files(i),seconds(0.2),i-1);
    test = [test; data];
    t_test = [t_test; time];
end