function fly = importKML(filename)
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ";";

% Specify column names and types
opts.VariableNames = ["date", "time", "lon", "lat", "height"];
opts.VariableTypes = ["datetime", "datetime", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "date", "InputFormat", "yyyy-MM-dd");
opts = setvaropts(opts, "time", "InputFormat", "HH:mm:ss");

% Import the data
T = readtable(filename, opts);

fly = T(:, 2:5);
fly.time = T.date + timeofday(T.time);
fly.time.Format = 'HH:mm:ss.SSS';

%% Clear temporary variables
clear opts