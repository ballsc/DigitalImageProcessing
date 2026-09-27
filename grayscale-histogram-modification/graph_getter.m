% script to get graphs
img = double(rgb2gray(imread("mountain.jpg")));

% Equalize image, twice to test
img_eq1 = equalization(img);
img_eq2 = equalization(img_eq1);

% Make specified images
img_spc = specification(img, 1);
img_spc2 = specification(img, 2);

% Plot Images
figure; imshow(img_eq1, []); title("Once Equalized Image")
figure; imshow(img_eq2, []); title("Twice Equalized Image")
figure; imshow(img, []); title("Original Image")
figure; imshow(img_spc, []); title("Specified Gaussian Image")
figure; imshow(img_spc2, []); title("Specified 2 Gaussian Image")

% Plot Histograms
figure; histogram(img_eq1, 256); title("Once Equalized Distribution")
xlabel("Grayscale Value"); ylabel("Pixels")
figure; histogram(img_eq2, 256); title("Twice Equalized Distribution")
xlabel("Grayscale Value"); ylabel("Pixels")
figure; histogram(img, 256); title("Original Distribution")
xlabel("Grayscale Value"); ylabel("Pixels")
figure; histogram(img_spc, 256); title("Specified Gaussian Distribution")
xlabel("Grayscale Value" ); ylabel("Pixels")
figure; histogram(img_spc2, 256); title("Specified 2 Gaussian Distribution")
xlabel("Grayscale Value" ); ylabel("Pixels")
