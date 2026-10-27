% Function to perform histogram equalization on a color image. Converts the
% image to HSV color space and performs equalization on saturation 
%
% Inputs: img - color image
%
% Outputs: eq_img - equalized color image
%

function eq_img = color_equalization(img)
    img_hsv = rgb2hsv(img);
    s = img_hsv(:, 2);
    s_eq = histeq(s, numel(unique(s)));
    img_hsv = [img_hsv(:, 1), s_eq, img_hsv(:, 3)];
    eq_img = hsv2rgb(img_hsv);
end