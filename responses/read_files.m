clear
filename = "2009.07.30-18-31-45+0000-008-9999-9999";

data = [];
for i = 0:66
    file_tmp = sprintf("%s\\elf%02d.wav", filename, i);
    data_tmp = importdata(file_tmp).data;
    data = [data data_tmp];
end

save(filename + ".mat", 'data', '-v7.3')