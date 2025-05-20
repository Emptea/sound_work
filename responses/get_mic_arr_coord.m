function coord = get_mic_arr_coord(pararams)
% Нахождение координат решетки по вектору параметров
% nx - количество рядов
% ny - количество стоблцов
% dx - расстояние между микрофонами по x
% dy - расстояние между микрофонами по y
nx = pararams.nx;
ny = pararams.ny;
dx = pararams.dx;
dy = pararams.dy;

cols = -(nx - 1)/2:(nx - 1)/2;
% rows = -(ny - 1)/2:(ny - 1)/2;
rows = -(-ny/2+1:(ny)/2);

[x, y] = meshgrid(cols*dx, rows*dy);
x = x';
y = y';
%coord = [x(:), y(:), r*ones(nx*ny, 1)];
coord = [x(:), y(:), zeros(nx*ny, 1)];
end