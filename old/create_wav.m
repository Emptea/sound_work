path = "pan_r/";
files = path + string(ls(path +"*.e67"));
chsum = [];
for i = 1:length(files)
    data = read_raw(files(i), 0);    
    chsum = [chsum; data(:, 1)];
    disp(i);
    disp(files(i))
end

audiowrite(path + "pan_r_chsum.wav", chsum, 16000)
