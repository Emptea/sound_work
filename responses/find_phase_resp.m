function phase_resp = find_phase_resp(x,f)
n_mics = size(x,2);
phi0 = 0:2*pi/(360*4):2*pi;
sigs = hilbert(x);    

bias = permute(exp(-1i*phi0), [1 3 4 2]);
biased_sg = permute(real(sigs.*bias), [1 4 2 3]);
biased_sg = biased_sg./max(biased_sg,[],1);

corr_coeffs = zeros(size(bias,4), n_mics, length(f));
for i = 2:n_mics
    for j = 1:length(f)
       rho = corr(biased_sg(:,1,i,j), biased_sg(:,:,1,j));
       corr_coeffs(:,i,j) = rho;
    end
end
[~, idx] = max(corr_coeffs,[],1);
phase_resp = phi0(reshape(idx, [], 1));
phase_resp = reshape(phase_resp, n_mics, length(f));
phase_resp = unwrap(phase_resp(:,:)');
phase_resp(:, find(phase_resp(1,:)> pi)) = phase_resp(:, find(phase_resp(1,:)> pi)) - 2*pi;
