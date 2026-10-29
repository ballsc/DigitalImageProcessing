% Function to perform histogram equalization on a color image. Converts the
% image to HSV color space and performs equalization on saturation 
%
% Inputs: img - color image
%
% Outputs: eq_img - equalized color image
%

function eq_img = color_equalization(img, sat_scale)
    img_hsv = rgb2hsv(img);
    h = img_hsv(:, :, 1);
    s = img_hsv(:, :, 2);
    v = img_hsv(:, :, 3);
    v_eq = histeq(v, numel(unique(v)));
    s_scaled = s*sat_scale;
    img_hsv = reshape([h, s_scaled, v_eq], size(img));
    eq_img = hsv2rgb(img_hsv);
end