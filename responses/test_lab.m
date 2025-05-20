filename = "lab_short";
load("F:\work\sound_work\калибровка\" + filename + ".mat")
arr = table2array(T(:,3:30));
n_ref = 11;
%%
starts = readtable("калибровка\starts_" + filename + ".csv");
freqs = starts.f';
start_pulses = starts.start_idx;
n_samples = 200;
n_pulses = length(freqs);

idx = reshape((0:n_samples-1)' + start_pulses(:)', 1, []);

ext = arr(idx, :);
sigs = reshape(ext, [], n_pulses, size(ext, 2));
%% 
freq_resp = find_freq_resp(sigs);

figure;
semilogx(freqs, 20*log10(freq_resp./max(freq_resp(:,n_ref))));
xlabel('f, Гц','FontSize', 12); ylabel('|H(f)|, дБ','FontSize', 12);

%%
phase_resp = find_phases_for_pulses(sigs,n_ref, freqs);

figure; semilogx(freqs, rad2deg(phase_resp))
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);

ph_check = get_d_phase_sphere(freqs,2.9,0,0);
ph_check = ph_check' - ph_check(n_ref,:)';

plots_phases_all(freqs, phase_resp, ph_check, 4, 7)

mics_row = 8:14;
plot_phases_row(mics_row, freqs, ph_check, phase_resp)

mics_col = 4:7:25;
plot_phases_col(mics_col, freqs, ph_check, phase_resp)