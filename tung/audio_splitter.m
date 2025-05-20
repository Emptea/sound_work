clear variables 

%%
workdir = 'D:\Work\Sber\Sounds\'; 
[files, path] = uigetfile({'*.wav';'*.flac'}, ...
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
frame_duration = 0.5;
fs = 16000;
samples_per_frame = fs*frame_duration;

parentdir = split(path, filesep);
save_folder = fullfile(parentdir{end-2}, parentdir{end-1}, ...
    strcat('splitted_', num2str(frame_duration), '_s'));
save_path = fullfile(workdir, save_folder);
mkdir(save_path);

%%
for f = 1:length(files)
    filepath = fullfile(path, files{f}); 
    [filefolder, filename, extension] = fileparts(filepath);
    mkdir(fullfile(save_path, filename));

    [audio, fs] = audioread(filepath);
    
    last_idx = floor(length(audio)/(samples_per_frame)) * samples_per_frame;           
    audio = reshape(audio(1:last_idx, 1), samples_per_frame,[]);
    total_frames = size(audio, 2);
    
    for i=1:total_frames
        frame_name = strcat('custom_', filename, '_', sprintf('%04d', i), extension);
        audiowrite(fullfile(save_path, filename, frame_name), audio(:,i), fs);
    end
end

