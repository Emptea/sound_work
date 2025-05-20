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
filetype = ".wav"; 

parentdir = split(path, filesep);
save_path = fullfile(workdir, "files", "sum_gain" + num2str(gain), parentdir{end-1});
mkdir(save_path); 

%%
for f = 1:length(files)
    filepath = fullfile(path, files{f});
    data = load(filepath);
    data = table2timetable(data.T_slave,"RowTimes",'Time');
    
%     data = removevars(data,{'Signal_sum'});
    
    %% new mics
    data = removevars(data,{'Signal_sum','Signal_29','Signal_30','Signal_synch'});

    %% only_odd
%     data = removevars(data,{ ...
%         'Signal_1', 'Signal_3', 'Signal_5', 'Signal_7', 'Signal_9', 'Signal_11',...
%         'Signal_12', 'Signal_14', 'Signal_16', 'Signal_18', 'Signal_20', 'Signal_22', ...
%         'Signal_23', 'Signal_25', 'Signal_27', 'Signal_29', 'Signal_31', 'Signal_33', ...
%         'Signal_34', 'Signal_36', 'Signal_38', 'Signal_40', 'Signal_42', 'Signal_44', ...
%         'Signal_45', 'Signal_47', 'Signal_49', 'Signal_51', 'Signal_53', 'Signal_55', ...
%         'Signal_56', 'Signal_58', 'Signal_60', 'Signal_62', 'Signal_64', 'Signal_66',});
    %% only_cross
%     data = removevars(data,{ ...
%         'Signal_1','Signal_2','Signal_3','Signal_4','Signal_5','Signal_7','Signal_8','Signal_9','Signal_10','Signal_11', ...
%         'Signal_12','Signal_13','Signal_14','Signal_15','Signal_16','Signal_18','Signal_19','Signal_20','Signal_21','Signal_22', ...
%         'Signal_23', 'Signal_25', 'Signal_27', 'Signal_29', 'Signal_31', 'Signal_33', ...
%         'Signal_34', 'Signal_36', 'Signal_38', 'Signal_40', 'Signal_42', 'Signal_44', ...
%         'Signal_45','Signal_46','Signal_47','Signal_48','Signal_49','Signal_51','Signal_52','Signal_53','Signal_54','Signal_55', ...
%         'Signal_56','Signal_57','Signal_58','Signal_59','Signal_60','Signal_62','Signal_63','Signal_64','Signal_65','Signal_66'});
    
    %% only_central
%     data = data(:, 'Signal_39');


%%
    channels_size = size(data, 2);
    
    data = table2array(data);
    data = signal2double(data);
        
    data = sum(data, 2);
    data = gain * data ./ channels_size;
    
    [filefolder, filename, ~] = fileparts(filepath);
    
    audiowrite(fullfile(save_path, strcat(filename, filetype)), data, fs);
end
