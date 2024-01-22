% Load the EMG data
data = readmatrix('C:\Users\ayesh\Downloads\EMG_Datasets.csv'); % The data is stored in the file EMG_Datasets.csv

% Extract the time, EMG signals for relaxed and contracted muscles
time = data(:, 1); % Time in seconds
emgRelaxed = data(:, 2); % EMG of relaxed muscle in mV
emgContracted = data(:, 3); % EMG of contracted muscle in mV

% Define the sampling frequency and notch frequency
Fs = 2047.8; % Sampling frequency in Hz
notchFrequency = 60; % Frequency of the interference signal in Hz

% Calculate the normalized notch frequency and bandwidth
normalizedNotchFrequency = notchFrequency / (Fs/2);
bandwidth = 65; % Bandwidth in Hz
normalizedBandwidth = bandwidth / (Fs/2);

% Design the notch filter using Butterworth filter design methodology
filterOrder = 2; % Filter order
[b, a] = butter(filterOrder, [normalizedNotchFrequency-normalizedBandwidth/2, normalizedNotchFrequency+normalizedBandwidth/2], 'stop');

% Apply the notch filter to the relaxed muscle EMG signal
filteredRelaxed = filtfilt(b, a, emgRelaxed);

% Apply the notch filter to the contracted muscle EMG signal
filteredContracted = filtfilt(b, a, emgContracted);

% Plot the original and filtered EMG signals for the relaxed muscle
figure;
subplot(2, 1, 1);
plot(time, emgRelaxed);
xlabel('Time (s)');
ylabel('EMG (mV)');
title('Original Relaxed EMG Signal');

subplot(2, 1, 2);
plot(time, filteredRelaxed);
xlabel('Time (s)');
ylabel('EMG (mV)');
title('Filtered Relaxed EMG Signal');

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

% Calculate the transfer function coefficients
[num, den] = butter(filterOrder, [normalizedNotchFrequency-normalizedBandwidth/2, normalizedNotchFrequency+normalizedBandwidth/2], 'stop');

% Display the transfer function coefficients
disp('Transfer Function Coefficients:');
disp(['Numerator: ', num2str(num)]);
disp(['Denominator: ', num2str(den)]);

% Create the transfer function from the coefficients
H = tf(num, den, 1/Fs);

% Display the transfer function
disp('Transfer Function:');
disp(H);


