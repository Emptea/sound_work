function T = form_sg_table(sg, t)

sg = num2cell(sg,1);
varNames = arrayfun(@(x) sprintf('Signal_%d', x), 1:66, 'UniformOutput', false);

T = table(t', sg{:}, 'VariableNames', ['Time', 'Signal_sum' varNames]);
T.Time.Format = 'HH:mm:ss.SSS';
end