function [d_amp_db, d_phase, amps_max_db, phase_max, s, f] = work_data(...
    data, fs, idx_sig_mic, idx_ref_mic)

n = length(data);
n = n - mod(n,2);
data = data(1:n, idx_sig_mic);

[s, f] = fft_calc(data, fs);

amp = abs(s);
amp_ref = amp(:, idx_ref_mic);
idx_max = islocalmax(amp_ref./max(amp_ref), 'MinProminence',0.5);
% [~, idx_max] = max(amp_ref./max(amp_ref));
amps_max = amp(idx_max, :);
phase_max = angle(s(idx_max, :));

amps_max_db = 20*log10(amps_max);
d_phase = phase_max - phase_max(:,idx_ref_mic);
d_amp_db = amps_max_db - amps_max_db(:,idx_ref_mic);

end
