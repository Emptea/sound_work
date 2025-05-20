function [data, raw_data] = read_raw(filename, int16_yn)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    f = fopen(filename);
    [~, ~, ext] = fileparts(filename);
    n_chs = str2double(extractAfter(ext, 2));

    if int16_yn == 1
        raw_data = int16(fread(f, 'int16'));
    else
        raw_data = fread(f, 'int16');
    end

    n = floor(length(raw_data) / n_chs) * n_chs;
    data = raw_data(1:n);
    data = reshape(data, n_chs, [])';

    if int16_yn ~= 1
        data = data / 32768;
    end

    fclose(f);
end
