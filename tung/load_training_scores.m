% clear variables

%%
columns = {'Loss';'Acc';};
nn_type = {};
feature_dataset = {};
feature_duration = {};
feature_overlapping = {};
feature_type = {};
feature_size = {};
n_fft = {};
hop_length = {};
configuration = {};
Accuracy = [];
Loss = [];

folderpath = "D:\Sber\Acoustic-UAV-Identification-main\model";
folder = uigetdir(folderpath);
if ~folder
    return
end

allSubFolders = genpath(folder);

listOfFolderNames = split(allSubFolders, ';');
listOfFolderNames(~cellfun('isempty',listOfFolderNames));

for k = 1:length(listOfFolderNames)
    thisFolder = listOfFolderNames{k};
    fprintf('Processing folder %s\n', thisFolder);
    
    filePattern = sprintf('%s/*-accuracy.json', thisFolder);
    baseFileNames = dir(filePattern);
    numberOfFiles = length(baseFileNames);
   
    if numberOfFiles >= 1
        for f = 1:numberOfFiles
            filename = baseFileNames(f).name;
            filepath = fullfile(thisFolder, filename);
            fprintf('Processing text file %s\n', filename);
            
            json_str = fileread(filepath);
            json_data = jsondecode(json_str);
            json_data = struct2cell(json_data);
            
            [acc, loss] = json_data{:};
            
            filename = split(filename, ".json");
            filename = filename{1};
            description = split(thisFolder,"\");
            feature_parts = split(filename,"-");
            
            nn_type = [nn_type; feature_parts{1}];
            feature_dataset = [feature_dataset; feature_parts{2}];
            feature_duration = [feature_duration; str2num(feature_parts{3})];
            feature_overlapping = [feature_overlapping; str2num(feature_parts{4})];
            feature_type = [feature_type; feature_parts{5}];
            feature_size = [feature_size; str2num(feature_parts{6})];
            n_fft = [n_fft; str2num(feature_parts{7})];
            hop_length = [hop_length; str2num(feature_parts{8})];
            configuration = [configuration; filename];
            Accuracy = [Accuracy; acc]; 
            Loss = [Loss; loss];
        end
      else
        fprintf('Folder %s has no text files in it.\n', thisFolder);
    end
end
fclose('all');

scores = table(nn_type, ...
    feature_dataset, feature_duration, feature_overlapping, feature_type, ...
    feature_size, n_fft, hop_length, configuration, ...
    Accuracy, Loss);

[path,foldername] = fileparts(folder);
filename = strcat(foldername, '_performance_scores.xlsx');
writetable(scores, fullfile(folder, filename), ...
    'Sheet', 'Scores', 'WriteVariableNames', true)