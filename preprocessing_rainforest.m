function [I1_prepro, I2_prepro] = preprocessing_rainforest(i, I1, I2, k)
%PREPROCESSING: 
%   Preprocess images to facilitate change detection.
%   Input: reference image, comparison image
%   Preprocessing methods: histogram equalization, flat-field correction
%   and scale/rotation/translation reversion using SURF and MSAC
%   Output: Preprocessed reference image, preprocessed comparison image
%   (aligned in terms of scale/rotation/translation)


% 1: Image Sharpening

I1_sharp = imsharpen(I1);
I2_sharp = imsharpen(I2);

% 2. Histogram Equalization for Contrast Alignment

I1_eq = histeq(I1_sharp);
I2_eq = histeq(I2_sharp);
%I2_eq = imhistmatch(I2_sharp,I1_eq);

% 2. Flat-Field Correction (Gaussian Smoothing) to correct shading

sigma = 30;

I1_flat = imflatfield(I1_eq,sigma);
I2_flat = imflatfield(I2_eq,sigma);

% 3. Reversing scale, rotation, and translation differences in the set using:
% 3.1 Feature detection/matching (SURF) [1]

if i < 3
    I1_gray = rgb2gray(I1_flat);
    I2_gray = rgb2gray(I2_flat);

    ptsOriginal  = detectSURFFeatures(I1_gray, 'MetricThreshold', 100);
    ptsDistorted = detectSURFFeatures(I2_gray, 'MetricThreshold', 100);

    [featuresOriginal,  validPtsOriginal]  = extractFeatures(I1_gray,  ptsOriginal);
    [featuresDistorted, validPtsDistorted] = extractFeatures(I2_gray, ptsDistorted);

    indexPairs = matchFeatures(featuresOriginal, featuresDistorted);

    matchedOriginal  = validPtsOriginal(indexPairs(:,1));
    matchedDistorted = validPtsDistorted(indexPairs(:,2));

    % 3.2 Robust estimation (MSAC) [2]

    tform = estimateGeometricTransform2D(...
        matchedDistorted, matchedOriginal, 'similarity', 'MaxDistance', 3, 'MaxNumTrials', 100000, 'Confidence', 99.999);

elseif i == 3
    tform = rotation(-35, -650, -10, 0.95);
elseif i == 4
    tform = rotation(-35, -625, 170, 1.05);
elseif i == 5
    tform = rotation(-15, -625, -5, 1.05);
elseif i == 6
    tform = rotation(68, -200, -850, 1.05);
elseif i == 7
    tform = rotation(17, -25, -119, 1.12);
end

outputView = imref2d(size(I1));
I2_rev  = imwarp(k,tform,'OutputView',outputView);


I2_prepro = I2_rev;

%Detect Black Pixel Mask
redChannel = I2_prepro(:, :, 1) ~= 0;
greenChannel = I2_prepro(:, :, 2) ~= 0;
blueChannel = I2_prepro(:, :, 3) ~= 0;
blackPixelImage = redChannel & greenChannel & blueChannel;

%Put Black Pixel Mask over Reference Picture
I1_prepro = bsxfun(@times, I1, cast(blackPixelImage, 'like', I1));



end
