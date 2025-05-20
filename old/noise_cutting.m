root = './08112024_flies/';
load(strcat(root,'match_table.mat'));

save_names = strcat(match_table.folder, '_noise');
save_names(5) = "3_P-form-300m_noise";
for i = 5:5
    pth = strcat(root, match_table.folder(i), '/');

    list_pan1 = string(ls(strcat(pth, 'PAN_1/*.e67'))); % list of files in folder with a lot of sgs per track
    list_pan2 = string(ls(strcat(pth, 'PAN_2/*.e67'))); % list of files in folder with a lot of sgs per track
    
    for k = 1:length(list_pan1)
        filename_pan1 = list_pan1(k);
        filepath_pan1 = strcat(pth, 'PAN_1/', filename_pan1);
        
        pos = i;
        try
            if (k>1 && match_table.folder(pos) == match_table.folder(pos+1))
                pos = pos+1;
            end
        end

        try
            load(strcat(root, match_table.fly(pos)))
            [T_pan1] = find_noise(filepath_pan1, filename_pan1, fly);
        catch
            [sg1, t1] = read_sg(filepath_pan1, filename_pan1);
            T_pan1 = form_sg_table(sg1, t1);
        end
        if (~isempty(T_pan1))
            save(strcat(pth, save_names(i), '_pan1_', string(k)), "T_pan1", "-v7.3");
            audiowrite(strcat(pth, save_names(i), '_pan1_', string(k), '_39.wav'),T_pan1.Signal_39,16e3);
            audiowrite(strcat(pth, save_names(i), '_pan1_', string(k), '_sum.wav'),T_pan1.Signal_sum,16e3);
        end
    end

    for k = 1:length(list_pan2)
        filename_pan2 = list_pan2(k);
        filepath_pan2 = strcat(pth, 'PAN_2/', filename_pan2);
        
        try
            if (k>1 && match_table.folder(i) == match_table.folder(i+1))
                i = i+1;
            end
        end 

        try
            load(strcat(root, match_table.fly(i)))
            [T_pan2] = find_noise(filepath_pan2, filename_pan2, fly);
        catch
            [sg2, t2] = read_sg(filepath_pan2, filename_pan2);
            T_pan2= form_sg_table(sg2, t2);
        end
        if (~isempty(T_pan2))
            save(strcat(pth, save_names(i), '_pan2_', string(k)), "T_pan2", "-v7.3");
            audiowrite(strcat(pth, save_names(i), '_pan2_', string(k), '_39.wav'),T_pan2.Signal_39,16e3);
            audiowrite(strcat(pth, save_names(i), '_pan2_', string(k), '_sum.wav'),T_pan2.Signal_sum,16e3);
        end
    end
end

 