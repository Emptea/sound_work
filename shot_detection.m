clear all;
% close all;
% shots_pan2 = get_path('.\shots\PAN1\', '*all*.mat');
shots_pan2 = get_path('.\08112024_flies\', '*.mat');
Fs = 16e3;
n_med = 200;
n_rms = 10;
movRMS = dsp.MovingRMS(n_rms);

n_step = 1600;

for k = 1:20%length(shots_pan2)
    load(shots_pan2(k))
    try
        T = T_pan1;
    end

    try
        T = T_pan2;
    end

    try
        T = T_master;
    end
    delta_t = seconds(T.Time - T.Time(1));
    sig_sum = double(T.Signal_sum)/32768;

    % Амплитудный детектор
    [mag_dec, n_mag_thr] = amp_detector(sig_sum, n_step);
    % subplot(3,1,1);
    % plot(mag_dec);
    % subplot(3,1,2);
    % plot(n_mag_thr);
    n = find(n_mag_thr == 1);
    n_mag_thr(n(find(diff(n) < 4) + 1)) = 0;

    for i = 1:length(n)
        nn = n(i) - 1;
        d_start = nn + 2;
        d_end = min(nn + 10, length(mag_dec));
        if sum(mag_dec(d_start:d_end) - mag_dec(nn) < 0) > 0
            n_mag_thr(n(i)) = 0;
        end
        
        % if any(diff(mag_dec(d_start:d_start+20)) < - 20)
        %     n_mag_thr(n(i)) = 0;
        %     %figure; plot(diff(mag_dec(nn:nn+20))); legend(string(nn))
        % end
        if sum(diff(mag_dec(d_start+5:d_start+20)) < -10) > 2
            n_mag_thr(n(i)) = 0;
        end

    end
    idx = find(n_mag_thr == 1);
    for l = 1:length(idx)
        hold on; plot(abs(diff(mag_dec(idx(l):min(idx(l)+20, length(mag_dec))))))
    end
    % subplot(3,1,3);
    % plot(n_mag_thr);
    continue;

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
    mag = mag2db(movmean(sig.^2, 800));
    mag_dec = mag(1:n_step:end);
    n_mag_thr = [0; mag_dec(3:end) - mag_dec(1:end - 2)  > 30; 0];
end