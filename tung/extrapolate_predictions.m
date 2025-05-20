function mclassificator = extrapolate_predictions(fs, internal_overlapping, classificator)

predictions = classificator.predictions;
values = string(struct2cell(classificator.mapping));
predictions_num = zeros(size(predictions));
predictions_num = num2cell(predictions_num);
for i = 1:length(values)
    predictions_num(predictions == values(i)) = num2cell(i);
end
predictions = cell2mat(predictions_num);
predictions = repelem(predictions,ceil(fs*(1-internal_overlapping)));
mclassificator.predictions = predictions;

probability = classificator.probability;
probability = repelem(probability,ceil(fs*(1-internal_overlapping)),1);
mclassificator.probability = probability;
end