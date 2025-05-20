path = "F:\work\sound_work\23042025 orevo\";
files = string(ls("F:\work\sound_work\23042025 orevo\Logs\fly_*.mat"))

for i = 2:length(files)
    load("F:\work\sound_work\23042025 orevo\Logs\" + files(i))
    start_time = fly.time(1);
    end_time = fly.time(end);
    name = erase(files(i), "fly");
    
    start_idx = find(T1.Time >= start_time,1);
    end_idx = find(T1.Time >= end_time,1);
    T = T1(start_idx:end_idx,:);
    
    sg = T1.Signal_11(start_idx:end_idx);
    audiowrite(path+ "test1.wav", sg,16e3)

    save(path + "pan1"+ name,"T","-v7.3")

    start_idx = find(T2.Time >= start_time,1);
    end_idx = find(T2.Time >= end_time,1);
    T = T2(start_idx:end_idx,:);
    sg = T2.Signal_11(start_idx:end_idx);
    audiowrite(path+ "test2.wav", sg,16e3)

    save(path + "pan2"+ name,"T","-v7.3")

    start_idx = find(T_tetr.Time >= start_time-bias_for_tetr,1);
    end_idx = find(T_tetr.Time >= end_time-bias_for_tetr,1);
    T = T_tetr(start_idx:end_idx,:);
    T.Time = T.Time+bias_for_tetr;
    sg = T_tetr.Signal_1(start_idx:end_idx);
    audiowrite(path+ "test_tetr.wav", sg,48e3)
    save(path + "mic4"+ name,"T","-v7.3")
end