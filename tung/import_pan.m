function [pan_loc_l, pan_loc_r, ref_point] = import_pan(filename)
    opts = detectImportOptions(filename);
    opts.VariableNames = ["lat", "lon","angle","name"];
    coords = readtable(filename,opts);
    pan_loc_l = [coords.lat(1) coords.lon(1) 0];
    pan_loc_r = [coords.lat(2) coords.lon(2) 0];
    ref_point = [calculate_angle(pan_loc_l(1), pan_loc_l(2), coords.angle(1), 100)];
end