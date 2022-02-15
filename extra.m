%%
% This file contains test codes. 
% The test codes moved here in order to clean the main code.
% The file cannot be executed. 

%%
resting_post_plot_filtered = bandpass(resting_post_plot, [bandpass_low_fc, bandpass_high_fc], fs);

figure('Name', 'After bandpass')
plot(resting_post_plot_filtered)
%%
[b,a] = butter(4, bandpass_low_fc/(fs/2), 'high');
data_filtered = filtfilt(b, a, resting_post_plot);

[b,a] = butter(4, bandpass_high_fc/(fs/2), 'low');
data_filtered = filtfilt(b, a, data_filtered);

figure('Name', 'After filtfilt')
plot(data_filtered)


%%
% See difference between FFT and pwelch:
%Fs = 80;
%t = 0:1/Fs:1-1/Fs;
% Test simple FFT with simple function
%x = cos(2*pi*100*t)+randn(size(t));
%plot(psd(spectrum.periodogram, EEG_pre.data', 'Fs', 80, 'NFFT', length(EEG_pre.data')));