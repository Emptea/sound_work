clear all
sg_1 = 1;
%% first MA 0 deg
[sg_1, ~] = read_raw("../sd/2024.06.04-11-31-42+0000-035-7777-7777.e67");
[sg_2, ~] = read_raw("../sd/2024.06.04-11-36-42+0000-036-7777-7777.e67");
seg = 1.3e6:5.2e6;
theta = 0;
%% first MA 30deg
% [data, raw_data] = read_raw("2024.6.4-15-19-10+0000-000-33-33.e67");
% theta = pi/6;
%% first MA -30deg
% [data, raw_data] = read_raw("2024.6.4-15-24-56+0000-000-33-33.e67");
% theta = -pi/6;
%% first MA 90deg
% [data, raw_data] = read_raw("2024.6.4-15-30-26+0000-000-33-33.e67");
% theta = pi/2;

%% second MA 0 deg
[sg_1, ~] = read_raw("../sd/2024.06.04-12-44-27+0000-001-7777-47.e67");
[sg_2, ~] = read_raw("../sd/2024.06.04-12-49-27+0000-002-7777-47.e67");
seg = 3e6:7.5e6;
theta = 0;
%% second MA -30deg
% [data, raw_data] = read_raw("2024.6.4-16-4-42+0000-000-33-33.e67");
% theta = -pi/6;
%% second MA 30deg
% [data, raw_data] = read_raw("2024.6.4-16-9-24+0000-000-33-33.e67");
% theta = pi/6;
%% second MA 90deg
% [data, raw_data] = read_raw("2024.6.4-16-14-24+0000-000-33-33.e67");
% theta = pi/2;

if (length(sg_1) > 1)
    sg12 = [sg_1; sg_2];
    sg = sg12(seg,:);
    clear sg_1 sg_2 sg12
else
    sg = find_ref_mic(data, raw_data);
    clear data raw_data;
end

%%
[out, ~, ~] = extract_signal(sg,0);
freq_resp = find_freq_resp(out);

figure;
f = (4:80)*100;
plot(f, 20*log10(freq_resp./max(freq_resp(:,39))));
xlabel('f, Гц','FontSize', 12); ylabel('|H(f)|, дБ','FontSize', 12);
%%
[out, ~, ~] = extract_signal(sg,1);
x = cat(3, out(:, :, 40), out(:,:, 2:39), out(:,:,41:67));
x = permute(x, [1 3 2]);
phase_resp = find_phase_resp(x,f);
phase_resp = [phase_resp(:, 2:39) phase_resp(:,1) phase_resp(:,40:66)];

ph_check = get_d_phase_sphere(f,1.9,0,theta);
ph_check = ph_check' - ph_check(39,:)';

figure; plot(f, rad2deg(ph_check))
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);

figure; plot(f, rad2deg(phase_resp))
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);

figure; plot(phase_resp([1 ceil(length(f)/2) length(f)],:)')
xlabel('n_{mic}','FontSize', 12); ylabel('\phi(n), град','FontSize', 12);
legend('f = 400 Гц', 'f = 4200 Гц', 'f = 8000 Гц')

colors = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E", "#77AC30", "#4DBEEE"];
figure; h = plot(f, rad2deg(ph_check),'-o');
hold on; g = plot(f, rad2deg(phase_resp));
for i = 1:11
    for j = 1:6
        h(i+11*(j-1)).Color = colors(j);
        g(i+11*(j-1)).Color = colors(j);
    end
end
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);



mics_row = 23:33;

figure; plot(f, rad2deg(ph_check(:,mics_row)),'-o');
hold on; plot(f, rad2deg(phase_resp(:, mics_row)));
legend(arrayfun(@(n_mic) sprintf('n_{miвc} = %d', n_mic), mics_row, 'UniformOutput', false));
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);

figure; plot(f, rad2deg(ph_check(:,mics_row) - phase_resp(:, mics_row)));
xlabel('f, Гц','FontSize', 12); ylabel('\Delta \phi(f), град','FontSize', 12);
legend(arrayfun(@(n_mic) sprintf('n_{mic} = %d', n_mic), mics_row, 'UniformOutput', false));

mics_col = [5, 16, 27, 38, 49, 60];
figure; plot(f, rad2deg(ph_check(:,mics_col)),'-o');
hold on; plot(f, rad2deg(phase_resp(:, mics_col)));
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);
legend(arrayfun(@(n_mic) sprintf('n_{mic} = %d', n_mic), mics_col, 'UniformOutput', false));

figure; plot(f, rad2deg(ph_check(:,mics_col) - phase_resp(:, mics_col)));
xlabel('f, Гц','FontSize', 12); ylabel('\Delta \phi(f), град','FontSize', 12);
legend(arrayfun(@(n_mic) sprintf('n_{mic} = %d', n_mic), mics_col, 'UniformOutput', false));