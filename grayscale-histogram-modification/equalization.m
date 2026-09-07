% img = double(imread("bookcover_gray.jpg"));
% img = double(rgb2gray(imread("Bully.jpg")));
img = double(rgb2gray(imread("bird.jpg")));

img_eq1 = equalize(img);
img_eq2 = equalize(img_eq1);

% Plot Images
figure;
imshow(img_eq1, []); title("Once Equalized Image")
figure;
imshow(img_eq2, []); title("Twice Equalized Image")
figure;
imshow(img, []); title("Original Image")

% Plot Histograms
figure;
histogram(img_eq1, 256); title("Once Equalized Distribution")
xlabel("Grayscale Value"); ylabel("Pixels")
figure;
histogram(img_eq2, 256); title("Twice Equalized Distribution")
xlabel("Grayscale Value"); ylabel("Pixels")
figure;
histogram(img, 256); title("Original Distribution")
xlabel("Grayscale Value"); ylabel("Pixels")

function img_eq = equalize(img)
    % find cdf of pdf
    img_condense = unique(img);
    
    p = zeros(1, numel(img_condense));
    for i = 1:numel(img_condense)
        p(i) = numel(img(img == img_condense(i)))/numel(img);
    end
    
    % find cdf values for each pixel value split
    c = zeros(1, numel(p));
    for i = 1:numel(p)
        c(i) = sum(p(1:i));
    end
    
    % scale cdf values from zero to 255
    scaled_c = floor(c.*(255));
    
    % Create final equalized image
    img_eq = zeros(size(img));
    
    for i = 1:numel(img_condense)
        img_eq(img == img_condense(i)) = scaled_c(i);
    end
end
%% Optional make final pdf
% % create final pdf from new scaled cdf
% final_p = zeros(1, 256);
% for i = 1:numel(scaled_c)
%     final_p(scaled_c(i)+1) = final_p(scaled_c(i)+1) + p(i);
% end