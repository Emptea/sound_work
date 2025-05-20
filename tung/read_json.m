function val = read_json(work_dir)
    %% Чтение параметров файлы(расположение, имя файла) выбранного файла
    [fname,location] = uigetfile(work_dir+"*.json");
    if isequal(fname,0)
       disp('Отмена операции');
    else
       disp(['Выбран файл: ', fullfile(location,fname)]);
    end
    %%
    fid = fopen(fullfile(location,fname)); 
    raw = fread(fid,inf); 
    str = char(raw'); 
    fclose(fid); 
    val = jsondecode(str);
end