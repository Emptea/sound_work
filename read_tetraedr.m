function [sgs,fs] = read_tetraedr(folder, common_name)

filename = folder+"/01-"+common_name +".wav";
[s1,fs] = audioread(filename);
disp("Read file: " + filename)
sgs = zeros(length(s1),4);
sgs(:,1) = s1;
clear s1
for i = 2:4
    filename = folder + "/0" + string(i) + "-" + common_name + ".wav";
    sgs(:,i) = audioread(filename);
    disp("Read file: " + filename)
end

end