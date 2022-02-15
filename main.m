%% Clear workspace; variables and close figures
clc;
clear all;
close all;
addpath('C:\Program Files\MATLAB\R2021b\toolbox\eeglab2021.1')
% eeglab;

%% Variables
resting_post = load("resting_post.mat");
resting_pre = load("resting_pre.mat");

num_of_secs = 30;
num_of_channels = 4;

%figure
%plot(resting_post.EEG_import(1:num_of_channels, 1:num_of_secs*resting_post.fs).')

size_ = size(resting_post.EEG_import);
fs = resting_post.fs;
bandpass_low_fc = 1;
bandpass_high_fc = 30;

%% Filtering --> [1-30] Hz

[b,a]= butter(4, [bandpass_low_fc, bandpass_high_fc]/(fs/2), 'bandpass');
filtered_pre = filtfilt(b, a, resting_pre.EEG_import');
filtered_post = filtfilt(b, a, resting_post.EEG_import');

%% Saving filtered data

filtered_pre = filtered_pre';
filtered_post = filtered_post';
save('filtered_pre.mat','filtered_pre')
save('filtered_post.mat','filtered_post')

%% Plot
figure()
subplot(2, 2, 1)
plot(resting_pre.EEG_import(1:num_of_channels, 1:num_of_secs*resting_post.fs).')
title('resting pre')

subplot(2, 2, 2)
plot(resting_post.EEG_import(1:num_of_channels, 1:num_of_secs*resting_post.fs).')
title('resting post')

subplot(2, 2, 3)
plot(filtered_pre(1:num_of_channels, 1:num_of_secs*resting_post.fs).')
title('filtered pre')

subplot(2, 2, 4)
plot(filtered_post(1:num_of_channels, 1:num_of_secs*resting_post.fs).')
title('filtered post')
