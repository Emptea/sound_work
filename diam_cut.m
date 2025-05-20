% idx = find(fly_old.lat <= fly.lat(1) & fly_old.lat >= fly.lat(end) & fly_old.time > fly.time(1));
% d = diff(idx); % разности между соседними индексами
% breaks = [0; d ~= 1]; % где разрыв (разность не равна 1)
% fly_new = fly_old(idx,:);
% group_starts = find(breaks);
% group_ends = [group_starts(2:end)-1; size(fly_new,1)];
k = 1;
for i = 1:length(group_starts)
    fly = fly_new(group_starts(i):group_ends(i),:);
    if (~mod(i,2))
        k = k + 1;
        save(filepath + "fly_diam_02_cut_forward_0" + string(k) + ".mat","fly")
    else
        save(filepath + "fly_diam_02_cut_backward_0" + string(k) + ".mat","fly")
    end
end