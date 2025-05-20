function straight_signal = unwrap_int16(sync,peak_idx)
 s = double(sync(peak_idx:4:end));
 idxs_of_jumps = find(diff(double(s))==-65520)+1;
 corrections = zeros(size(s));

 corrections(idxs_of_jumps) = 65536;  % или другое значение, если скачки не на 65536

% Кумулятивная сумма корректировок
cum_corrections = cumsum(corrections);

% Развернутый сигнал
straight_signal = double(s) + cum_corrections;
end