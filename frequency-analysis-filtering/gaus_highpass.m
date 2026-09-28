% function to perform gaussian highpass filtering on an image

% Implement Gaussian highpass filtering in the frequency domain, with the filter simulated
% in the spatial domain. Show the results using different filter parameters.
function img_filt = gaus_highpass(img, D0)
    [N, M] = size(img);
    F = fftshift(fft2(img));

    [X,Y] = meshgrid(1:M, 1:N);
    cx = floor(M/2) + 1;
    cy = floor(N/2) + 1;

    D = sqrt((X-cx).^2 + (Y-cy).^2);

    Z = 1 - exp(-(D.^2)/(2*D0^2));

    % Apply filter
    G = Z .* F;

    % Transform back to spatial domain
    img_filt = real(ifft2(ifftshift(G)));
end