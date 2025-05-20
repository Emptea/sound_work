shots_pan2 = get_path('D:\Sber\sounds\gun_task\PAN2\pos4', '*mat');

Fs = 16e3;
n_med = 201;
n_rms = 3000;
movRMS = dsp.MovingRMS(n_rms);

n_step = 1600;

for k = 1:length(shots_pan2)
    load(shots_pan2(k))
    T = T_pan2;
    delta_t = seconds(T.Time - T.Time(1));
    sig_sum = double(T.Signal_sum);

    % Амплитудный детектор
    [mag_dec, n_mag_thr] = amp_detector(sig_sum, n_step);

    % Детектор длительности - для отсеивания похожих сигналов (например,
    % ветер), но не подходящих по длительности под выстрел
    x = sig_sum;
    x_med = dur_detector(x, 10, n_med, movRMS);
    [starts, ends] = find_dur(x_med);

    % Сравнение выходов детекторов
    idxs = find(n_mag_thr == 1);
    pulse = false(length(idxs),length(starts));
    n_det = zeros(length(starts), 1);
    for i = 1:length(starts)
        pulse(:,i) = idxs >= floor(starts(i)/160) & idxs<= ceil(ends(i)/160);
        n_det(i) = idxs(pulse(:,i));
    end
    det = zeros(size(n_mag_thr));
    if all(n_det > 0)
        det(n_det) = 1;
    end

    % Plot results
    figure; plot(sig_sum);
    figure; plot(diff(mag_dec));
    figure; plot(n_mag_thr);

    % figure; plot(mag2db(x_med))
    % xline(starts)
    % xline(ends)

    figure; subplot(2,1,1)
    plot(delta_t,x)
    xlim([delta_t(1) delta_t(end)])
    ylim([-intmax('int16') intmax('int16')]/5)
    xlabel("Время, с")
    ylabel("Амплитуда")
    subplot(2,1,2)
    plot(delta_t(1:n_step:end),det)
    xlim([delta_t(1) delta_t(end)])
    xlabel("Время, с")
    ylabel("Детектирование")
end
%%
function x_med = dur_detector(x, n_step, n_med, movRMS)
    x_sq = movRMS(x);
    x_1ms = x_sq(1:n_step:end);
    x_med = medfilt1(x_1ms, n_med);
end
%%
function [starts, ends] = find_dur(x_med)
    n_dur_thr = mag2db(x_med)>35;
    diff_array = diff([0;n_dur_thr; 0]);
    starts = find(diff_array == 1);
    ends = find(diff_array == -1);
    dur = ends-starts;
    idxs = dur > 3000 & dur < 6000;
    starts = starts(idxs);
    ends = ends(idxs);
end
%%
function [mag_dec, n_mag_thr] = amp_detector(sig, n_step)
    mag = mag2db(movmean(sig.^2, 1000));
    mag_dec = mag(1:n_step:end);
    n_mag_thr = [0; diff(mag_dec) > 20];
end