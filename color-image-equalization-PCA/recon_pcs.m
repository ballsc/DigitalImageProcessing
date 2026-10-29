% Function to create reconstructed image with num_pcs number of principal
% components
%
% Inputs: img     - original image
%         num_pcs - number of pcs to recreate with
%
% Outputs: reconstructed - reconstructed image
%
function reconstructed = recon_pcs(img, num_pcs)
[pcs, V, m] = give_pc(img, num_pcs);

M = floor(size(img, 1)/8);
N = floor(size(img, 2)/8);

scores = vertcat(pcs{1:num_pcs});
img_recon = V(:,1:num_pcs) * scores + m;

for i = 1:M
    for j = 1:N
        idx = (i-1)*N + j;

        reconstructed(i*8-7:i*8, j*8-7:j*8) = ...
            reshape(img_recon(:,idx), [8,8]);
    end
end
end