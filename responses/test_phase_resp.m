f = (4:80)*100;
t = (0:88)'/16e3;
phi0 = 0:2*pi/72:2*pi;
test = zeros(length(t), length(f), length(phi0));
for i = 1:length(phi0)
    test(:,:,i) = sin(2*pi*f.*t + phi0(i));
end
test = permute(test, [1 3 2]);

sigs = hilbert(test);    

bias = permute(exp(1i*phi0), [1 3 4 2]);
biased_test = permute(real(sigs.*bias), [1 4 2 3]);
biased_test = biased_test./max(biased_test,[],1);
n_mics = length(phi0);
corr_coeffs = zeros(size(bias,4), n_mics, length(f));
for i = 2:n_mics
    for j = 1:length(f)
       rho = corr(biased_test(:,1,i,j), biased_test(:,:,1,j));
       corr_coeffs(:,i,j) = rho;
    end
end
[mx, idx] = max(corr_coeffs,[],1);
phase_resp = phi0(reshape(idx, [], 1));
phase_resp = reshape(phase_resp, length(phi0), length(f));