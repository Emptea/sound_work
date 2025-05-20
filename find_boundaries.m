function [t_start, t_end] = find_boundaries(folder)
f_names = get_path(folder, "*.e*");
pattern = '\d{4}.\d{2}.\d{2}-\d{2}-\d{2}-\d{2}';

f_times = string(regexp(f_names, pattern, 'match'));
t_files = datetime(f_times, 'InputFormat', 'yyyy.MM.dd-HH-mm-ss');

t_start = t_files(1);
t_start.Format = 'HH:mm:ss.SSS';
[sg, ~] = read_raw(f_names(end), 1);
t_end = t_files(end) + seconds((length(sg)-1)/16e3);
t_end.Format = 'HH:mm:ss.SSS';
end
