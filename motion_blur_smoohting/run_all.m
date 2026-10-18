% Get original and blurred images
img = double(rgb2gray(imread("squirrel.jpg")));

% Lateral Velocities
vertical_motions = {[0, .01], [0, .1], [0, .3]};
for i = 1:numel(vertical_motions)
    motion = vertical_motions{i};
    [g_vert{i}, F{i}, G_vert{i}] = motion_blur(img, motion(1), motion(2));
end

% Horizontal Velocities
horizontal_motions = {[.01, 0], [.1, 0], [.3, 0]};
for i = 1:numel(horizontal_motions)
    motion = horizontal_motions{i};
    [g_horiz{i}, F{i}, G_horiz{i}] = motion_blur(img, motion(1), motion(2));
end

% Combination of Horizontal and Lateral Velocities
combo_motions = {[.01, .01], [.1, .1], [.3, .3]};
for i = 1:numel(combo_motions)
    motion = combo_motions{i};
    [g_combo{i}, F{i}, G_combo{i}] = motion_blur(img, motion(1), motion(2));
end

close all;
% Display original image and blurred image
figure; subplot(1, 2, 1)
imshow(img, []); title("Original Image");
amp_orig = abs(F{1});
subplot(1, 2, 2)
imshow(log(1 + amp_orig), [])
title("Original Image Amplitude Spectrum")

figure;
for i = 1:3
    subplot(3, 3, i)
    imshow(g_horiz{i}, []); 
    title(sprintf("[a,b] = [%.2f, %.2f]", horizontal_motions{i}))

    subplot(3, 3, i+3)
    imshow(g_vert{i}, [])
    title(sprintf("[a,b] = [%.2f, %.2f]", vertical_motions{i}))

    subplot(3, 3, i+6)
    imshow(g_combo{i}, [])
    title(sprintf("[a,b] = [%.2f, %.2f]", combo_motions{i}))
end

amp_blur_combo = cellfun(@(x) abs(x), G_combo, "UniformOutput",false);
amp_blur_horiz = cellfun(@(x) abs(x), G_horiz, "UniformOutput",false);
amp_blur_vert = cellfun(@(x) abs(x), G_vert, "UniformOutput",false);

figure;
for i = 1:3
    subplot(3, 3, i)
    imshow(log(1 + amp_blur_horiz{i}), []); 
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", horizontal_motions{i}))

    subplot(3, 3, i+3)
    imshow(log(1 + amp_blur_vert{i}), [])
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", vertical_motions{i}))

    subplot(3, 3, i+6)
    imshow(log(1 + amp_blur_combo{i}), [])
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", combo_motions{i}))
end

% Restore original Image with laplacian filter
gamma = 0.00001;
for i = 1:3
    motion = horizontal_motions{i};
    a = motion(1); b = motion(2);
    [rest_img1_horiz{i}, F1_horiz{i}] = laplacian_filter(g_horiz{i}, 1, a, b, gamma);

    motion = vertical_motions{i};
    a = motion(1); b = motion(2);
    [rest_img1_vert{i}, F1_vert{i}] = laplacian_filter(g_vert{i}, 1, a, b, gamma);

    motion = combo_motions{i};
    a = motion(1); b = motion(2);
    [rest_img1_combo{i}, F1_combo{i}] = laplacian_filter(g_combo{i}, 1, a, b, gamma);
end

figure;
for i = 1:3
    subplot(3, 3, i)
    imshow(rest_img1_horiz{i}, []); 
    title(sprintf("Restored 1 [a,b] = [%.2f, %.2f]", horizontal_motions{i}))

    subplot(3, 3, i+3)
    imshow(rest_img1_vert{i}, [])
    title(sprintf("Restored 1 [a,b] = [%.2f, %.2f]", vertical_motions{i}))

    subplot(3, 3, i+6)
    imshow(rest_img1_combo{i}, [])
    title(sprintf("Restored 1 [a,b] = [%.2f, %.2f]", combo_motions{i}))
end

amp_blur_combo_1 = cellfun(@(x) abs(x), F1_combo, "UniformOutput",false);
amp_blur_horiz_1 = cellfun(@(x) abs(x), F1_horiz, "UniformOutput",false);
amp_blur_vert_1 = cellfun(@(x) abs(x), F1_vert, "UniformOutput",false);

figure;
for i = 1:3
    subplot(3, 3, i)
    imshow(log(1 + amp_blur_horiz_1{i}), []); 
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", horizontal_motions{i}))

    subplot(3, 3, i+3)
    imshow(log(1 + amp_blur_vert_1{i}), [])
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", vertical_motions{i}))

    subplot(3, 3, i+6)
    imshow(log(1 + amp_blur_combo_1{i}), [])
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", combo_motions{i}))
end

% Restore original image with second filter
for i = 1:3
    motion = horizontal_motions{i};
    a = motion(1); b = motion(2);
    [rest_img2_horiz{i}, F2_horiz{i}] = laplacian_filter(g_horiz{i}, 2, a, b, gamma);

    motion = vertical_motions{i};
    a = motion(1); b = motion(2);
    [rest_img2_vert{i}, F2_vert{i}] = laplacian_filter(g_vert{i}, 2, a, b, gamma);

    motion = combo_motions{i};
    a = motion(1); b = motion(2);
    [rest_img2_combo{i}, F2_combo{i}] = laplacian_filter(g_combo{i}, 2, a, b, gamma);
end

figure;
for i = 1:3
    subplot(3, 3, i)
    imshow(rest_img2_horiz{i}, []); 
    title(sprintf("Restored 2 [a,b] = [%.2f, %.2f]", horizontal_motions{i}))

    subplot(3, 3, i+3)
    imshow(rest_img2_vert{i}, [])
    title(sprintf("Restored 2 [a,b] = [%.2f, %.2f]", vertical_motions{i}))

    subplot(3, 3, i+6)
    imshow(rest_img2_combo{i}, [])
    title(sprintf("Restored 2 [a,b] = [%.2f, %.2f]", combo_motions{i}))
end

amp_blur_combo_2 = cellfun(@(x) abs(x), F2_combo, "UniformOutput",false);
amp_blur_horiz_2 = cellfun(@(x) abs(x), F2_horiz, "UniformOutput",false);
amp_blur_vert_2 = cellfun(@(x) abs(x), F2_vert, "UniformOutput",false);

figure;
for i = 1:3
    subplot(3, 3, i)
    imshow(log(1 + amp_blur_horiz_2{i}), []); 
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", horizontal_motions{i}))

    subplot(3, 3, i+3)
    imshow(log(1 + amp_blur_vert_2{i}), [])
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", vertical_motions{i}))

    subplot(3, 3, i+6)
    imshow(log(1 + amp_blur_combo_2{i}), [])
    title(sprintf("Amplitude [a,b] = [%.2f, %.2f]", combo_motions{i}))
end