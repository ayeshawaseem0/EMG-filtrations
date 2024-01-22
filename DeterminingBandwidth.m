% Load the EMG signal data
data = readmatrix("C:\Users\ayesh\Downloads\EMG_Datasets.csv"); % The data is stored in the file EMG_Datasets.csv

% Extract the EMG signal for analysis
emgSignal = data(:, 3); % The EMG signal is in the third column

% Perform the Fourier transform
N = length(emgSignal); % Length of the signal
Fs = 2047.8; % Sampling frequency 
Y = fft(emgSignal);

% Compute the frequency axis
f = Fs * (0:(N/2))/N;

% Compute the single-sided spectrum
P = abs(Y/N);
P1 = P(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Plot the frequency spectrum
plot(f, P1)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Spectrum of EMG Signal')

% Find the range of frequencies with significant signal energy
energyThreshold = 0.05; % Adjust this threshold as needed
significantFreqRange = f(P1 > energyThreshold * max(P1));
disp('Range of frequencies with significant signal energy:')
disp([min(significantFreqRange), max(significantFreqRange)])
