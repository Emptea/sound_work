root = './29102024_flies/';
list = string(ls(strcat(root, 'Oct-29th-2024-1*.csv')));
%pattern = '0\d{1}-\d{2}';
pattern = '1\d{1}-\d{2}-\d{2}';
f_times = string(regexp(string(list), pattern, 'match'));
format = '*.csv';

for i = 1:size(list,1)
    filename = strcat(root, list(i,:));
    save_name  = strcat(root, 'fly_', f_times(i));
    %fly = importDJI(filename);
    fly = importFlightAirdata(filename);
    save(save_name, "fly", "-v7.3");
end