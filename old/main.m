files = string(ls('*.csv'));

for i = 1:length(files)
    fly = importfile(files(i));
    fly.time = datetime(fly.time, InputFormat='hh:mm:ss.SSS aa', Format='hh:mm:ss.SSS');
    filename = sprintf("fly_mini%02d", i);
    save(filename, "fly");    
end