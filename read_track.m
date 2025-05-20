clear;

path_src = "../fly_raw/";
path_dst = "../traj/";
target_name = "phantom";

files = string(ls(path_src + "*.csv"));

for i = 1:length(files)
    filename = path_src + files(i);
    fly = importFlightAirdata(filename);
    filename = sprintf("fly_%s%02d", target_name, i);
    save(path_dst + filename, "fly"); 
end