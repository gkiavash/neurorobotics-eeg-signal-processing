function visualize_after_ica (EEG_, pxx, f) 

%% Visualize PSD
figure()
plot(f, pxx)
title(EEG_.filename)
xlabel('Hz')
ylabel('PSD [\mu V^2 /Hz]')

%% Visualize topoplot

f_topo = [1 4; 4 8; 8 13; 13 30];

%figure("Name", sprintf('TOPO, PSD, %f %f', f_topo(i, 1), f_topo(i, 2)))
figure("Name", sprintf('topoplots %s', EEG_.filename))
for i=1:size(f_topo, 1)
    f1_delta = find(f >= f_topo(i, 1), 1, 'first');
    f2_delta = find(f >= f_topo(i, 2), 1, 'first');
    
    X = f(f1_delta:f2_delta);
    Y = pxx(f1_delta:f2_delta, :);
    
    power_delta = trapz(X,Y);

    subplot(2, 2, i)
    topoplot(power_delta, EEG_.chanlocs, 'style', 'both', 'electrodes', 'labelpoint');
    title(sprintf('PSD in [%f %f] Hz', f_topo(i, 1), f_topo(i, 2)))
    colormap('jet')
    colorbar
end

end