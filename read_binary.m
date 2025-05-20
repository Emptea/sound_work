function [data, raw_data] = read_binary(filename, int16_yn)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    f = fopen(filename);

    n_chs = 67;

    if int16_yn == 1
        raw_data = int16(fread(f, 'int16'));
    else
        raw_data = fread(f, 'int16');
    end
    data = raw_data(1:fix(length(raw_data) / n_chs)*n_chs);
    data = reshape(data, n_chs, [])';

    if int16_yn ~= 1
        data = double(data)/double(intmax("int16"));
    end

    fclose(f);
end
