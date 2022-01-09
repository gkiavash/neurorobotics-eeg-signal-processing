clear all;
addpath('C:\Program Files\MATLAB\R2021b\toolbox\eeglab2021.1')
eeglab;

resting_post = load("resting_post.mat");
resting_pre = load("resting_pre.mat");

num_of_secs = 10;
num_of_channels = 1;

resting_post_plot = resting_post.EEG_import(1:num_of_channels, 1:num_of_secs*resting_post.fs).';

figure
plot(resting_post_plot)

fs = resting_post.fs;
bandpass_low_fc = 1;
bandpass_high_fc = 30;

%%
[b,a]= butter(4, [bandpass_low_fc, bandpass_high_fc]/(fs/2), 'bandpass');
size_ = size(resting_post.EEG_import);
for idx = 1:size_(1)
    resting_post.EEG_import(idx, :) = filtfilt(b, a, resting_post.EEG_import(idx, :));
end

%figure('Name', 'After filtfilt')
%plot(data_filtered2)
%%

EEG = pop_importdata('data', resting_post.EEG_import);
% [EEG_ICA, com] = pop_runica(EEG);

avg = pop_plotdata(EEG);
