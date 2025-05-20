function plot_phases_row(mics_row, freqs, ph_check, phase_resp)
% Построение реальной и теоретической ФЧХ на одном графике
% и их разности - на другом для ряда микрофонов
% mics_row - номера микрофонов в ряду
% freqs - вектор частот
% phase_resp - ФЧХ реальная
% ph_check - ФЧХ теоретическая
figure; 
h1 = plot(freqs, rad2deg(ph_check(:,mics_row)),'-o');
colors = get(h1, 'Color');
hold on; 
for i = 1:length(h1)
    plot(freqs, rad2deg(phase_resp(:, mics_row(i))), '-', 'Color', colors{i});
end
legend(arrayfun(@(n_mic) sprintf('n_{mic} = %d', n_mic), mics_row, 'UniformOutput', false),'NumColumns', 2, 'Location', 'northwest');
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);

figure; plot(freqs, rad2deg(ph_check(:,mics_row) - phase_resp(:, mics_row)));
xlabel('f, Гц','FontSize', 12); ylabel('\Delta \phi(f), град','FontSize', 12);
legend(arrayfun(@(n_mic) sprintf('n_{mic} = %d', n_mic), mics_row, 'UniformOutput', false),'NumColumns', 2, 'Location', 'northwest');

end