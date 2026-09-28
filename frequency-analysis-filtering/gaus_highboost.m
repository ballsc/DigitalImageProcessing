% Function to implement gaussian highboost filtering
%
% Implement Gaussian highboost filtering in the frequency domain, with the filter simulated
% in the spatial domain. Show the results using different filter parameters
function img_filt = gaus_highboost(img, D0, A)
    img = double(img);
    [N, M] = size(img);

    % Fourier transform
    F = fftshift(fft2(img));

    % Frequency coordinates
    [X,Y] = meshgrid(1:M, 1:N);
    cx = floor(M/2) + 1;
    cy = floor(N/2) + 1;

    D = sqrt((X-cx).^2 + (Y-cy).^2);

    % Gaussian high-boost filter
    H = A - exp(-(D.^2)/(2*D0^2));

    % Apply filter
    G = H .* F;

    % Transform back
    img_filt = real(ifft2(ifftshift(G)));

end