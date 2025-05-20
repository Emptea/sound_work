function d_phi = find_delay_mtx(x,f)
f_adc = 16e3;
n_period = f_adc/f;
n_mics = 66;

if n_period > 6
    w = 2;
elseif n_period > 4
    w = 1;
else
    w = 0;
end

c = zeros((2*size(x,1) - 1),n_mics);
[c(:,1), lags] = xcorr(x(:,1), x(:,1));
for i = 2:n_mics
    [c(:,i), ~] = xcorr(x(:,1), x(:,i));
end
%stem(lags,c)
[~, i_mx] = max(c, [], 1);
idx = i_mx + (-w:w)';
idx(idx > length(lags)) = length(lags);
idx(idx<1) = 1; 

lin_idx = idx + (0:size(c,2)-1) * size(c,1)';
vals = c(lin_idx);
corr_lag = lags(i_mx);
i = corr_lag + (-w:w)';
if w > 10
    val_i = sum(i.*vals)./sum(vals);
else
    val_i = corr_lag;
end
d_phi = 2*pi.*val_i/n_period;