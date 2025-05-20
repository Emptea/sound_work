function T = form_sg_table(sg, t)

n_chs = size(sg, 2);
sg = num2cell(sg,1);
if n_chs == 67
    varNames = arrayfun(@(x) sprintf('Signal_%d', x), 1:(n_chs-1), 'UniformOutput', false);
    T = table(t', sg{:}, 'VariableNames', ['Time', 'Signal_sum' varNames]);
elseif n_chs == 32
    varNames = arrayfun(@(x) sprintf('Signal_%d', x), 1:(n_chs-2), 'UniformOutput', false);
    sg = [sg(31) sg(1:30) sg(32:end)];
    T = table(t', sg{:}, 'VariableNames', ['Time', 'Signal_sum' varNames 'Signal_synch']);
else
    varNames = arrayfun(@(x) sprintf('Signal_%d', x), 1:n_chs, 'UniformOutput', false);
    T = table(t', sg{:}, 'VariableNames', ['Time', varNames]);
end
T.Time.Format = 'HH:mm:ss.SSS';
end