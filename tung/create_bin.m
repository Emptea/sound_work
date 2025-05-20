% clear variables
signal2double = @(signal) double(signal) / double(intmax("int16")); 

%% 
workdir = "D:\Sber\sounds\"; 
[files, path] = uigetfile({'*.mat';}, ...
    'Select a files', workdir, 'MultiSelect', 'on');

if ~iscell(files)
    if ~files
        return
    end
    files = {files};
end
if isempty(files)
    return
end

%%
fs = 16000;
gain = 4;
filetype = ".bin"; 

parentdir = split(path, filesep);
save_path = fullfile(workdir, "files", "bin", parentdir{end-1});
mkdir(save_path); 

%%
for f = 1:length(files)
    filepath = fullfile(path, files{f});
    [filefolder, filename, ~] = fileparts(filepath);
    fid = fopen(fullfile(save_path, strcat(filename, filetype)), 'w');

    data = load(filepath);
    data = table2timetable(data.T,"RowTimes",'Time');
    
    data = table2array(data);
    data = data';

    fwrite(fid,data,'int16');
    fclose(fid);
end
