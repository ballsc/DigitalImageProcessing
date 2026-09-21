img = imread("zebra.png");
img = double(img);

% Part 1: Show the frequency spectra of an original image and its rotated version (using "imrotate"),
% and discuss the changes in the magnitude and phase spectra.
% Original image
af = fft2(img); % 2-D Fourier transform
afs = fftshift(af); % Move zero frequency to center

mag = log(abs(afs)); % Log magnitude spectrum
phase = angle(afs); % Phase spectrum

figure;
imshow(mag, []);
title('Original Image - Magnitude Spectrum');

figure;
imshow(phase, []);
title('Original Image - Phase Spectrum');


% Rotate image
img_r = imrotate(img, 90);

af_r = fft2(img_r); % FFT OF ROTATED IMAGE
afs_r = fftshift(af_r);

mag_r = log(abs(afs_r));
phase_r = angle(afs_r);

figure;
imshow(mag_r, []);
title('Rotated Image - Magnitude Spectrum');

figure;
imshow(phase_r, []);
title('Rotated Image - Phase Spectrum');