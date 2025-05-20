obj = figure('Name', 'Flight Task Trajectory');
hold on
scatter(ref_point_east, ref_point_north, "filled")
% scatter(pan_l_east, pan_l_north, "filled")
% plot([ref_point_east pan_l_east], [ref_point_north pan_l_north], ':')
scatter(pan_r_east, pan_r_north, "filled")
plot([ref_point_east pan_r_east], [ref_point_north pan_r_north], ':')

gifFile = 'P1000.gif';
exportgraphics(obj, gifFile);
% 2. Within a loop, append the gif image
for current_pos = 1:99
  pos_idx = round(current_pos*length(uav_east)/100);
  plot(uav_east(1:pos_idx), uav_north(1:pos_idx), 'b')
  
  exportgraphics(obj, gifFile, Append=true);
end