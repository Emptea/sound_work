signal2double = @(signal) double(signal)/double(intmax("int16")); 

fid = fopen('D:\Sber\Отчеты\Выезд сберунивер 29102024\2024-10-29 15-05-07 фантом запись 1.bin', 'rb','l');
signal = fread(fid, 'int16');

channels_count = 67;

signal = signal(1:fix(length(signal) / channels_count)*channels_count);
raw = reshape(signal, channels_count, []);
raw = raw';

fclose(fid);

datachannels = signal2double(raw);
