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