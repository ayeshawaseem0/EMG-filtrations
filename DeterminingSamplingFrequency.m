% Load the EMG signal data
data = readmatrix("C:\Users\ayesh\Downloads\EMG_Datasets.csv"); % The data is stored in the file EMG_Datasets.csv

% Extract the time and EMG signal for the contracted muscle
time = data(:, 1); %The time values in the first column
emgSignal = data(:, 3); % The EMG signal is in the third column

%Calculate the time intervals
dt = diff(time);

%Estimate the sampling frequency
Fs = 1/mean(dt);

%Verify the sampling frequency by plotting the EMG signal
figure;
plot(time, emgContracted);
xlabel('Time (s)');
ylabel('EMG (mV)');
title('EMG Signal for COntracted Muscle')

%Display the estimated sapling frequency
disp(['Estimated Sampling Frequency: ' num2str(Fs) 'Hz']);
