clear
time = '09-00-30';
path = '../sd/';
n_ref = 39;


t_end = datetime(time, 'InputFormat', 'HH-mm-ss');
t_seq = t_end - minutes(0:5);

substrs = string(t_seq, "hh-mm");
sd_files = string(ls(strcat(path,'*.e67')));

f_names = sd_files(contains(sd_files, substrs));

pattern = '\d{4}.\d{2}.\d{2}-\d{2}-\d{2}-\d{2}';
f_times = string(regexp(f_names, pattern, 'match'));

t_files = datetime(f_times, 'InputFormat', 'yyyy.MM.dd-HH-mm-ss');

t_end_str = strcat(string(t_files(1), "yyyy.MM.dd-"), time);
t_end  = datetime(t_end_str, 'InputFormat','yyyy.MM.dd-HH-mm-ss');
f = f_names(t_files <= t_end,:);
if length(f) > 1
    [~,i] = min(t_end - t_files);
    f = f(i);
    t_files = t_files(i);
end
t = t_files(t_files <= t_end) + seconds(0:1/16e3:(60*5-1/16e3));

[sg, ~] = read_raw(strcat(path,f));
figure; plot(t,sg(:,1))
xlim([t(1) t(end)])
title('Сигнал с суммарного канала')
figure; plot(t, sg(:,n_ref+1))
xlim([t(1) t(end)])
title('Сигнал с опорного микрофона')
