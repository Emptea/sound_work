function plots_phases_all(freqs, phase_resp, ph_check, ny, nx)
% Построение ФЧХ практической и теоретической с одинаковыми цветами
% графиков по параметру nx
% freqs - вектор частот
% phase_resp - ФЧХ реальная
% ph_check - ФЧХ теоретическая
% nx - количество рядов
% ny - количество стоблцов

colors = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E", "#77AC30", "#4DBEEE"];
figure; h = plot(freqs, rad2deg(ph_check),'-o');
hold on; g = plot(freqs, rad2deg(phase_resp));
for i = 1:nx
    for j = 1:ny
        h(i+nx*(j-1)).Color = colors(j);
        g(i+nx*(j-1)).Color = colors(j);
    end
end
xlabel('f, Гц','FontSize', 12); ylabel('\phi(f), град','FontSize', 12);

end