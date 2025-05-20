function [sigs, idx] = extract_pulses(freqs, arr, n_ref, start_100Hz, level)
% Находит начало импульсов и извлекает n_samples отсчетов через n_bias
% не находит начало импульса частоты 100 Гц, т.к. у него малая амплитуда
n_bias = 500;
n_samples = 2048;
sg = arr(:, n_ref);

[up, ~] = envelope(single(sg)); % нахождение огибающей
crossings = diff(up > level);
up_crossings = find(crossings == 1); % Индексы начала пересечений
down_crossings = find(crossings == -1); % Индексы конца пересечений

% Убедимся, что у нас парное количество пересечений
if length(up_crossings) > length(down_crossings)
    down_crossings = [down_crossings, length(x)];
end
if length(down_crossings) > length(up_crossings)
    up_crossings = [1, up_crossings];
end

idxs = find(abs(up_crossings-down_crossings) > 100); % отсечка по длине импульса
up_crossings = up_crossings(idxs);
% down_crossings = down_crossings(idxs);
% n_samples =  min(down_crossings- up_crossings);

n_pulses = length(freqs);
start_pulses = [start_100Hz; up_crossings(1:end-1); up_crossings(end)]+n_bias;
idx = reshape((0:n_samples-1)' + start_pulses(:)', 1, []);

ext = arr(idx, :);
sigs = reshape(ext, [], n_pulses, size(ext, 2)); % n_samples x n_pulses x n_mics
end