path = './08102024_flies/1_linear_h50m/';
mats = get_path(path, '*pan*.mat');

for i = 2:length(mats)
    load(mats(i))
    try
        T = T_pan1;
    end

    try
        T = T_pan2;
    end

    try
        if contains(mats(i), 'pan1')
            T = T_master;
        elseif  contains(mats(i), 'pan2')
            T = T_slave;
        end
    end

    try
        T = T_all;
    end
    
    T.Time.Format = "HH:mm:ss.SSS";
    writetable(T, erase(mats(i),'.mat')+'.csv')
    clearvars -except mats path
end