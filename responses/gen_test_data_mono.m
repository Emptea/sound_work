function [data, t] = gen_test_data_mono(t_max, freq)

fs = 16000;
t = (0:1/fs:t_max)';
sigs = sin(2*pi*freq*t');
sig_res = sigs;
test_data = repmat(sig_res', 1, 67);
data = test_data + (10*rand(size(test_data))-5);

end