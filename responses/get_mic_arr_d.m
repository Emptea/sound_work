function dist = get_mic_arr_d(pararams, r, phi, theta)

[src_x, src_y, src_z] = sph2cart(phi, pi/2-theta, r);

mic_coord = get_mic_arr_coord(mic_arr, r, phi);
src_coord = [src_x; src_y; src_z];
dist = vecnorm(mic_coord - src_coord);
end