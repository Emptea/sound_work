clear
filename = "2024.6.4-15-59-31+0000-001-33-33.e67";
idx_ref_mic = 33;
idx_del_mic = 67;
idx_sig_mic = 1:67;
idx_sig_mic(idx_del_mic) = [];
r = 2;
fs = 16000;
%
data = read_raw(filename);
% [data, t] = gen_test_data_multi(10);
% [data, t] = gen_test_data_mono(10, 1000);
%%
[d_amp_db, d_phase, amps_max_db, phase_max, s, f] = work_data(...
    data, fs, idx_sig_mic, idx_ref_mic);

%% plot
if ~exist('filename', 'var')
    filename="no file";
end
figure("Name",filename);
subplot(2,1,1);
plot(d_amp_db)
ylabel("\Deltaa, дБ")
subplot(2,1,2);
plot(rad2deg(d_phase))
ylabel("\Delta\phi, град")