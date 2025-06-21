clc;
clearvars;
close all;

% Step 1: Define the frequencies and create the time vector
freq = [500 1000 1500 2000];   % Frequency components
Fs = 10000;
t = linspace(0, 1, Fs);     % Time vector (1 second duration, 10 kHz sampling)
% Generate the signal
x = cos(2*pi*freq(1)*t) + cos(2*pi*freq(2)*t) + cos(2*pi*freq(3)*t) + cos(2*pi*freq(4)*t);


% Step 2: Normalize the signal and save it to a .wav file
xN = x / max(abs(x));  % Normalize to ensure max value is 1
filename = 'x1(t).wav';
audiowrite(filename, xN, Fs); % Save as .wav file at 10 kHz sampling rate

% Step 3: Plot the signal in time domain
figure;
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Generated Signal x1(t)');
grid on;


% Step 4: Calculate energy in time domain
x_squared = x.^2;       % Square the signal to find |x(t)|^2
energy_time = trapz(t, x_squared);  % Integrate |x(t)|^2 over time
disp(['The energy of x1(t): ', num2str(energy_time)]); % Display time-domain energy

% Step 5: Compute the frequency spectrum using FFT
N = length(x);          % Number of samples
X_f = fft(x);           % Compute the Fourier Transform of the signal

% step 6: Normalize FFT by dividing by N
X_f_shifted = fftshift(X_f);  % Shift for plotting
X_f_magnitude = abs(X_f_shifted)/N;  % Get the magnitude of the FFT

% Plot the frequency spectrum (magnitude)
figure;% to create a window to popup
f = Fs*(-N/2:N/2-1)/N;  % Create frequency axis for plot
plot(f, X_f_magnitude);  % Use fftshift to center zero frequency in the plot
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum of x(t)');
xlim([-5000, 5000]);  % Limit frequency axis to relevant range
grid on;
% Step 7: Compute energy from the frequency spectrum (Parseval's theorem)
energy_frequency = sum(abs(X_f).^2)/(N^2);  % Sum of squared FFT magnitudes
disp(['The energy of the signal from the frequency domain is: ', num2str(energy_frequency)]);
disp(['Parseval verfication: ', num2str(abs(energy_frequency - energy_time ))])
% the result should be 0, but its 0.0014 due to diff metholds.

% Step 8: Design and apply a Butterworth low-pass filter
filter_order = 20;                     % Filter order
cutoff_frequency = 1250;               % Cutoff frequency in Hz
Wn = cutoff_frequency / (Fs/2);        % Normalize cutoff frequency (0 to 1 range)
[b, a] = butter(filter_order, Wn, 'low'); % Design Butterworth low-pass filter

% step 9 Plot the magnitude and phase response of the Butterworth LPF
figure;% to create a window to popup
freqz(b, a, 2048, Fs);
% 2048  give a very detailed plot (high resolution) but take slightly longer to compute.
title('Magnitude and Phase Response of Butterworth Low-Pass Filter');

% Step 10: Apply the signal x(t) to the Butterworth LPF
y1 = filter(b, a, x);  % Filter the signal using the designed LPF

% STEP 11 :Store the filtered signal y1(t) as a .wav audio file
output_filename = 'y1(t).wav';
audiowrite(output_filename, y1 / max(abs(y1)), Fs); % Normalize and save as .wav

%step 12 :Plot the filtered signal y1(t) in the time domain
figure;% to create a window to popup
plot(t, y1);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal y1(t)');
grid on;

% Step 13: Compute the energy of the filtered signal y1(t)
y1_squared = y1.^2;                  % Square the filtered signal to find |y1(t)|^2
energy_y1 = trapz(t, y1_squared);    % Integrate |y1(t)|^2 over the time
disp(['The energy of the filtered signal y1(t) is: ', num2str(energy_y1)]); % Display the energy

% Step 14: Compute the frequency spectrum Y1 of the filtered signal
Y1_f = fft(y1);                      % Compute the Fourier Transform of the filtered signal
Y1_f_shifted = fftshift(Y1_f);       % Shift for plotting
Y1_f_magnitude = abs(Y1_f_shifted)/N; % Normalize the FFT magnitude

% Step 15: Plot the magnitude of Y1(f) in the frequency range -Fs/2 <= f <= Fs/2
figure;
plot(f, Y1_f_magnitude);             % Plot the magnitude spectrum
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Filtered Signal Y1(f)');
xlim([-5000, 5000]);                 % Restrict to the range -Fs/2 to Fs/2
grid on;

% Step 16: Compute the energy of y1(t) from its frequency spectrum and verify Parseval's theorem
energy_y1_frequency = sum(abs(Y1_f).^2)/(N^2); % Sum of squared FFT magnitudes
disp(['The energy of y1(t) from its frequency spectrum is: ', num2str(energy_y1_frequency)]);

% Verify Parseval's theorem
parseval_difference = abs(energy_y1 - energy_y1_frequency);
disp(['Parseval verification : ', num2str(parseval_difference)]);
% the result should be 0, but its 9.8143×10^-5 which is 0.000098143 due to diff metholds.

% Step 17: Design a Butterworth high-pass filter
filter_order_hp = 20;                     % Filter order
cutoff_frequency_hp = 1250;               % Cutoff frequency in Hz
Wn_hp = cutoff_frequency_hp / (Fs/2);     % Normalize cutoff frequency (0 to 1 range)
[b_hp, a_hp] = butter(filter_order_hp, Wn_hp, 'high'); % Design Butterworth high-pass filter

% step 18 Plot the magnitude and phase response of the high-pass filter
figure;
freqz(b_hp, a_hp, 2048, Fs);% 2048  give a very detailed plot (high resolution) but take slightly longer to compute.
title('Magnitude and Phase Response of Butterworth High-Pass Filter');

% Step 19: Apply the signal x(t) to the Butterworth HPF
y2 = filter(b_hp, a_hp, x);  % Filter the signal using the high-pass filter

% Step 20: Store the filtered signal y2(t) as a .wav audio file
output_filename_y2 = 'y2(t).wav';
audiowrite(output_filename_y2, y2 / max(abs(y2)), Fs); % Normalize and save as .wav


% Step 21: Plot the filtered signal y2(t) in the time domain
figure;
plot(t, y2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal y2(t) (High-Pass Filtered)');
grid on;

% Step 22: Compute the energy of the filtered signal y2(t)
y2_squared = y2.^2;                  % Square the filtered signal to find |y2(t)|^2
energy_y2 = trapz(t, y2_squared);    % Integrate |y2(t)|^2 over the time vector
disp(['The energy of the filtered signal y2(t) is: ', num2str(energy_y2)]); % Display the energy

% Step 23: Compute the frequency spectrum Y2(f) of the filtered signal
Y2_f = fft(y2);                      % Compute the Fourier Transform of the filtered signal
Y2_f_shifted = fftshift(Y2_f);       % Shift the spectrum for plotting
Y2_f_magnitude = abs(Y2_f_shifted)/N; % Normalize the FFT magnitude

% Step 24: Plot the magnitude of Y2(f) in the frequency range -Fs/2 <= f <= Fs/2
figure;
plot(f, Y2_f_magnitude);             % Plot the magnitude spectrum
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Filtered Signal Y2(f)');
xlim([-5000, 5000]);                 % Restrict to the range -Fs/2 to Fs/2
grid on;


% Step 25: Compute the energy of y2(t) from its frequency spectrum and verify Parseval's theorem
energy_y2_frequency = sum(abs(Y2_f).^2)/(N^2); % Sum of squared FFT magnitudes
disp(['The energy of y2(t) from its frequency spectrum is: ', num2str(energy_y2_frequency)]);

% Verify Parseval's theorem
parseval_difference_y2 = abs(energy_y2 - energy_y2_frequency);
disp(['Parseval verification for y2(t): ', num2str(parseval_difference_y2)]);


