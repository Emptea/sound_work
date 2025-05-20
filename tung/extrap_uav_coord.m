function T = extrap_uav_coord(uav, pan, opt)
arguments
    uav timetable
    pan timetable
    opt.plt {mustBeMember(opt.plt,{'true','false'})} = 'false'
end
    sz_pan = length(pan.Time); % размерность таблицы pan
    sz_uav = length(uav.time); % размерность таблицы uav
    
    x = 1:sz_uav; % исходный диапазон
    xq = linspace(1,sz_uav, sz_pan); % требуемый диапазон

    % Интерполирование широты
    v = uav.lat; % целевые значения широты
    vq_lat = interp1(x,v,xq); % интерполированные значения широты

    % Интерполирование долготы 
    v = uav.lon; % целевые значения долготы
    vq_lon = interp1(x,v,xq); % интерполированные значения долготы
    
    % Интерполирование высоты 
    v = uav.height; % целевые значения высоты
    vq_h = interp1(x,v,xq); % интерполированные значения высоты    
    
    % Формирование интерполированной таблицы с коордантами uav
    T = timetable(pan.Time,vq_lat(:),vq_lon(:),vq_h(:));
    % var_names = uav.Properties.VariableNames; % названия столбцов таблицы uav
    var_names = {'lat','lon','height'};
    T.Properties.VariableNames  = var_names; % названия столбцов новой таблицы

    % Построение исходной таблицы и расширенной таблицы с координатами uav 
    switch opt.plt
        case 'true'   
            tiledlayout(2,3)
            nexttile
            plot(uav.time,uav.lat,'-','LineWidth',1.5); grid on; title('UAV latitude')
            xlabel('Time'); ylabel('latitude'); 
            nexttile

            plot(uav.time,uav.lon,'-','LineWidth',1.5); grid on; title('UAV longitude')
            xlabel('Time'); ylabel('longitude'); 

            nexttile
            plot(uav.time,uav.height,'-','LineWidth',1.5); grid on; title('UAV height')
            xlabel('Time'); ylabel('height'); 

            nexttile
            plot(T.Time,T.lat,'-','LineWidth',1.5); grid on; title('UAV extended latitude')
            xlabel('Time'); ylabel('latitude'); 

            nexttile
            plot(T.Time,T.lon,'-','LineWidth',1.5); grid on; title('UAV extended longitude')
            xlabel('Time'); ylabel('longitude'); 

            nexttile
            plot(T.Time,T.height,'-','LineWidth',1.5); grid on; title('UAV extended height')
            xlabel('Time'); ylabel('height'); 

            set(gcf,'units','normalized','outerposition',[0 0 1 1])
        case 'false'
            return
        otherwise
            return
    end
end