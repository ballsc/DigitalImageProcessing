img = imread("zebra.png");
img = double(rgb2gray(img));

%% Part 1: Frequency spectra and its rotated version
% Original image
af = fft2(img); % 2-D Fourier transform
afs = fftshift(af); % Move zero frequency to center

mag = log(abs(afs)); % Log magnitude spectrum
phase = angle(afs); % Phase spectrum

figure; imshow(mag, []);
title('Original Image - Magnitude Spectrum');

figure; imshow(phase, []);
title('Original Image - Phase Spectrum');

% Rotate image
img_r = imrotate(img, 90);

af_r = fft2(img_r); % FFT OF ROTATED IMAGE
afs_r = fftshift(af_r);

mag_r = log(abs(afs_r));
phase_r = angle(afs_r);

figure; imshow(mag_r, []);
title('Rotated Image - Magnitude Spectrum');

figure; imshow(phase_r, []);
title('Rotated Image - Phase Spectrum');

%% Part 2: Gaussian Highpass
figure; imshow(img, []);
title("Original Image")

freqs = [30, 90, 150];
for freq = freqs
    gaus_highpass_img = gaus_highpass(img, freq);
    figure; imshow(gaus_highpass_img, []);
    title(sprintf('Gaussian High-Pass Filtered Image, D0 = %.1f', freq))
end

%% Part 3: Gaussian Highboost
figure; imshow(img, []);
title("Original Image")

freqs = [30, 150];
boosts = [1.1, 1.7];
for freq = freqs
    for boost = boosts
        gaus_highboost_img = gaus_highboost(img, freq, boost);
        figure; imshow(gaus_highboost_img, []);
        title(sprintf('Gaussian High-Boost Filtered Image, D0 = %.1f, A = %.1f',...
            freq, boost))
    end
end