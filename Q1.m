clear
close all
clc

x = load ('DataN.txt');
t = 1:2000;
x = x(t);
figure
plot(t, x)
title('ECG signal before filtering')
ylabel('Amplitude')   %plotting the raw ECG signal data
print('Before_Filter.jpg','-djpeg')

w = 50/(256/2);
bw = w;
[num, den] = iirnotch(w,bw);
x_notch = filter(num, den, x);
figure
plot (t, x_notch, 'r')
title('ECG signal after notch filtering')
ylabel ('Amplitude')  %plotting filtered ECG
print('After_Notch_Filter.jpg','-djpeg')


ecg_wave = df(x_notch);
figure
plot(t, ecg_wave)
title('ECG signal after diffrentiation')
ylabel ('Amplitude')  %plotting ECG after diff
print('After_Diff.jpg','-djpeg')

ecg_sqrd = ecg_wave.^2;
figure
plot(t, ecg_sqrd, 'r');
title('Squared ECG signal') %squared signal
ylabel ('Amplitude')  %plotting ECG after squaring
print('After_Squaring.jpg','-djpeg')

N = 5;
ecg_smooth = hsmooth(ecg_sqrd, N);
id = peak(ecg_smooth, 0.6*max(ecg_smooth));
figure, hold on
plot(ecg_smooth)
scatter(id, ecg_smooth(id));
hold off
print(sprintf('DetectedR_%d.jpg',N),'-djpeg')

figure,
plot((id*1000)/256);
title('RR');
xlabel('beats number')
ylabel('RR interval');
