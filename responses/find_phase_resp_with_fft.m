function phase_resp = find_phase_resp_with_fft(x,f)
% Нахождение ФЧХ в точке максимума БПФ
fs = 16e3;
n_mics = size(x,2);

[x_fft, ~] = fft_calc(x, fs);
[~, idx] = max(abs(x_fft), [], "linear");
phases = angle(x_fft(idx));
phases = permute(phases, [2 3 1]);

phase_resp = reshape(phases(1,:)-phases, n_mics, length(f));
phase_resp = unwrap(phase_resp(:,:)');
phase_resp(:, find(phase_resp(1,:)> pi)) = phase_resp(:, find(phase_resp(1,:)> pi)) - 2*pi;