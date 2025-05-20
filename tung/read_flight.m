function [pan_data, uav_data] = read_flight(patharray, pathuav)
% Загрузка данных из *.mat файла и преобразование их в структуру данных 
    %% Загрузка сигнала
    pan_raw = load(patharray);
    fields = fieldnames(pan_raw);  
    T = pan_raw.(char(fields));
    pan_data = table2timetable(T,"RowTimes",'Time');    
    %% Загрузка трека
    uav_raw = load(pathuav);
    fields = fieldnames(uav_raw);  
    T = uav_raw.(char(fields));
    uav_data = table2timetable(T,"RowTimes",'time');
end