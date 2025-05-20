filepath = "F:\work\sound_work\21032025_flies\";
filename = "2025-03-21_16-08-33.log";
T = readtable(filepath + filename,'FileType','text', 'TextType','string');

k = regexp(T.Var3, "\[253,\d+,\d+,\d+,\d+,\d+,\d+,33,(.*?)\]", "match");
nonEmptyIndices = find(~cellfun(@isempty, k));
dates_str = string(T.Var1) + " " + T.Var2;
dates = datetime(dates_str(nonEmptyIndices),'InputFormat', "uuuu-MM-dd HH-mm-ss.SSS");

data = regexp(T.Var3(nonEmptyIndices), "\[253,\d+,\d+,\d+,\d+,\d+,\d+,33,0,0," + ...
    "(?<cmd_coord>\d+,\d+,\d+,\d+)," + ...
    "(?<lat>\d+,\d+,\d+,\d+)," + ...
    "(?<lon>\d+,\d+,\d+,\d+)," + ...
    "(?<cmd_height>\d+,\d+,\d+,\d+)," + ...
    "(?<height>\d+,\d+,\d+,\d+)", "names");
nonEmptyIndices = find(~cellfun(@isempty, data));
data = data(nonEmptyIndices);
data = struct2table(vertcat(data{:}));

lat = single(cell2mat(arrayfun(@(str) typecast(uint8(str2double(regexp(str, '\d+', 'match'))), 'uint32'), ...
data.lat, 'UniformOutput', false)))/1e7;
lon = single(cell2mat(arrayfun(@(str) typecast(uint8(str2double(regexp(str, '\d+', 'match'))), 'uint32'), ...
data.lon, 'UniformOutput', false)))/1e7;
height = single(cell2mat(arrayfun(@(str) typecast(uint8(str2double(regexp(str, '\d+', 'match'))), 'int32'), ...
data.height, 'UniformOutput', false)))/1e3;

fly = table(dates(nonEmptyIndices),lat, lon, height, 'VariableNames', {'time', 'lat','lon','height'});
fly.time.Format = "HH:mm:ss.SSS";

idxs = (fly.lat<=55) & (fly.lon >= 35);
fly = fly(idxs,:);

save_name = "fly_diam_03";
save(strcat(filepath, save_name), "fly", "-v7.3");