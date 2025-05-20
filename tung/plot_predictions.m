function plot_predictions(workdir,fs,internal_overlapping, threshold)
    [filecoords, pathcoords] = uigetfile({'*.csv'}, ...
        'Select a pan coords file', workdir); 
    [filearray, patharray] = uigetfile({'*.mat'}, ...
        'Select a array file', workdir);
    [fileuav, pathuav] = uigetfile({'fly*.mat'}, ...
        'Select a uav file', workdir);
    
    filepatharray = fullfile(patharray, filearray);
    filepathuav = fullfile(pathuav, fileuav);
    [pan_data_t, uav_data_t] = read_flight(filepatharray,filepathuav);
    
    uav_coord = extrap_uav_coord(uav_data_t, pan_data_t);
    
    clear pan_data_t uav_data_t

    classificator = read_json(workdir);
    mclassificator = extrapolate_predictions(fs, internal_overlapping, classificator);
    
    colors = [0 0 0;       % black
              1 0 0;       % red
              0 0 1;       % blue
              0 1 0];      % green
    fig = figure;
    gx = geoaxes;
    plot_pan_coords(pathcoords);
    hold on;
    geoplot(uav_coord.lat, uav_coord.lon)
    for color_idx = 1:size(mclassificator.probability,2)
        idx = find(mclassificator.probability(:,color_idx) > threshold);
        if ~isempty(idx)
            geoplot(uav_coord.lat, uav_coord.lon, ...
                 'MarkerIndices', idx, ...
                 'Marker', '.', ...
                 'MarkerEdgeColor', colors(color_idx,:), ...
                 'MarkerFaceColor', colors(color_idx,:));
        end
    end
    gx.ZoomLevel = gx.ZoomLevel-1;
end