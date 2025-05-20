function [out, sigs, start_pulses] = extract_signal(mic_data, use_ref)
arguments
    mic_data (:,67)
    use_ref double
end
% CONSTANTS
n_start = find(abs(mic_data) > 1e-1, 1) - 10;
n_samples = 10000; % round(1.9/343*16e3);
n_pulses = 77;
n_between = 48314;
n_mics = 67;
n_samples_to_extract = round(1.9/343*16e3);
%

start_pulses = n_start + (0:n_pulses-1)*n_between;
idx = reshape((0:n_samples-1)' + start_pulses(:)', 1, []);

ext = mic_data(idx, :);
sigs = reshape(ext, [], n_pulses, size(ext, 2));

needed_idxs = zeros(n_pulses,n_mics);
if (use_ref == 1)
    [r,c] = find(sigs(:,:,39) > 2e-2);
    [~, c_idx] = unique(c);
    needed_idxs = repmat(r(c_idx),1, n_mics);
else
    for i = 1:n_mics
       [r,c] = find(sigs(:,:,i) > 2e-2);
       [c_uniq, c_idx] = unique(c);
       if length(c_idx) < n_pulses
           c_idx_lost = setdiff(1:n_pulses, c_uniq);
           [r_lost, c_lost] = find(sigs(:,c_idx_lost,i) > 1e-2);
           [~, c_idx_lost] = unique(c_lost);
           [~, sort_order] = sort([c_idx; c_idx_lost]);
           r = [r(c_idx); r_lost(c_idx_lost)];
           needed_idxs(:,i) = r(sort_order);
       else
           needed_idxs(:,i) = r(c_idx);
       end     
    end
end

samples_to_add = reshape((0:n_samples_to_extract-1)-3, 1, 1, []);
ix = permute(needed_idxs+samples_to_add, [3 1 2]);

out = zeros(n_samples_to_extract,77,n_mics);
for j=1:n_mics
    for i = 1:n_pulses
        out(:,i,j) = sigs(ix(:,i,j),i,j);
    end
end

end