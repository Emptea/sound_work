close all
clear variables 
close all
signal2double = @(signal) double(signal)/double(intmax("int16")); 

%%
% flight_task1
ref_point = [56.10234300 35.884162 0];
pan_loc_l = [56.09855167 35.874385 0];
pan_loc_r = [56.09771450 35.875883 0];

filepath = 'G:\sound_work\23042025 orevo\done\';
filename = filepath+"pan_coord.csv";
opts = detectImportOptions(filename);
opts.VariableNames = ["lat", "lon","angle","name"];
coords = readtable(filename,opts);
pan_loc_l = [coords.lat(1) coords.lon(1) 0];
pan_loc_r = [coords.lat(2) coords.lon(2) 0];
ref_point = [calculate_angle(pan_loc_l(1), pan_loc_l(2), coords.angle(1), 100)];
% ref_point = [54.748768 83.313145 0];
% pan_loc_r = [54.743362 83.317373 0];

% flight_task2
% ref_point = [54.742402 83.307991 0];
% pan_loc_r = [54.744722 83.316944 0];

% flight_task3
% ref_point = [54.743122 83.313262 0];
% pan_loc_l = [54.743611 83.317500 0];
% pan_loc_r = [54.744444 83.316944 0];

% sber
% pan_loc_l = [55.845043 37.013443 0];
% pan_loc_r = [55.845040 37.013472 0];
% ref_point = [calculate_angle(pan_loc_l(1), pan_loc_l(2), 12, 100)];

%%
workdir = 'G:\sound_work\23042025 orevo\done\'; 
[filearray, patharray] = uigetfile({'*.mat'}, ...
    'Select a array file', workdir);
[fileuav, pathuav] = uigetfile({'*.mat'}, ...
    'Select a uav file', workdir);

filepatharray = fullfile(patharray, filearray);
filepathuav = fullfile(pathuav, fileuav);
[pan_data_t, uav_data_t] = read_flight(filepatharray,filepathuav);

uav_coord = extrap_uav_coord(uav_data_t, pan_data_t);

% pan_data_t = removevars(pan_data_t,{'Signal_sum'});


pan_data = table2array(pan_data_t);
pan_data = signal2double(pan_data);

clear pan_data_t uav_data_t

[uav_east, uav_north] = latlon2local(uav_coord.lat, uav_coord.lon, 0, ...
    ref_point);
[ref_point_east, ref_point_north] = latlon2local(ref_point(1), ref_point(2), ref_point(3), ...
    ref_point);
[pan_l_east, pan_l_north] = latlon2local(pan_loc_l(1), pan_loc_l(2), pan_loc_l(3), ...
    ref_point);
[pan_r_east, pan_r_north] = latlon2local(pan_loc_r(1), pan_loc_r(2), pan_loc_r(3), ...
    ref_point);

figure('Name', 'Flight Task Trajectory');
hold on
scatter(ref_point_east, ref_point_north, "filled")
scatter(pan_l_east, pan_l_north, "filled")
plot([ref_point_east pan_l_east], [ref_point_north pan_l_north])
scatter(pan_r_east, pan_r_north, "filled")
plot([ref_point_east pan_r_east], [ref_point_north pan_r_north])
plot(uav_east, uav_north)
% axis('equal');
% xlim([-650 -200])
% ylim([-550 -200])
legend('REF', 'PAN L', 'PAN L DIRECTION', 'PAN R', 'PAN DIRECTION', 'UAV')


% flight_task2
% [uav_east, uav_north] = latlon2local(uav_coord.lat, uav_coord.lon, 0, ...
%     pan_loc_r);
% [ref_point_east, ref_point_north] = latlon2local(ref_point(1), ref_point(2), ref_point(3), ...
%     pan_loc_r);
% [pan_r_east, pan_r_north] = latlon2local(pan_loc_r(1), pan_loc_r(2), pan_loc_r(3), ...
%     pan_loc_r);
% 
% figure('Name', 'Flight Task Trajectory');
% hold on
% scatter(ref_point_east, ref_point_north, "filled")
% % scatter(pan_l_east, pan_l_north, "filled")
% % plot([ref_point_east pan_l_east], [ref_point_north pan_l_north])
% scatter(pan_r_east, pan_r_north, "filled")
% plot([ref_point_east pan_r_east], [ref_point_north pan_r_north])
% plot(uav_east, uav_north)
% % axis('equal');
% % xlim([-650 -200])
% % ylim([-550 -200])
% % legend('REF', 'PAN L', 'PAN L DIRECTION', 'PAN R', 'PAN DIRECTION', 'UAV')
