for i = 4:80
f = i*100;
t=1/44100:1/44100:0.01;
x=sin(2*pi*t*f);
z=zeros(1,44000);
x = [x z];
x = [x x];
soundsc(x,44100);
pause(3);
disp(f);
end