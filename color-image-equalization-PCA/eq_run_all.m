img = imread("elk.jpeg");

eq_img = color_equalization(img, 1.5);

close all
figure; imshow(img, []); title("Original Image")
figure; imshow(eq_img, []); title("Equalized Image")