clear
filename = "2024.6.4-13-53-52+0000-000-33-33.e67";
idx_ref_mic = 39;
idx_del_mic = 67;
idx_sig_mic = 1:67;
idx_sig_mic(idx_del_mic) = [];
r = 2;
fs = 16000;

d_phase_sphere = get_d_phase_sphere(3000, r);

files = string(ls("*.e67"));

for i = 1:length(files)
    filename = files(i);
    work_file;
end

