clear
close all
clc

x = load ('Data2.txt');
t = 1:2000;
x = x(t);
w = 50/(256/2);
bw = w;
[num, den] = iirnotch(w,bw);
x_notch = filter(num, den, x);
ecg_wave = df(x_notch);
ecg_sqrd = ecg_wave.^2;

N = 25;
ecg_smooth = hsmooth(ecg_sqrd, N);
id = peak(ecg_smooth, 0.6*max(ecg_smooth));
figure, hold on
plot(ecg_smooth)
title('Missing beats in the first 2000 sample');
scatter(id, ecg_smooth(id));
hold off
