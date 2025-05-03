% FIR-to-IIR Filter Approximation using Elliptic and Chebyshev Filters (MATLAB)

clc; clear; close all;

% FIR filter design
N_fir = 101;
cutoff = 0.3;
fir_coeff = fir1(N_fir - 1, cutoff, hamming(N_fir));

% Elliptic IIR filter design
N_iir_ellip = 8;
Rp_ellip = 0.5;     % Passband ripple in dB
Rs_ellip = 60;      % Stopband attenuation in dB
[b_ellip, a_ellip] = ellip(N_iir_ellip, Rp_ellip, Rs_ellip, cutoff);

% Chebyshev Type I IIR filter design
N_iir_cheby = 10;
Rp_cheby = 0.3;      % Passband ripple in dB
[b_cheby, a_cheby] = cheby1(N_iir_cheby, Rp_cheby, cutoff);

% Frequency responses
[H_fir, w] = freqz(fir_coeff, 1, 1024);
H_ellip = freqz(b_ellip, a_ellip, 1024);
H_cheby = freqz(b_cheby, a_cheby, 1024);

% Plot magnitude responses
figure;
plot(w/pi, 20*log10(abs(H_fir)), 'b', 'LineWidth', 1.2); hold on;
plot(w/pi, 20*log10(abs(H_ellip)), 'r--', 'LineWidth', 1.2);
plot(w/pi, 20*log10(abs(H_cheby)), 'g-.', 'LineWidth', 1.2);
title('Magnitude Response');
xlabel('Normalized Frequency (×\pi rad/sample)');
ylabel('Magnitude (dB)');
legend('FIR', 'Elliptic IIR', 'Chebyshev IIR');
grid on;

% Plot phase responses
figure;
plot(w/pi, unwrap(angle(H_fir)), 'b', 'LineWidth', 1.2); hold on;
plot(w/pi, unwrap(angle(H_ellip)), 'r--', 'LineWidth', 1.2);
plot(w/pi, unwrap(angle(H_cheby)), 'g-.', 'LineWidth', 1.2);
title('Phase Response');
xlabel('Normalized Frequency (×\pi rad/sample)');
ylabel('Phase (radians)');
legend('FIR', 'Elliptic IIR', 'Chebyshev IIR');
grid on;

% Pole-zero plots
figure;
subplot(1,2,1);
zplane(b_ellip, a_ellip);
title('Elliptic Filter Pole-Zero Plot');

subplot(1,2,2);
zplane(b_cheby, a_cheby);
title('Chebyshev Type I Filter Pole-Zero Plot');
