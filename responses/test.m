addpath(genpath("scripts\"))
%%
filename = "speaker_long_test1";
filepath = "F:\work\sound_work\калибровка\";
load(filepath+filename+".mat")

if (regexp(filename, "short"))
    freqs = [100:100:1100 2000:1000:8000];
else 
    freqs = [100:100:1000 2000:1000:8000];
end

level = 700;
tab = readtable(filepath + "starts_speaker.csv");
start_100Hz = tab.start_idx(matches(tab.filename, filename));
n_ref = 11;
n_mics = 28;

if (regexp(filename, "test1"))
    phi0 = 5/2900;
else
    phi0 = 0;
end
%% 
sg = T.Signal_14;
arr = table2array(T(:,3:30));
[sigs,idx] = extract_pulses(freqs, arr, n_ref, start_100Hz, level);
%% 
freq_resp = find_freq_resp(sigs);

figure;
plot(freqs, 20*log10(abs(freq_resp)./max(abs(freq_resp(:,n_ref)))));
xlabel('f, Гц','FontSize', 12); ylabel('|H(f)|, дБ','FontSize', 12);

%%
phase_resp = find_phases_for_pulses(sigs,n_ref, freqs);
figure; plot(freqs, rad2deg(phase_resp))
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);

ph_check = get_d_phase_sphere(freqs,2.9,phi0,0);
ph_check = ph_check' - ph_check(n_ref,:)';
figure; plot(freqs, rad2deg(ph_check))
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);

plots_phases_all(freqs, phase_resp, ph_check, 4, 7)

mics_row = 8:14;
plot_phases_row(mics_row, freqs, ph_check, phase_resp)

mics_col = 4:7:25;
plot_phases_col(mics_col, freqs, ph_check, phase_resp)
%%
group_delay = diff([zeros(1,28); phase_resp])./diff([0; freqs']);
figure; plot(freqs, group_delay)
xlabel('f, Гц','FontSize', 12); ylabel('\tau_g(f), град','FontSize', 12);
%%
N = 512;
freqs_norm = [0 freqs/max(freqs)];
b = zeros(n_mics,N+1);
sg_filt = zeros(length(sg), n_mics);
for i = 1:n_mics
    if (i == 9)
        sg_filt(:,i) = T{:,i+2};
    end
    d = fdesign.arbmag('N,F,A',N,freqs_norm,[0;abs(freq_resp(1:15,n_ref))./abs(freq_resp(1:15,i)); 0; 0]);
    % figure; plot(abs(freq_resp(:,n_ref)) + (abs(freq_resp(:,n_ref)) - abs(freq_resp(:,i))))
    Hd = design(d,'freqsamp','SystemObject',true);
    % fvtool(Hd,'MagnitudeDisplay','Zero-phase','Color','White');
    x=T{:,i+2};
    b(i,:)=Hd.Numerator;
    if (abs(freq_resp(:,n_ref))>abs(freq_resp(:,i)))
        sg_filt(:,i)=filter(b(i,:),1,x);
    else 
        b(i,:) = -b(i,:);
        sg_filt(:,i)=filter(b(i,:),1,x);
    end
end
ext = sg_filt(idx, :);
n_pulses = length(freqs);
sigs_filt = reshape(ext, [], n_pulses, size(ext, 2)); % n_samples x n_pulses x n_mics
freq_resp_filt = find_freq_resp(sigs_filt);

figure;
plot(freqs, 20*log10(abs(freq_resp_filt)./max(abs(freq_resp_filt(:,n_ref)))));
xlabel('f, Гц','FontSize', 12); ylabel('|H(f)|, дБ','FontSize', 12);