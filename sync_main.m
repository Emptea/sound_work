filepath = "F:\work\sound_work\11042025 istok\";
filename = "phantom_02";
load(filepath+"pan1_"+filename+".mat")
T1 = T;
load(filepath+"pan2_"+filename+".mat")
T2 = T;
clear T

T1.Time= T1.Time + (times.start_drone(2) - times.start_pan_left(2));
%%
% sync1_straight = unwrap_int16(T1.Signal_synch,4);
% sync2_straight = unwrap_int16(T2.Signal_synch,1);
sync1_straight = unwrap_int16(refch_sync,4);
sync2_straight = unwrap_int16(refch2_sync,1);
to_cal = find(diff(sync2_straight) ~= 16);

diff_sync2 = diff(sync2_straight);
delta_t2 = seconds(4*double(diff_sync2(to_cal))/16e3/16);

% time2 = T2.Time- (T2.Time(1)-T1.Time(1));
time2 = t2 - (t2(1)-t(1));
indices = (to_cal+1)*4;
for i = 1:numel(indices)
    time2(indices(i):end) = time2(indices(i):end) + delta_t2(i);
end

% T2.Time = time2;

