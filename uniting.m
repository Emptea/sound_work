i = 3;
filepath = ".\21032025_flies\cuts\"+"0"+string(i)+"\";
files_fly = string(ls(filepath+"\fly_diam_0"+string(i)+"_cut_forward*.mat"));
files_left = string(ls(filepath+"\diam_left_0"+string(i)+"_cut_forward*.mat"));
files_right = string(ls(filepath+"\diam_right_0"+string(i)+"_cut_forward*.mat"));
files_mic = string(ls(filepath+"\diam_mic4_0"+string(i)+"_cut_forward*.mat"));

load(filepath + files_fly(1))
fly_unite = fly;
load(filepath + files_left(1))
T_left = T;
load(filepath + files_right(1))
T_right = T;
load(filepath + files_mic(1))
T_mic = T;
for k = 3
    load(filepath + files_fly(k))
    fly_unite = [fly_unite; fly];
    % load(filepath + files_left(k))
    % T_left = [T_left; T];
    % load(filepath + files_right(k))
    % T_right = [T_right; T];
    % load(filepath + files_mic(k))
    % T_mic = [T_mic; T];
end
savename = "_0" + string(i) + "_forward_study";
fly = fly_unite;
save(".\21032025_flies\fly_diam" + savename, "fly")
% T = T_left;
% save(".\21032025_flies\diam_left" + savename, "T","-v7.3")
% T = T_right;
% save(".\21032025_flies\diam_right" + savename, "T","-v7.3")
% T = T_mic;
% save(".\21032025_flies\diam_mic" + savename, "T","-v7.3")
% 
% k = length(files_fly)-1;
% load(filepath + files_fly(k))
% savename = "_0" + string(i) + "_forward_verif";
% save(".\21032025_flies\fly_diam" + savename, "fly")
% load(filepath + files_left(k))
% save(".\21032025_flies\diam_left" + savename, "T","-v7.3")
% load(filepath + files_right(k))
% save(".\21032025_flies\diam_right" + savename, "T","-v7.3")
% load(filepath + files_mic(k))
% save(".\21032025_flies\diam_mic" + savename, "T","-v7.3")
