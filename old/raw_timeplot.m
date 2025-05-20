clear
[t_table, fly_names] = view_fly_time;
%load('fly_fpv.mat')

path = './pan_r/';
n_ref = 39;
% times = strings(1,2);
% times(1,1) = fly.time(1);
% times(1,2) = fly.time(end);
idxs = 7:11;
times = strings(length(idxs),2);
% uncomment for cutting everything outside flies
% times(1,1) = '08:28:58.000';
% times(2:length(idxs),1) = t_table(idxs(1:end-1),2);
% times(:, 2) =  t_table(idxs,1);
% times = strrep(times, ':', '-');
% match = '.' + wildcardPattern(3);
% times = erase(times,match);

%uncomment for cutting flies + 1min before & 1min after
times(:,1) = t_table(idxs,1) - seconds(60);
times(:,2) = t_table(idxs,2) + seconds(60);
times = strrep(times, ':', '-');
match = '.' + wildcardPattern(3);
times = erase(times,match);
for i = 1:1%1:length(idxs)
    time_start = times(i,1);
    time_end = times(i,2);
    
    t_start = datetime(time_start, 'InputFormat', 'HH-mm-ss');
    t_seq = t_start - minutes(0:5);
    
    substrs = string(t_seq, "hh-mm");
    sd_files = string(ls(strcat(path,'*.e67')));
    
    f_names = sd_files(contains(sd_files, substrs));
    
    pattern = '\d{4}.\d{2}.\d{2}-\d{2}-\d{2}-\d{2}';
    f_times = string(regexp(f_names, pattern, 'match'));
    
    t_files = datetime(f_times, 'InputFormat', 'yyyy.MM.dd-HH-mm-ss');
    
    t_start_str = strcat(string(t_files(1), "yyyy.MM.dd-"), time_start);
    t_start  = datetime(t_start_str, 'InputFormat','yyyy.MM.dd-HH-mm-ss');
    t_end_str = strcat(string(t_files(1), "yyyy.MM.dd-"), time_end);
    t_end  = datetime(t_end_str, 'InputFormat','yyyy.MM.dd-HH-mm-ss');
    f = f_names(t_files <= t_start,:);
    if length(f) > 1
        [~,idx] = min(t_start - t_files);
        f = f(idx);
        t_files = t_files(idx);
    end
    t = t_files(t_files <= t_start) + seconds(0:1/16e3:(60*5-1/16e3));
    
    [sg, ~] = read_raw(strcat(path,f), 1);
    
    while (t(end) < t_end)
        substr = string(t(end), "hh-mm");
        f = sd_files(contains(sd_files, substr));
        sg2 = read_raw(strcat(path,f(1)),1);
        sg = [sg; sg2];
        clear sg2
        t2 = t(end) + seconds(1/16e3:1/16e3:60*5);
        t = [t t2];
        clear t2
    end
    idx_start = find(t>t_start,1)-1;
    idx_end =  find(t>t_end,1)+1;
    
    t = t(idx_start:idx_end);
    t.Format = 'HH:mm:ss.SSSSSSS';
    sg = sg(idx_start:idx_end,:);
    
    figure; plot(t,sg(:,1))
    xlim([t(1) t(end)])
    title('Сигнал с суммарного канала')
    figure; plot(t, sg(:,n_ref+1))
    xlim([t(1) t(end)])
    title('Сигнал с опорного микрофона')
    
    sg = num2cell(sg,1);
    varNames = arrayfun(@(x) sprintf('Signal_%d', x), 1:66, 'UniformOutput', false);
    T = table(t', sg{:}, 'VariableNames', ['Time', 'Signal_sum' varNames]);
    save(strcat(path, fly_names(idxs(i)),'_3min','_sg_r'), "T", "-v7.3");
    audiowrite(strcat(path, fly_names(idxs(i)),'_3min','_sg_r_ch39.wav'),T.Signal_39,16e3);
    audiowrite(strcat(path, fly_names(idxs(i)),'_3min','_sg_r_sum.wav'),T.Signal_sum,16e3);
    %clear T sg t
end

