function [sg, t] = sync_read(folder, filename, t_bias, not_first)
    [sg, ~] = read_raw(folder + filename, 1);
    pattern = '\d{4}.\d{2}.\d{2}-\d{2}-\d{2}-\d{2}';
    frmt = 'yyyy.MM.dd-HH-mm-ss';
    f_time = string(regexp(filename, pattern, 'match'));
    t_start = datetime(f_time, 'InputFormat', frmt);

    sg_sync = sg(:,32);
    [~, idx_peak] = max(abs(sg_sync(1:4)));
    sg_sync = unwrap_int16(sg_sync,idx_peak);

    t = seconds((sg_sync-sg_sync(idx_peak))'/16e3/4 + (0:3)'/16e3);
    t = reshape(t, [length(sg) 1]) + t_start+t_bias;
    % if (not_first)
    %     t = t+(t_end_prev-t_start + seconds(1/16e3));
    % end

end