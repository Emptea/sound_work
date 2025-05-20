function T = find_sg(time_start, time_end, path)
arguments
    time_start string
    time_end string
    path string
end
    t_start = datetime(time_start, 'InputFormat', 'HH:mm:ss.SSS');
    t_seq = t_start - minutes(-5:5);
    
    substrs = string(t_seq, "hh-mm");
    %sd_files = string(ls(strcat(path,'*.e67')));
    sd_files = string(get_path("*.e32"));
    
    f_names = sd_files(contains(sd_files, substrs));
    
    pattern = '\d{4}.\d{2}.\d{2}-\d{2}-\d{2}-\d{2}';
    f_times = string(regexp(f_names, pattern, 'match'));
    
    t_files = datetime(f_times, 'InputFormat', 'yyyy.MM.dd-HH-mm-ss');
    
    t_start_str = strcat(string(t_files(1), "yyyy.MM.dd-"), time_start);
    t_start  = datetime(t_start_str, 'InputFormat','yyyy.MM.dd-HH:mm:ss.SSS');
    t_end_str = strcat(string(t_files(1), "yyyy.MM.dd-"), time_end);
    t_end  = datetime(t_end_str, 'InputFormat','yyyy.MM.dd-HH:mm:ss.SSS');
    f = f_names(t_files <= t_start,:);
    if length(f) > 1
        [~,idx] = min(t_start - t_files(t_files <= t_start));
        f = f(idx);
        t_files = t_files(idx);
    end
    
    [sg, ~] = read_raw(strcat(path,f), 1);
    
    t = t_files(t_files <= t_start) + seconds(0:1/16e3:(length(sg)-1)/16e3);
    while (t(end) < t_end)
        substr = string(t(end), "hh-mm");
        f = sd_files(contains(sd_files, substr));
        if isempty(f)
            break;
        end
        sg2 = read_raw(strcat(path,f(1)),1);
        sg = [sg; sg2];
        clear sg2
        t2 = t(end) + seconds(1/16e3:1/16e3:60*5);
        t = [t t2];
        clear t2
    end
    idx_start = find(t>t_start,1)-1;
    idx_end =  find(t>t_end,1)+1;
    if (isempty(idx_end) | idx_end > length(sg))
        idx_end = length(sg);
    end
    
    t = t(idx_start:idx_end);
    t.Format = 'HH:mm:ss.SSS';
    sg = sg(idx_start:idx_end,:);
    
    % figure; plot(t,sg(:,1))
    % xlim([t(1) t(end)])
    % title('Сигнал с суммарного канала')
    % figure; plot(t, sg(:,n_ref+1))
    % xlim([t(1) t(end)])
    % title('Сигнал с опорного микрофона')
    % 
    sg = num2cell(sg,1);
    varNames = arrayfun(@(x) sprintf('Signal_%d', x), 1:66, 'UniformOutput', false);
    T = table(t', sg{:}, 'VariableNames', ['Time', 'Signal_sum' varNames]);
end