function sg = find_ref_mic(data, raw_data)
rms_vec = rms(data);
[~, n_rms] = max(rms_vec);

n_end = floor((length(raw_data))/67)*67 + n_rms;
if (n_end > length(raw_data))
    n_end = n_end - 67;
end
rms_sg = raw_data(n_rms:(n_end-1));
rms_sg = reshape(rms_sg, 67, [])' / 32768;

if(max(rms_sg(:,1)) < max(rms_sg(:,2:end), [], 'all'))
    corr_vec = find_corr(data);
    [~, n_corr] = max(corr_vec);
    n_end = floor((length(raw_data))/67)*67 + n_corr;
    if (n_end > length(raw_data))
        n_end = n_end - 67;
    end
    sg = raw_data(n_corr:(n_end-1));
    sg = reshape(sg, 67, [])' / 32768;
else
    sg = rms_sg;
end
