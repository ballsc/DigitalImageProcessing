close all

img = double(rgb2gray(imread("elephant.png")));
figure; imshow(img, []); title("Original Image")

M = floor(size(img, 1)/8);
N = floor(size(img, 2)/8);

% Rearrange PCs into a grid for display
pc16 = give_pc(img, 16);
figure; 
for i = 1:16
    subplot(4, 4, i)
    img_tmp = reshape(pc16{i}, [M, N])';

    imshow(img_tmp, []); title(sprintf("PC %d", i));
end

% Reconstruct original image using PCs 
figure;
for i = 1:6
    k = 2^(i-1);
    reconstructed = recon_pcs(img, k);
    subplot(2, 3, i);
    imshow(reconstructed, []);
    title(sprintf('Image Reconstructed Using First %d PCs', k));
    signal = sum(img.^2, "all");
    noise = sum((img - reconstructed).^2, "all");
    snr(i) = 10*log10(signal/noise);
end

% Compare reconstruction quality and SNR for different # of PCs
figure;
plot([1 2 4 8 16 32], snr, "-o"); title("Reconstruction SNR vs Number of PCs")
xlabel("Number of PCs"); ylabel("SNR (dB)"); xticks([1 2 4 16 32]);
