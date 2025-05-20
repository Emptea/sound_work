% clear;
n_refch = 14;
path = "F:\work\sound_work\depart_08112024\master\third_part\";

files = string(ls(path + "\*.e*"));
refch = [];
for i = 1:length(files)
    data = read_raw(path  + "\" + files(i), 1);
    refch = [refch; data];
end


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