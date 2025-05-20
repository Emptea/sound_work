function [T_pan] = find_noise(filepath, filename, fly)
arguments
    filepath string
    filename string
    fly (:, 4) table
end 
    [sg, t] = read_sg(filepath, filename);
    
    i_t = find(t >= fly.time(1), 1) - 1;
    idxs = 1:i_t;
    if (i_t == 0)
        i_t = find(t > fly.time(end), 1);
        idxs = i_t:length(t);
    end
    sg = sg(idxs, :);
    t = t(idxs);
    
    T_pan = form_sg_table(sg, t);
end