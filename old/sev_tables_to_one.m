path = './pan_l/';
sd_files = string(ls(strcat(path,'no_quad_sg_*')));
load(path+sd_files(1))
T_all = T;
for i = 2:length(sd_files)
    load(path+sd_files(i))
    T_all = [T_all; T];
end
save(strcat(path, 'no_quad', '_sg_l_all'), "T_all", "-v7.3");