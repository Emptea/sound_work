function pth = get_path(fldr, ext)
% Get a list of all .mat files in the script folder and its subfolders
files = dir(fullfile(fldr, '**', ext));

% Initialize a cell array to store relative paths
pth = cell(1, numel(files));

% Loop through each file and convert its absolute path to a relative path
for k = 1:numel(files)
    % Get the full path to the .mat file
    full_pth = fullfile(files(k).folder, files(k).name);
    pth{k} = full_pth;
end
pth = string(pth)';