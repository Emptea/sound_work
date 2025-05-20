clear variables

%%
columns = {'TP';'FN';'TN';'FP';'Accuracy';'Precision';'Recall';'F1';};
task_name = {};
nn_type = {};
feature_dataset = {};
feature_duration = {};
feature_overlapping = {};
feature_type = {};
feature_size = {};
n_fft = {};
hop_length = {};
configuration = {};
TP = [];
FN = [];
TN = [];
FP = [];
MM = [];
Accuracy = []; 
Precision = [];
Recall = [];
F1 = [];

folderpath = "D:\Sber\Acoustic-UAV-Identification-main\3 - Performance Calculation";
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
    
    filePattern = sprintf('%s/*scores.json', thisFolder);
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
            
            [tp, fn, tn, fp, mm, acc, prec, rec, f1] = json_data{:};
            
            filename = split(filename, "-scores.json");
            filename = filename{1};
            description = split(thisFolder,"\");
            feature_parts = split(filename,"-");
            
            task_name = [task_name; description{end-1}];
            nn_type = [nn_type; feature_parts{1}];
            feature_dataset = [feature_dataset; feature_parts{2}];
            feature_duration = [feature_duration; str2num(feature_parts{3})];
            feature_overlapping = [feature_overlapping; str2num(feature_parts{4})];
            feature_type = [feature_type; feature_parts{5}];
            feature_size = [feature_size; str2num(feature_parts{6})];
            n_fft = [n_fft; str2num(feature_parts{7})];
            hop_length = [hop_length; str2num(feature_parts{8})];
            configuration = [configuration; filename];
            TP = [TP; tp];
            FN = [FN; fn];
            TN = [TN; tn];
            FP = [FP; fp];
            MM = [MM; mm];
            Accuracy = [Accuracy; acc]; 
            Precision = [Precision; prec];
            Recall = [Recall; rec];
            F1 = [F1; f1];
        end
      else
        fprintf('Folder %s has no text files in it.\n', thisFolder);
    end
end
fclose('all');

scores = table(task_name, nn_type, ...
    feature_dataset, feature_duration, feature_overlapping, feature_type, ...
    feature_size, n_fft, hop_length, configuration, ...
    TP, FN, TN, FP, MM, ...
    Accuracy, Precision, Recall, F1);

[path,foldername] = fileparts(folder);
filename = strcat(foldername, '_performance_scores.xlsx');
writetable(scores, fullfile(folder, filename), ...
    'Sheet', 'Scores', 'WriteVariableNames', true)