function phase_resp = find_phases_for_pulses(sigs, n_ref, freqs)
% Нахождение ФЧХ для вектора импульсов [n_samples x n_freqs x n_mics]
x = cat(3, sigs(:, :, n_ref), sigs(:,:, 1:n_ref-1), sigs(:,:,n_ref+1:end));
x = permute(x, [1 3 2]);
phase_resp = find_phase_resp_with_fft(x,freqs);
phase_resp = [phase_resp(:, 2:n_ref) phase_resp(:,1) phase_resp(:,n_ref+1:end)];
end