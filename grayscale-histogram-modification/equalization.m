function eq_img = equalization(img)
    % get pdf
    img_condense = unique(img);

    p = zeros(1, numel(img_condense));
    for i = 1:numel(img_condense)
        p(i) = numel(img(img == img_condense(i)))/numel(img);
    end

    % get cdf
    c = cumsum(p);

    % scale cdf values from zero to 255
    scaled_c = round(c.*(255));
    
    % Create final equalized image
    eq_img = zeros(size(img));

    for i = 1:numel(img_condense)
        eq_img(img == img_condense(i)) = scaled_c(i);
    end
end