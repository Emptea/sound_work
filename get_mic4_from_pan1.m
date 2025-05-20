path = "F:\work\sound_work\23042025 orevo\";
files = string(ls(path+"pan1_*.mat"))

for i = 3:length(files)
    load(path+files(i))
    T1 = T;
    start_idx = find(T_tetr.Time >= T1.Time(1),1);
    end_idx = find(T_tetr.Time >= T1.Time(end),1);
    T = T_tetr(start_idx:end_idx,:);
    name = erase(files(i), "pan1");

    sg = T.Signal_1;
    audiowrite(path+ "test.wav", sg,48e3)
    sg_ref = T1.Signal_11;
    audiowrite(path+ "ref.wav", sg_op,16e3)
    
    save(path + "mic4" + name,"T","-v7.3")
end