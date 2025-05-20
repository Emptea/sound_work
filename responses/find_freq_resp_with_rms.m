function freq_resp = find_freq_resp_with_rms(out)
% Нахождение АЧХ относительно опорного микрофона по среднеквадратическому
% за опорный принимается 1 микрофон
freq_resp = zeros(size(out,2),size(out,3)-1);
for i = 2:size(out,3)
    freq_resp(:,i-1) = rms(out(:,:,i));
end