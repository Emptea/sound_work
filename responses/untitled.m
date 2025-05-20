ref_ch = 1;
xc = xcorr(data(:,ref_ch),data(:,ref_ch));
plot(xc(end/2-10:end/2+10));
hold on
for i = 2:67
    xc = xcorr(data(:,ref_ch),data(:,i));
    plot(xc(end/2-10:end/2+10));
end
hold off