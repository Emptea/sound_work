function phase_resp = find_phase_resp_with_corr_lag(x,f)
fs = 16e3;
n_mics = size(x,2);
phase_diff = zeros(n_mics, length(f));

[x_fft, f_fft] = fft_calc(x, fs);
[~, idx] = max(abs(x_fft), [], "linear");
phases = angle(x_fft(idx));
phases = permute(phases, [2 3 1]);

% for i = 2:n_mics
%     for j = 1:length(f)
%        [corr, lags] = xcorr(x(:,1,j), x(:,i,j));
%        [~,idx] = max(abs(corr));
%        lag_diff = lags(idx);
%        phase_diff(i,j) = 2*pi*f(j)*lag_diff/fs;
%     end
% end
phase_resp = reshape(phases(1,:)-phases, n_mics, length(f));
phase_resp = unwrap(phase_resp(:,:)');
phase_resp(:, find(phase_resp(1,:)> pi)) = phase_resp(:, find(phase_resp(1,:)> pi)) - 2*pi;