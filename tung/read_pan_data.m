function data = read_pan_data(filepath)
% Загрузка данных из *.mat файла и преобразование их в структуру данных 
    %% Загрузка сигнала
    data = load(filepath);
    fields = fieldnames(data); 
    T = data.(char(fields));
    data = table2timetable(T,"RowTimes",'Time');  
end