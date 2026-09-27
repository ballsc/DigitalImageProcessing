function spc_img = specification(img, run)
    % get pdf
    img_condense = unique(img);

    p = zeros(1, numel(img_condense));
    for i = 1:numel(img_condense)
        p(i) = numel(img(img == img_condense(i)))/numel(img);
    end

    % get cdf
    c = cumsum(p);

    % make desired PDF, gaussian distribution
    if run == 1
        mu = 110; sigma = 50;
        pd = exp(-((0:255) - mu).^2 / (2*sigma^2));
        pd = pd / sum(pd);
    else 
        mu = 48; sigma = 30; mu2 = 171; sigma2 = 40;
        pd = exp(-((0:255) - mu).^2 / (2*sigma^2)) + exp(-((0:255) - mu2).^2 / (2*sigma2^2));
        pd = pd / sum(pd);
    end
    % derive desired CDF
    c_d = cumsum(pd);

    % store mapping of closest grayscale values
    map = zeros(1, 256);

    for i = 1:256
        [~, idx] = min(abs(c_d - c(i)));
        map(i) = idx - 1;
    end

    % create final specified image
    spc_img = map(img + 1);
end