clear all;
addpath('C:\Program Files\MATLAB\R2021b\toolbox\eeglab2021.1')
% eeglab;

resting_post = load("resting_post.mat");
resting_pre = load("resting_pre.mat");

num_of_secs = 30;
num_of_channels = 1;

%figure
%plot(resting_post.EEG_import(1:num_of_channels, 1:num_of_secs*resting_post.fs).')

size_ = size(resting_post.EEG_import);
fs = resting_post.fs;
bandpass_low_fc = 1;
bandpass_high_fc = 30;

%% Filtering
%figure('Name', 'Before filtfilt')
%plot(resting_post.EEG_import(1, 1:num_of_secs*resting_post.fs))

pxx = pwelch(resting_post.EEG_import(1,:));
figure('Name', 'PSD')
plot(pxx(1:2000))

[b,a]= butter(4, [bandpass_low_fc, bandpass_high_fc]/(fs/2), 'bandpass');
for idx = 1:size_(1)
    resting_post.EEG_import(idx, :) = filtfilt(b, a, resting_post.EEG_import(idx, :));
end

%figure('Name', 'After filtfilt')
%plot(resting_post.EEG_import(1, 1:num_of_secs*resting_post.fs))
%% Import EEG

EEG = pop_importdata('setname', 'n1', 'data', resting_post.EEG_import, 'srate', resting_post.fs, 'chanlocs', 'gtech_64.sfp');

% [EEG, com] = pop_runica(EEG);
%figure()
%topoplot(resting_post.EEG_import(1, :), EEG.chanlocs)
% avg = pop_plotdata(EEG, 1);
% pop_eegplot(EEG);

%% PSD

frequency = 0:0.01:40;
window = 1*fs;
noverlap = 0.5*fs;
[pxx, f] = pwelch(EEG.data', window, noverlap, frequency, fs);
figure()
plot(f, pxx)
xlabel('Hz')
ylabel('PSD [\mu V^2 /Hz]')
%% Power

f_topo = [1 4; 4 8; 8 13; 13 30];
for i=1:size(f_topo, 1)
    f1_delta = find(f >= f_topo(i, 1), 1, 'first');
    f2_delta = find(f >= f_topo(i, 2), 1, 'first');
    
    X = f(f1_delta:f2_delta);
    Y = pxx(f1_delta:f2_delta, :);
    
    power_delta = trapz(X,Y);

    figure("Name", sprintf('TOPO, PSD, %f %f', f_topo(i, 1), f_topo(i, 2)))
    topoplot(power_delta, EEG.chanlocs, 'style', 'both', 'electrodes', 'labelpoint');
    title(sprintf('Power in DELTA band [%f %f] Hz', f_topo(i, 1), f_topo(i, 2)))
    colormap('jet')
    colorbar
end


%% Topo-plot

