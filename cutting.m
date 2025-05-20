files = string(ls(".\21032025_flies\cuts\03\fly_diam_03_cut*.mat"));
load('G:\sound_work\21032025_flies\diam_right_03.mat')
T_right = T;
load('G:\sound_work\21032025_flies\diam_left_03.mat')
T_left = T;
load('G:\sound_work\21032025_flies\diam_mic4_03.mat')
T_mic = T;
for i = 1:length(files)
    load(".\21032025_flies\cuts\03\" + files(i))
    savename = erase(files(i), "fly_diam");
    cut_sg_from_fly(T_right,fly,".\21032025_flies\cuts\03\diam_right"+savename)
    cut_sg_from_fly(T_left,fly,".\21032025_flies\cuts\03\diam_left"+savename)
    cut_sg_from_fly(T_mic,fly,".\21032025_flies\cuts\03\diam_mic4"+savename)
end