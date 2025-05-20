function d_phi = find_delay(x,y,f)
f_adc = 16e3;
n_period = f_adc/f;

if n_period > 6
    w = 2;
elseif n_period > 4
    w = 1;
else
    w = 0;
end

[c, lags] = xcorr(x,y, 'unbiased');
stem(lags,c)
[~, i_mx] = max(c);
idx = (i_mx-w):(i_mx+w);
vals = c(idx);
corr_lag = lags(i_mx);
i = (corr_lag-w):(corr_lag+w);
val_i = i*vals/sum(vals);
d_phi = 2*pi*val_i/n_period;