%% Чтение обнаружений
fs = 48000;
internal_overlapping = 0.0;

perf_dir = "G:\sound_work\scripts\tung\predictions\phantom1\cnn4\"; 
classificator = read_json(perf_dir);
mclassificator = extrapolate_predictions(fs, internal_overlapping, classificator);

figure;
plot(uav_east, uav_north, 'MarkerIndices', find(mclassificator.predictions), 'marker','.')

% axis('equal');