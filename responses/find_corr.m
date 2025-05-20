function corr_vec = find_corr(data) 
sum_mtx = zeros(size(data));
sum_mtx(:,1) = sum(data(:, 2:size(data,2)), 2);
for n = 2:size(data,2)
    sum_mtx(:,n) = sum(data(:, [1:n n:size(data,2)]), 2);
end
corr_mtx = corr(data, sum_mtx);
corr_vec = sum(corr_mtx, 2);
% plot(corr_mtx)

% corr_vec = zeros(size(data,1), 1);
% corr_vec(1) = corr(data(:,1), sum(data(:, 2:size(data,2)), 2));
% for n = 2:size(data,2)
%     corr_vec(n) = corr(data(:,n), sum(data(:, [1:(n-1) (n+1):size(data,2)]), 2));
% end
% plot(corr_vec)
