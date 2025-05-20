flynames = ["phantom_01", "phantom_02", "matrice", "mini3pro"];
filepath = "F:\work\sound_work\11042025 istok\";

for i = 1:length(flynames)
    times = readtable(filepath+"cuts_" + flynames(i) + ".csv");
    load(filepath+"fly_"+flynames(i))
    fly_old = fly;
    % load(filepath+"pan1_"+flynames(i))
    % T1 = T;
    % load(filepath+"pan2_"+flynames(i))
    % T2 = T;
    load(filepath+"mic4\mic4_"+flynames(i))
    T_mic = T;
    clear T
    for j = 1:length(times.name)
        start_time = fly_old.time(1)+times.t_start(j);
        end_time = fly_old.time(1)+times.t_end(j);
        % T = T1(T1.Time > start_time & T1.Time < end_time,:);
        % save(filepath + "\cuts\pan1_" + flynames(i) + "_" + times.name(j),"T","-v7.3")
        % T = T2(T2.Time > start_time & T2.Time < end_time,:);
        % save(filepath + "\cuts\pan2_" + flynames(i) + "_" + times.name(j),"T","-v7.3")
        T = T_mic(T_mic.Time > start_time & T_mic.Time < end_time,:);
        save(filepath + "\cuts\mic4_" + flynames(i) + "_" + times.name(j),"T","-v7.3")
        fly = fly_old(fly_old.time >= start_time & fly_old.time <= end_time, :);
        save(filepath + "\cuts\fly_" + flynames(i) + "_" + times.name(j),"fly","-v7.3")
    end
end

