function freq_resp = find_freq_resp(out)
% Нахождение АЧХ через максимум БПФ
fs = 16e3;
[x_fft, ~] = fft_calc(out, fs);
[~, idx] = max(abs(x_fft), [], "linear");
freq_resp = x_fft(idx); % 1 x n_freqs x n_mics
freq_resp = permute(freq_resp, [2 3 1]); % n_freqs x n_mics