close all

gifFile = '-45 45 1 10 MUSIC phantom06task.gif';
    
% 2. Within a loop, append the gif image
cnt = 100;
for current_pos = 1:cnt
    obj = figure('Name', 'MUSIC');
    tiledlayout(2,2);
    
    disp(current_pos)
    pos_idx = round(current_pos*length(uav_east)/cnt);

    nexttile([1 2]);
    hold on
    scatter(ref_point_east, ref_point_north, "filled")
    scatter(pan_l_east, pan_l_north, "filled")
    plot([ref_point_east pan_l_east], [ref_point_north pan_l_north], ':')
    scatter(pan_r_east, pan_r_north, "filled")
    plot([ref_point_east pan_r_east], [ref_point_north pan_r_north], ':')
    plot(uav_east(1:pos_idx), uav_north(1:pos_idx))
    axis('equal');
    hold off
    %
    z_dist = z_source(1);
    
    search_freql = scan_freq(1); 
    search_frequ = scan_freq(end);
    
    %
    nexttile(3)
    pan_l_frame = pan_l_data((pos_idx-frame_duration*fs + 1):pos_idx,:);
    [X_l, Y_l, B_l] = beamforming(pan_l_frame, steering_type, beamform_type, fs, z_dist, scan_freq, scan_x, scan_y, scan_resolution, mic_pos, mic_centre);
    
    B_l(B_l<0)=0;
    SPL_l = 20*log10((eps+sqrt(real(B_l)))/2e-5);
   
    BF_dr = 6; maxSPL = ceil(max(SPL_l(:)));
    contourf(X_l, Y_l, SPL_l, (maxSPL-BF_dr):1:maxSPL); colorbar; clim([maxSPL-BF_dr maxSPL])
%     set(gcf,'Position',[20 100 640 500]);	 
%     set(gca,'FontSize',24); set(gca,'linewidth',2); set(gcf,'Color','w');	
    xlim(scan_x); ylim(scan_y);
    axis equal

    nexttile(4)
    pan_r_frame = pan_r_data((pos_idx-frame_duration*fs + 1):pos_idx,:);
    [X_r, Y_r, B_r] = beamforming(pan_r_frame, steering_type, beamform_type, fs, z_dist, scan_freq, scan_x, scan_y, scan_resolution, mic_pos, mic_centre);
    
    B_r(B_r<0)=0;
    SPL_r = 20*log10((eps+sqrt(real(B_r)))/2e-5);

    BF_dr = 6; maxSPL = ceil(max(SPL_r(:)));
    contourf(X_l, Y_l, SPL_r, (maxSPL-BF_dr):1:maxSPL); colorbar; clim([maxSPL-BF_dr maxSPL])
%     set(gcf,'Position',[20 100 640 500]);	 
%     set(gca,'FontSize',24); set(gca,'linewidth',2); set(gcf,'Color','w');	
    xlim(scan_x); ylim(scan_y);
    axis equal
  
    exportgraphics(obj, gifFile, Append=true);
    close all
end