root = pwd +"\20112024_flies\";
ext = "*.e32";

% pth_master = root + "master\";
% pth_slave = root + "slave\";

files_fly = get_path(root, 'fly*.mat');
files_pan1 = get_path(pth_master, '*.e*');
files_pan2 = get_path(pth_slave, '*.e*');

fldrs = ["полет 1"; ...
    "полет 2"; ...
    "полет 3"];

% t_gtc_bias = seconds([24.338-0.191;...
%     24.338-0.819; ...
%     24.338-0.119]);
% 
% t_bias_slave = [seconds(679692/16e3); ...
%     seconds(683760/16e3); ...
%     seconds((679692+12000+1611+73)/16e3);];

t_gtc = seconds(30.031);
t_slave = seconds(52)+seconds(0.4261)-seconds(0.0018);

for i = 1:3
    load(files_fly(i));

    pth_master = root + fldrs(i) + "\master\";
    pth_slave = root + fldrs(i) + "\slave\";

    [t_start_master, t_end_master] = find_boundaries(root + fldrs(i)+ "\master\");
    t_start_master = t_start_master  - utc_plus;
    t_end_master = t_end_master  - utc_plus;
    [t_start_slave, t_end_slave] = find_boundaries(root + fldrs(i)+ "\slave\");
    t_start_slave = t_start_slave - (utc_plus - t_slave) + seconds(1);
    t_end_slave = t_end_slave  - (utc_plus - t_slave) + seconds(1);
    t_end = fly.time(1) + t_gtc;
    t_start = fly.time(end) + t_gtc + seconds(3.5);
    % 
    % if i < 12
    %     t_gtc = t_gtc_bias(1);
    %     t_slave = t_bias_slave(1);
    % elseif i < 22
    %     t_gtc = t_gtc_bias(2);
    %     t_slave = t_bias_slave(2);
    % else
    %     t_gtc = t_gtc_bias(3);
    %     t_slave = t_bias_slave(3);
    % end
    % 
    % idx = i - 8;
    idx = [2,4,6];
    save_name_pan1 = sprintf('pan1_quiet_%02d.mat', idx(i));
    utc_plus = hours(3);
    T_master = find_sg(t_start, t_end_master, pth_master, ext, utc_plus);
    if (~isempty(T_master))
        save(root + save_name_pan1, "T_master", "-v7.3");
        audiowrite(root + save_name_pan1 + ".wav",T_master.Signal_14,16e3);
    end
    
    save_name_pan2 = sprintf('pan2_quiet_%02d.mat', idx(i));
    T_slave = find_sg(t_start, t_end_slave, pth_slave, ext, utc_plus - t_slave);
    if (~isempty(T_slave))
        save(root + save_name_pan2, "T_slave", "-v7.3");
        audiowrite(root + save_name_pan2 + ".wav",T_slave.Signal_14,16e3);
    end
end

 