root = './08102024_flies/';
load(strcat(root,'match_table.mat'));

% save_names = ["1000m_r2l", "1000m_l2r",  ...
%             "750m_r2l", "750m_l2r", ...
%             "500m_r2l", "500m_l2r", ...
%             "300m_r2l", "300m_l2r", ...
%             "150m_r2l", "150m_l2r", ...
%             "noise"];
% save_names = strcat("orth_", save_names);
save_names = match_table.folder;
save_names(5) = "3_P-form-300m";
for i = 9:9
    pth = strcat(root, match_table.folder(i), '/'); 
    load(strcat(root, match_table.fly(i)))
    fly_main = fly;

    list1 = string(ls(strcat(pth, 'PAN_1/*.e67'))); % list of files in folder with a lot of sgs per track
    if (match_table.folder(i) == "phantom")
        list1 = list1(2:end);
    end
    
    list2 = string(ls(strcat(pth, 'PAN_2/*.e67')));
    for k = 1:length(list1)
        try
            [T_pan1, T_pan2, fly, k] = find_track(k, pth, fly_main, list1, list2);
    
            save(strcat(pth, save_names(i), '_pan1_', string(k)), "T_pan1", "-v7.3");
            audiowrite(strcat(pth, save_names(i), '_pan1_', string(k), '_39.wav'),T_pan1.Signal_39,16e3);
            audiowrite(strcat(pth, save_names(i), '_pan1_', string(k), '_sum.wav'),T_pan1.Signal_sum,16e3);
    
            save(strcat(pth, save_names(i), '_pan2_', string(k)), "T_pan2", "-v7.3");
            audiowrite(strcat(pth, save_names(i), '_pan2_', string(k), '_39.wav'),T_pan2.Signal_39,16e3);
            audiowrite(strcat(pth, save_names(i), '_pan2_', string(k), '_sum.wav'),T_pan2.Signal_sum,16e3);
        
            save(strcat(pth, "fly_", save_names(i), '_', string(k)), "fly", "-v7.3");
        end
    end
end

