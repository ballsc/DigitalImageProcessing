% Function to restore image with motion blur
% 
% Inputs: blur_img - original blurred image
%         size     - size of filter to use: 1 or 2
%         a        - horizontal element of motion blur
%         b        - vertical element of motion blur
%         gamma    - Lagrange multiplier
% 
% Outputs: restored_img - image restored from blurring
%
function [restored_img, F] = laplacian_filter(blur_img, filt_size, a, b, gamma)    
    if filt_size == 1
        p = [0, -1, 0; ...
            -1, 4, -1; ...
             0, -1, 0];
    elseif filt_size == 2
        p = [-1, -1, -1; ...
             -1,  8, -1; ...
             -1, -1, -1];
    else
        error("No size :(")
    end

    N = size(blur_img, 1); M = size(blur_img, 2);
    G = fftshift(fft2(blur_img));
    P = fft2(ifftshift(p), N, M);
    P = fftshift(P);

    [u, v] = meshgrid((-M/2):(M/2)-1, (-N/2):(N/2)-1);
    D = pi * (u*a + v*b);
    idx = (D~=0);
    H = ones(N, M);
    H(idx) = (sin(D(idx))./D(idx)).*exp(-1i*D(idx));

    L = conj(H) ./ (abs(H).^2 + gamma*(abs(P).^2));

    F = L.*G;

    restored_img = real(ifft2(ifftshift(F)));
end