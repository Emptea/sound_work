T = T1;
start_idx_left = find(T_left.Time>=T.Time(1),1);
start_idx_right = find(T_right.Time>=T.Time(1),1);
end_idx_left = find(T_left.Time>=T.Time(end),1);
end_idx_right = find(T_right.Time>=T.Time(end),1);
start_idx = find(fly_old.time>=T.Time(1),1);
end_idx = find(fly_old.time>=T.Time(end),1);

save(filepath + "\mic4_phantom_03_cut_forward_01" + ".mat","T","-v7.3")
fly = fly_old(start_idx:end_idx,:);
save(filepath + "\fly_phantom_03_cut_forward_01" + ".mat","fly")
T = T_left(start_idx_left:end_idx_left,:);
save(filepath + "\pan1_phantom_03_cut_forward_01" + ".mat","T","-v7.3")
T = T_right(start_idx_right:end_idx_right,:);
save(filepath + "\pan2_phantom_03_cut_forward_01" + ".mat","T","-v7.3")