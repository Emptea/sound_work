function [T_pan1, T_pan2, fly_cut, k] = find_track(k, pth, fly, list1, list2)
arguments
    k double
    pth string
    fly (:, 4) table
    list1
    list2
end
    filename = list1(k);
    filepath = strcat(pth, 'PAN_1/', filename);    
    [sg1, t1] = read_sg(filepath, filename);

    filename = list2(k);
    filepath = strcat(pth, 'PAN_2/', filename);
    [sg2, t2] = read_sg(filepath, filename);

    while mod(length(sg1), 60*5*16e3) == 0
        k = k + 1;
        filename = list1(k);
        filepath = strcat(pth, 'PAN_1/', filename);   
        [sg1_2, t1_2] = read_sg(filepath, filename);
        sg1 = [sg1; sg1_2];
        t1 = [t1 t1_2];
        
        filename = list2(k);
        filepath = strcat(pth, 'PAN_2/', filename);   
        [sg2_2, t2_2] = read_sg(filepath, filename);
        sg2 = [sg2; sg2_2];
        t2 = [t2 t2_2];
    end

    [t,i1,i2] = intersect(t1, t2);
    sg1 = sg1(i1,:);
    sg2 = sg2(i2,:);
    
    [~, i_fly, i_t] = intersect(fly.time, t);
    fly_cut = fly(i_fly(1):i_fly(end),:);

    % idxs_t2match = i_t(1):i_t(end);
    % t = t(idxs_t2match);
    % sg1 = sg1(idxs_t2match,:);
    % sg2 = sg2(idxs_t2match, :);

    idxs_real_fly = find(fly_cut.lon ~= 0);
    fly_cut = fly_cut(idxs_real_fly, :);

    [~, i_fly, i_t] = intersect(fly_cut.time, t);
    idxs_t = i_t(1):i_t(end);
    t = t(idxs_t);
    sg1 = sg1(idxs_t,:);
    sg2 = sg2(idxs_t,:);
    fly_cut = fly_cut(i_fly(1):i_fly(end),:);

    
    T_pan1 = form_sg_table(sg1, t);
    T_pan2 = form_sg_table(sg2, t);
    
end