% Simulate motion blur in the frequency domain
%
% Inputs: img - image to blur
%         a   - horizontal motion
%         b   - vertical motion
%
% Outputs: blur_img - resulting blurred image
%          F        - original image in frequency domain
%          G        - blurred image in frequency domain

function [blur_img, F, G] = motion_blur(img, a, b)    
    % Transform image to frequency domain
    N = size(img, 1); M = size(img, 2);
    F = fftshift(fft2(img));
    
    % Generate motion blur
    [u, v] = meshgrid((-M/2):(M/2)-1, (-N/2):(N/2)-1);
    D = pi * (u*a + v*b);
    idx = (D~=0);
    H = ones(N, M);
    H(idx) = (sin(D(idx))./D(idx)).*exp(-1i*D(idx));
    
    % Calculate blurred image
    G = F.*H;
    blur_img = real(ifft2(ifftshift(G)));
end