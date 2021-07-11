function change_detection_dubai(path)
%CHANGEDETECTIONDUBAI Summary of this function goes here
%   Detailed explanation goes here

% Reading in all Images from the above specified File
Nfile = numel(dir(path))-2;
file_struct = dir(path);
file_name = cell(1,Nfile);

% Read in Reference Image
file_name{1} = file_struct(3).name;
I1 = strcat(path, file_name{1});
I1 = imread(I1);

% Start Segmenting Images
for i = 1:Nfile
    % Read in Images from Path
    file_name{i} = file_struct(i+2).name;
    I2 = strcat(path, file_name{i});
    I2 = imread(I2);
    
    %PCA
    I2_pca = double(I2);
    X2 = reshape(I2_pca,size(I2_pca,1)*size(I2_pca,2),3);
    coeff2 = pca(X2);
    I2transformed = X2*coeff2;
    ab = reshape(I2transformed(:,1),size(I2_pca,1),size(I2_pca,2));
    
    % Preparing Data for K-Means
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,1);
    
    % Number of Cluster
    n = 3;
    
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
        color = I2;
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
    %Set the first picture as reference picture
    if i == 1
        ref1 = D{P};
        dif_name = erase(file_name{i}, '0a_');
        dif_name = erase(dif_name, '.jpg');
        filename = [dif_name, '.jpg'];
        imwrite(I1, ['processedData/',filename]);
    else
        k = D{P};
        %Set the correct reference picture
        I2_prepro = preprocessing_basic(I1,I2,k);
        
        %Overlay processed and reference image
        c = imfuse(ref1, I2_prepro, "ColorChannels","red");
        
        %Difference Comparison by overlaying to original picture
        dif = imfuse(I1, c, 'blend', 'Scaling', 'joint');
        
        % Saving
        dif_name = erase(file_name{i}, '.jpg');
        filename = [dif_name, '.jpg'];
        imwrite(dif, ['processedData/',filename]);
    end
end
end

