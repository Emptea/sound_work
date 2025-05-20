function finding_reconstr_filter(freq_resp, n_ref, freqs)
H1 = freq_resp(:,13);
H2 = freq_resp(:,n_ref);
G = abs(H2)./ (abs(H1));
f = linspace(100,8e3,512);
vq = interp1(freqs, G, f);
ord = 16;

f_normalized = f/8e3;
G_fir = firpm(ord, f_normalized,vq);
H_fir = freqz(G_fir, 1, f, 16e3);

figure; semilogx(f, [vq; H_fir]);