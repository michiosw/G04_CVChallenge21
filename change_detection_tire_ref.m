function ref = change_detection_tire_ref(I1_prepro, I1_name)
%CHANGE_DETECTION_TIRE Summary of this function goes here
%   Detailed explanation goes here
% Reading in all Images from the above specified File

% PCA
I1_pca = double(I1_prepro);
X1 = reshape(I1_pca, size(I1_pca,1)*size(I1_pca,2),3);
coeff1 = pca(X1);
I1transformed = X1*coeff1;
ab1 = reshape(I1transformed(:,1),size(I1_pca,1),size(I1_pca,2));
% Preparing for K-Means
nrows = size(ab1,1);
ncols = size(ab1,2);
ab1 = reshape(ab1,nrows*ncols,1);
% K-Means
n = 2;
[cluster_idx, ~] = kmeans(ab1,n,'distance','sqEuclidean', ...
    'Replicates',6);
pixel_labels = reshape(cluster_idx,nrows,ncols);
D = cell(1,n);
rgb_label = repmat(pixel_labels,[1 1 3]);
% Extract Images with One Label Highlighted
out = zeros(n,1);
for k = 1:n
    color = I1_prepro;
    color(rgb_label ~= k) = 0;
    idx=color==0;
    out(k)=sum(idx(:));
    D{k} = color;
end
% Extract Image with Information of Interest
[~,P] = max(out);
% Save as Reference Image for further Iterations
ref = D{P};
% Saving
dif_name = erase(I1_name, '0a_');
dif_name = erase(dif_name, '.jpg');
filename = [dif_name, '_TireGraveyard.jpg'];
imwrite(I1_prepro, ['processedData/',filename]);

end

