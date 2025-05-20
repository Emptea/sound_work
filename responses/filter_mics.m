function filtered = filter_mics(b, T, n_mics)
arguments
    b (:,:) double
    T table
    n_mics double = 28
end
filtered = zeros(size(T,1),n_mics);
for i = 1:n_mics
    filtered(:,i)=filter(b(i,:),1,T{:,i+2});
end