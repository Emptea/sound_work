function [data, t] = gen_test_data_multi(t_max)

freq = (100:100:8e3)';
fs = 16000;
t = (0:1/fs:t_max)';
sigs = sin(2*pi*freq*t');
sig_sum = sum(sigs);
test_data = repmat(sig_sum', 1, 67);
data = test_data + (10*rand(size(test_data))-5);

end