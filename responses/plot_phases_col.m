function plot_phases_col(mics_col, freqs, ph_check, phase_resp)
% Построение реальной и теоретической ФЧХ на одном графике
% и их разности - на другом для колонки микрофонов
% mics_cols - номера микрофонов в колонке
% freqs - вектор частот
% phase_resp - ФЧХ реальная
% ph_check - ФЧХ теоретическая
figure; 
h1 = plot(freqs, rad2deg(ph_check(:,mics_col)),'-o');
colors = get(h1, 'Color');
hold on; 
for i = 1:length(h1)
    plot(freqs, rad2deg(phase_resp(:, mics_col(i))), '-', 'Color', colors{i});
end
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);
legend(arrayfun(@(n_mic) sprintf('n_{mic} = %d', n_mic), mics_col, 'UniformOutput', false),'Location', 'northwest');
hold off

figure; plot(freqs, rad2deg(ph_check(:,mics_col) - phase_resp(:, mics_col)));
xlabel('f, Гц','FontSize', 12); ylabel('\Delta \phi(f), град','FontSize', 12);
legend(arrayfun(@(n_mic) sprintf('n_{mic} = %d', n_mic), mics_col, 'UniformOutput', false),'Location', 'northwest');
end