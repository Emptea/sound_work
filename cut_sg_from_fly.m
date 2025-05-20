function cut_sg_from_fly(T,fly,savename)
    start_idx = find(T.Time >= fly.time(1),1);
    end_idx = find(T.Time >= fly.time(end),1);
    T = T(start_idx:end_idx,:);
    save(savename,"T","-v7.3");
end