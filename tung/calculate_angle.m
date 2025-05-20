function new_coordinates = calculate_angle(latitude, longitude, angle, distance)
    % Радиус Земли (в метрах)
    R = 6371000; 

    % Преобразование угла из градусов в радианы
    angle_rad = deg2rad(angle);

    % Преобразование широты и долготы из градусов в радианы
    lat_rad = deg2rad(latitude);
    lon_rad = deg2rad(longitude);

    % Вычисление новых координат
    new_latitude_rad = asin(sin(lat_rad) * cos(distance / R) + ...
                            cos(lat_rad) * sin(distance / R) * cos(angle_rad));

    new_longitude_rad = lon_rad + atan2(sin(angle_rad) * sin(distance / R) * cos(lat_rad), ...
                                         cos(distance / R) - sin(lat_rad) * sin(new_latitude_rad));

    
    new_coordinates = [rad2deg(new_latitude_rad), rad2deg(new_longitude_rad), 0];
end
