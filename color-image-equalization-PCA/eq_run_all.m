img = imread("elk.jpeg");

[eq_img, s_scaled] = color_equalization(img, 1);

close all
figure; imshow(img, []); title("Original Image")
figure; subplot(3, 1, 1); histogram(img(:, :, 1)); title("R Original");
subplot(3, 1, 2); histogram(img(:, :, 2)); title("G Original");
subplot(3, 1, 3); histogram(img(:, :, 3)); title("B Original");

figure; imshow(eq_img, []); title("Equalized Image")
figure; subplot(3, 1, 1); histogram(255*eq_img(:, :, 1)); title("R Equalized");
subplot(3, 1, 2); histogram(255*eq_img(:, :, 2)); title("G Equalized");
subplot(3, 1, 3); histogram(255*eq_img(:, :, 3)); title("B Equalized");

[eq_img2, s_scaled2] = color_equalization(img, .5);

[eq_img3, s_scaled3] = color_equalization(img, 2);

x_max = max(s_scaled3(:));

figure; subplot(2, 3, 1);
imshow(eq_img, []); title("No Saturation Scaling")
subplot(2, 3, 4); histogram(s_scaled); xlim([0 x_max]);

subplot(2, 3, 2);imshow(eq_img2, []); title("Saturation Scaled by .5")
subplot(2, 3, 5); histogram(s_scaled2); xlim([0 x_max]);

subplot(2, 3, 3); imshow(eq_img3, []); title("Saturation Scaled by 2")
subplot(2, 3, 6); histogram(s_scaled3); xlim([0 x_max]);