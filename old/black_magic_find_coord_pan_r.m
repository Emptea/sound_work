function black_magic_find_coord_pan_r()

rep = [56.102343 35.884162];
fly_start = [56.0977249689059 35.8759022040024];
pan_l = [56.09855167 35.874385];

% Координаты точек
x1 = 0;
y1 = 0;
[x2, y2] = latlon2local(fly_start(1), fly_start(2), 0, [rep(1), rep(2), 0]);
[x3, y3] = latlon2local(pan_l(1), pan_l(2), 0, [rep(1), rep(2), 0]);

% Наклон первой линии
m = (y2 - y1) / (x2 - x1);
b = y1 - m * x1;

% Коэффициенты для второй линии
m_perpendicular = -1 / m;
b_perpendicular = y3 - m_perpendicular * x3;

% Решаем систему уравнений
syms x y;
eq1 = y == m * x + b;
eq2 = y == m_perpendicular * x + b_perpendicular;
sol = solve([eq1, eq2], [x, y]);

x_intersection = double(sol.x);
y_intersection = double(sol.y);
[pan_r_lat, pan_r_lon] = ...
    local2latlon(x_intersection, y_intersection, 0, [rep(1); rep(2); 0]);
fprintf('Точка пересечения: (%.8f, %.8f)\n', x_intersection, y_intersection);
fprintf('Координаты левого ПАН: (%.8f, %.8f)\n', pan_r_lat, pan_r_lon);

end