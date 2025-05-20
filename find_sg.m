function T = find_sg(time_start, time_end, path, ext, utc_plus)
arguments
    time_start string
    time_end string
    path string
    ext string
    utc_plus duration
end
    t_start = datetime(time_start, 'InputFormat', 'HH:mm:ss.SSS');
    t_seq = t_start - minutes(-5:5) + utc_plus;
    
    substrs = string(t_seq, "HH-mm");
    %sd_files = string(ls(strcat(path,'*.e67')));
    sd_files = get_path(path, ext);

    f_names = sd_files(contains(sd_files, substrs));
    
    pattern = '\d{4}.\d{2}.\d{2}-\d{2}-\d{2}-\d{2}';
    f_times = string(regexp(f_names, pattern, 'match'));
    
    t_files = datetime(f_times, 'InputFormat', 'yyyy.MM.dd-HH-mm-ss');
    
    t_start_str = strcat(string(t_files(1), "yyyy.MM.dd-"), time_start);
    t_start  = datetime(t_start_str, 'InputFormat','yyyy.MM.dd-HH:mm:ss.SSS');
    t_end_str = strcat(string(t_files(1), "yyyy.MM.dd-"), time_end);
    t_end  = datetime(t_end_str, 'InputFormat','yyyy.MM.dd-HH:mm:ss.SSS');

    utc_t_start = t_start + utc_plus;
    f_idx = max(find(t_files <= utc_t_start));
    if isempty(f_idx)
        [~,f_idx] = min(t_files);
    end
    f = f_names(f_idx);
    if length(f) > 1
        [~,idx] = min(t_start - t_files(t_files <= utc_t_start));
        f = f(idx);
        t_files = t_files(idx);
    end
    
    [sg, ~] = read_raw(f, 1);
    
    t = t_files(f_idx) + seconds(0:1/16e3:(length(sg)-1)/16e3);
    while (t(end) < (t_end+ utc_plus))
        substr = string(t(end)+seconds(1), "HH-mm");
        f = sd_files(contains(sd_files, substr));
        if isempty(f)
            break;
        end
        sg2 = read_raw(f(1),1);
        sg = [sg; sg2];
        t2 = t(end) + seconds(1/16e3:1/16e3:(length(sg2))/16e3);
        clear sg2
        t = [t t2];
        clear t2
    end
    t = t - utc_plus;
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
    T = form_sg_table(sg, t);
end