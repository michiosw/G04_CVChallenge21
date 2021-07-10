function change_detection_tire(i, I1_prepro, I2_prepro, I1_name, I2_name)
%CHANGE_DETECTION_TIRE Summary of this function goes here
%   Detailed explanation goes here
% Reading in all Images from the above specified File
if i == 1
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

I2_pca = double(I2_prepro);
X2 = reshape(I2_pca,size(I2_pca,1)*size(I2_pca,2),3);
coeff2 = pca(X2);
I2transformed = X2*coeff2;
ab = reshape(I2transformed(:,1),size(I2_pca,1),size(I2_pca,2));

% Preparing Data for K-Means
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,1);

% Number of Cluster
n = 2;

% K-Means Algorithm (depending on sqEuclidean; Number of Replicates?)
[cluster_idx, ~] = kmeans(ab,n,'distance','sqEuclidean', ...
    'Replicates',6);

% label for clusters reshaped to original image format
pixel_labels = reshape(cluster_idx,nrows,ncols);
D = cell(1,n);

% Clone 2D Labels to RGB 3D Label
rgb_label = repmat(pixel_labels,[1 1 3]);

% 2 out of 3 Clusters turned black in the Original Image
% (Generates 3 Images)
out = zeros(n,1);
for k = 1:n
    color = I2a;
    color(rgb_label ~= k) = 0;
    idx=color==0;
    out(k)=sum(idx(:));
    D{k} = color;
end

% Extract the picture with the maximum number of pixels in black (=0)
% (City of Dubai is clustered with one label --> less area than
% sea (cluster 2) and desert (cluster 3))
[~,P] = max(out);

% Display image stored in the variable D{P}
% D{P=Index for Image with most zeros}

k = D{P};
% Overlay processed and reference image
c = imfuse(ref, k, "ColorChannels","red");
% Difference Comparison by overlaying to original picture
dif = imfuse(I1,c, 'blend', 'Scaling', 'joint');

% Saving
dif_name = erase(I2_name, '.jpg');
filename = [dif_name, '_TireGraveyard.jpg'];
imwrite(dif, ['processedData/',filename]);

end

