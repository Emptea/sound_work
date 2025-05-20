function result = sliding_statistics(vec1, vec2, window_size, threshold)

  if length(vec1) ~= length(vec2)
    error('Векторы должны быть одинаковой длины');
  end

  result = zeros(length(vec1), 1);

  for i = 1:length(vec1)
    start_index = max(1, i - window_size + 1);
    end_index = min(length(vec1), i);

    if nnz(vec1(start_index:end_index)) >= threshold/100*window_size ...
            || ...
            nnz(vec2(start_index:end_index)) >= threshold/100*window_size
      result(i) = 1;
    end
  end
end