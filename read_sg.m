function [sg, t] = read_sg(filepath, filename, opt)
arguments
    filepath string;
    filename string;
    opt = 1;
end

if opt == 1
    [sg, ~] = read_raw(filepath, 1);
    pattern = '\d{4}.\d{2}.\d{2}-\d{2}-\d{2}-\d{2}';
    frmt = 'yyyy.MM.dd-HH-mm-ss';
elseif opt == 0
    [sg, ~] = read_binary(filepath, 1);
    pattern = '\d{4}-\d{2}-\d{2} \d{2}-\d{2}-\d{2}';
    frmt = 'yyyy-MM-dd HH-mm-ss';
end

f_time = string(regexp(filename, pattern, 'match'));
t_file = datetime(f_time, 'InputFormat', frmt);

t = t_file + seconds((0:(length(sg) - 1))/16e3);
t.Format = 'HH-mm-ss.SSS';
end