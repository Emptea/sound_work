Fs = 16000;

figure
subplot(2,1,1)
[p,f] = pspectrum(mavic(:,1));
plot(f/pi*Fs/2,pow2db(p),'LineWidth',1.5)
title("СПМ акустического портрета Мавик")
xlabel("f, [Гц]")
ylabel("СПМ, [дБ]")
grid minor

subplot(2,1,2)
[p,f] = pspectrum(phantom(:,1));
plot(f/pi*Fs/2,pow2db(p),'LineWidth',1.5)
title("СПМ акустического портрета Фантом")
xlabel("f, [Гц]")
ylabel("СПМ, [дБ]")
grid minor