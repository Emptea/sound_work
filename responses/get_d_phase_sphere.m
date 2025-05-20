function d_phase_sphere = get_d_phase_sphere(test_freq, r, phi, theta)
% Нахождение фазового набега сферической волны на микрофонной решетке
% относительно опорного (центральный)
% test_freq - вектор частот
% r - расстояние от МР до излучателя
% phi - направление на излучатель по азимуту, рад
% theta - направление на излучатель по УМ, рад
speed_sound = 343;
test_lambda = speed_sound ./ test_freq;

M_y = [cos(theta)   0   sin(theta);
       0            1   0;
       -sin(theta)  0   cos(theta)];
M_z = [cos(phi)   -sin(phi)   0;
       sin(phi)   cos(phi)    0;
       0          0           1];

% mic_arr.dx = 35e-3;
% mic_arr.dy = 50e-3;
% mic_arr.nx = 11;
% mic_arr.ny = 6;
mic_arr.dx = 35e-3;
mic_arr.dy = 50e-3;
mic_arr.nx = 7;
mic_arr.ny = 4;
n_all = mic_arr.nx*mic_arr.ny; 

mic_coord = get_mic_arr_coord(mic_arr);

src_x = r*sin(theta)*cos(phi);
src_y = r*sin(theta)*sin(phi);
src_z = r*cos(theta);
src_coord = [src_x; src_y; src_z];
src_c = src_coord./vecnorm(src_coord);

src_arr = repmat(src_c', 28,1) - mic_coord;
mic_dist = vecnorm(src_arr')';
d_phase_sphere = 2*pi*(mic_dist - r)./test_lambda;
end