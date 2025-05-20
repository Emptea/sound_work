% clear;
n_refch = 11;
path = "F:\work\sound_work\23042025 orevo\Records\ПАН левый длинные\";

files = string(ls(path + "\*.e32"));
refch = [];
t = [];

for i = 1:length(files)
    [data, time] = read_sg(path + files(i), files(i), 1);
    % data = read_raw(path  + "\" + files(i), 1);
    refch = [refch; data];
    % refch2_sync = [refch2_sync; data(:,32)];
    % refch = [refch; data];
    t = [t time];
end

path = "F:\work\sound_work\23042025 orevo\Records\ПАН правый короткие\";

files = string(ls(path + "\*.e32"));
refch2 = [];
t2 = [];

for i = 3:length(files)
    [data, time] = read_sg(path + files(i), files(i), 1);
    % data = read_raw(path  + "\" + files(i), 1);
    refch2 = [refch2; data];
    % refch2_sync = [refch2_sync; data(:,32)];
    % refch = [refch; data];
    t2 = [t2 time];
end
offset = ((t2(1)-duration("00:02:44.544"))-t(1))
t = t + offset;
t = t - (duration(t([2648577])-t2(15800)));

% audiowrite(path+ "refch2.wav", refch2,16e3)
% audiowrite('F:\work\sound_work\21032025_flies\refch1.wav', refch,16e3)

% clear;
% path1 = "E:\Сбер\Выезд 08112024\master\первая часть\";
% path2 = "E:\Сбер\Выезд 08112024\slave\первое испытание\";
% 
% files1 = string(ls(path1 + "\*.e*"));
% files2 = string(ls(path2 + "\*.e*"));
% 
% for i = 1:length(files1)
%     stime1 = get_start_time_from_filename(files1(i));
%     stime2 = get_start_time_from_filename(files2(i));
%     disp(stime2 - stime1)
% end