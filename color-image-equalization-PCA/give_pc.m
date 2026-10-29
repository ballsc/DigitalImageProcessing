% Given an image and value num, the principal components 1-X of the image.
%
% Inputs: img - original image to retrieve principal components from
%         num - number of principal components to retrieve from img
%
% Outputs: pcs - cell array of principal component. Size N

function [pcs, V, m] = give_pc(img, num)
    % Divide image into 8x8 patches and reshape into 64xN matrix
    M = floor(size(img, 1)/8);
    N = floor(size(img, 2)/8);
    for i = 1:M
        for j = 1:N
            X(:,(i-1)*N+j) = reshape(img(i*8-7:i*8, j*8-7:j*8), [64, 1]);
        end
    end

    % Compute Covariance matrix
    m = mean(X, 2);
    C = (1/(M*N)) * (X*X') - m*m';

    % Perform eigen decomposition
    [V, L] = eig(C);
    [~, idx] = sort(diag(L), 'descend');
    V = V(:, idx);
    
    % Compute principal components
    for i = 1:num
        pcs{i} = V(:, i)' * (X-m);
    end
end