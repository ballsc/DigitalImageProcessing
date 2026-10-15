% Get original and blurred images
img = double(rgb2gray(imread("squirrel.jpg")));
motions = {[.01, .01], [0, .1], [.1, 0], [.1, .1], [.2, 0], [0, .2] ... 
            [.2, .2], [.3, 0], [0, .3]};

g = cell(size(motions)); F = cell(size(motions)); G = cell(size(motions));
for i = 1:numel(motions)
    motion = motions{i};
    [g{i}, F{i}, G{i}] = motion_blur(img, motion(1), motion(2));
end

idx = 4;
close all;

% Display original image and blurred image
figure; subplot(1, 2, 1);
imshow(img, []); title("Original Image");
subplot(1, 2, 2)
imshow(g{idx}, []); title("Blurred Image");

% Find and calculate amplitude of images
amp_orig = abs(F{idx});
amp_blur = abs(G{idx});

% Display amplitude of images
figure; subplot(1, 2 , 1)
imshow(log(1 + amp_orig), [])
title("Original Image Amplitude Spectrum")

subplot(1, 2, 2)
imshow(log(1 + amp_blur), [])
title("Blurred Image Amplitude Spectrum")

% Restore original Image with laplacian filter
blur_img = g{idx};
motion = motions{idx};
a = motion(1); b = motion(2);
[rest_img1, F1] = laplacian_filter(blur_img, 1, a, b, 0.00001);

amp_f1 = abs(F1);

figure; subplot(1, 2, 1)
imshow(rest_img1, [])
title("Restored image from filter one")

subplot(1, 2, 2)
imshow(log(1 + amp_f1), [])
title("Amplitude Spectra of first filtered image")

% Restore original image with second filter
blur_img = g{idx};
motion = motions{idx};
a = motion(1); b = motion(2);
[rest_img2, F2] = laplacian_filter(blur_img, 2, a, b, 0.00001);

amp_f2 = abs(F2);

figure; subplot(1, 2, 1)
imshow(rest_img2, [])
title("Restored image from filter two")

subplot(1, 2, 2)
imshow(log(1 + amp_f2), [])
title("Amplitude Spectra of second filtered image")