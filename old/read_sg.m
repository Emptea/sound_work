function [sg, t] = read_sg(filepath, filename)

[sg, ~] = read_raw(filepath, 1);

pattern = '\d{4}.\d{2}.\d{2}-\d{2}-\d{2}-\d{2}';
f_time = string(regexp(filename, pattern, 'match'));
t_file = datetime(f_time, 'InputFormat', 'yyyy.MM.dd-HH-mm-ss');

t = t_file + seconds((0:(length(sg) - 1))/16e3);
t.Format = 'HH-mm-ss.SSS';
end