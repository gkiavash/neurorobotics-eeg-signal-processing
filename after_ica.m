clc;
clear;
close all;

addpath('C:\Program Files\MATLAB\R2021b\toolbox\eeglab2021.1')
eeglab;

EEG_pre = pop_loadset('data/ica_pre.set');
EEG_post = pop_loadset('data/ica_post.set');
%% PSD
fs = EEG_pre.srate;

frequency = 0:0.01:40;
window = 1*fs;
noverlap = 0.5*fs;
[pxx_pre, f_pre] = pwelch(EEG_pre.data', window, noverlap, frequency, fs);
[pxx_post, f_post] = pwelch(EEG_post.data', window, noverlap, frequency, fs);

%% Visualize
visualize_after_ica(EEG_pre, pxx_pre, f_pre)
visualize_after_ica(EEG_post,pxx_post, f_post)

%% Higuchi

klin = 6;
kmax = 18;
new_fractal = featuresExtraction2(EEG_pre.data, klin, kmax);

highuchi_dim_pre = featuresExtraction2(EEG_pre.data, klin, kmax);
highuchi_dim_post = featuresExtraction2(EEG_post.data, klin, kmax);

figure('Name', 'Higuchi')
subplot(1, 2, 1)
plot(highuchi_dim_pre)
subplot(1, 2, 2)
plot(highuchi_dim_post)

figure()
topoplot(highuchi_dim_pre, EEG_pre.chanlocs, 'style', 'both', 'electrodes', 'labelpoint');
title('Higuchi fractal dimension')
colormap('jet')
colorbar

