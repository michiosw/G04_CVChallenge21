clc; clear; close all;

path = 'Datasets/Dubai/';

% Classify the Environment: Find it in the string path :D
% k = strfind(path, 'Dubai');

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
    I = strcat(path, file_name{i});
    % Preprocessing function (starting with the Second Image)
    I = imread(I);
    if i>=2
        I = preprocess(I1,I);
    end
    
    % not needed
    % I = rgb2gray(I);
    
    % Preparing Data for K-Means
    cform = makecform('srgb2lab');
    hi = applycform(I,cform);
    ab = double(hi(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    
    % Number of Cluster
    n = 3;
    
    % K-Means Algorithm (depending on sqEuclidean; Number of Replicates?)
    [cluster_idx, cluster_center] = kmeans(ab,n,'distance','sqEuclidean', ...
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
        color = I;
        color(rgb_label ~= k) = 0;
        idx=color==0;
        out(k)=sum(idx(:));
        D{k} = color;
    end
    
    % Extract the picture with the maximum number of pixels in black (=0)
    % (City of Dubai is clustered with one label --> less area than
    % sea (cluster 2) and desert (cluster 3))
    [M,P] = max(out);
    
    % Display image stored in the variable D{P}
    % D{P=Index for Image with most zeros}
    figure(i)
    imshow(D{P})
end