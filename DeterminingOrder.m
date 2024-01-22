% Load the EMG data
data = readmatrix("C:\Users\ayesh\Downloads\EMG_Datasets.csv"); % The data is stored in the file EMG_Datasets.csv

% Extract the time and EMG signal for the contracted muscle
time = data(:, 1); % Time in seconds
emgContracted = data(:, 3); % EMG of contracted muscle in mV

% Define the sampling frequency and notch frequency
Fs = 2047.8; % Sampling frequency in Hz
notchFrequency = 60; % Frequency of the interference signal in Hz

% Design the notch filter using Butterworth
filterOrder = 2; % Filter order
normalizedNotchFrequency = notchFrequency / (Fs/2); % Convert notch frequency to a normalized value between 0 and 1
[b, a] = butter(filterOrder, [normalizedNotchFrequency-0.01, normalizedNotchFrequency+0.01], 'stop');

% Apply the notch filter to the contracted muscle EMG signal
filteredContracted = filtfilt(b, a, emgContracted);

% Plot the original and filtered EMG signals for the contracted muscle
figure;
subplot(2, 1, 1);
plot(time, emgContracted);
xlabel('Time (s)');
ylabel('EMG (mV)');
title('Original Contracted EMG Signal');

subplot(2, 1, 2);
plot(time, filteredContracted);
xlabel('Time (s)');
ylabel('EMG (mV)');
title('Filtered Contracted EMG Signal');
