% FIR-to-IIR Filter Approximation using Elliptic Filter (MATLAB)

clc; clear; close all;

% FIR filter design
N_fir = 101;
cutoff = 0.3;
fir_coeff = fir1(N_fir - 1, cutoff, hamming(N_fir));

% Elliptic IIR filter design
N_iir = 8;
Rp = 0.5;     % Passband ripple in dB
Rs = 60;      % Stopband attenuation in dB
[b_iir, a_iir] = ellip(N_iir, Rp, Rs, cutoff);

% Frequency responses
[H_fir, w] = freqz(fir_coeff, 1, 1024);
H_iir = freqz(b_iir, a_iir, 1024);

% Plot magnitude responses
figure;
subplot(2,1,1);
plot(w/pi, 20*log10(abs(H_fir)), 'b', 'LineWidth', 1.2);
hold on;
plot(w/pi, 20*log10(abs(H_iir)), 'r--', 'LineWidth', 1.2);
title('Magnitude Response');
xlabel('Normalized Frequency (×\pi rad/sample)');
ylabel('Magnitude (dB)');
legend('FIR', 'IIR (Elliptic)');
grid on;

% Plot phase responses
subplot(2,1,2);
plot(w/pi, unwrap(angle(H_fir)), 'b', 'LineWidth', 1.2);
hold on;
plot(w/pi, unwrap(angle(H_iir)), 'r--', 'LineWidth', 1.2);
title('Phase Response');
xlabel('Normalized Frequency (×\pi rad/sample)');
ylabel('Phase (radians)');
legend('FIR', 'IIR (Elliptic)');
grid on;

% Pole-zero plot
figure;
zplane(b_iir, a_iir);
title('Pole-Zero Plot (IIR Filter)');
