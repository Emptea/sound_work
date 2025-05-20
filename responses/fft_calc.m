function [s, f] = fft_calc(data, fs)

n = length(data);
n = n - mod(n,2);

s = fft(data)/n;
s = s(1:n/2, :,:);
s(2:end-1, :,:) = 2*s(2:end-1, :,:);
f = (0:1:n-1)/n*fs;
f = f(1:n/2);

end