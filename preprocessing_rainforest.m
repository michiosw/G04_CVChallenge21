function [I1_prepro, I2_prepro] = preprocessing_rainforest(i, I1, I2)
%PREPROCESSING: 
%   Preprocess images to facilitate change detection.
%   Input: reference image, comparison image
%   Preprocessing methods: histogram equalization, flat-field correction
%   and scale/rotation/translation reversion using SURF and MSAC
%   Output: Preprocessed reference image, preprocessed comparison image
%   (aligned in terms of scale/rotation/translation)

% works for Columbia Glacier

% Test 1: Image enhancement using dehazing technique

%I1_deh = imreducehaze(I1);
%I2_deh = imreducehaze(I2);

% Test 1.2 Local Contrast
%edgeThreshold = 0.4;
%amount = 0.5;
%I1_local = localcontrast(I1, edgeThreshold);
%I2_local = localcontrast(I2, amount);

% Test 2: Image Sharpening

I1_sharp = imsharpen(I1);
I2_sharp = imsharpen(I2);

% Test 3: Contrast adjustment

%n = 2;  
%I1double = im2double(I1); 
%avg1 = mean2(I1double);
%sigma1 = std2(I1double);
%I2double = im2double(I2); 
%avg2 = mean2(I2double);
%sigma2 = std2(I2double);

%I1_eq = imadjust(I1_sharp,[avg1-n*sigma1 avg1+n*sigma1],[]);
%I2_eq = imadjust(I2_sharp,[avg2-n*sigma2 avg2+n*sigma2],[]);

% 1. Histogram Equalization for Contrast Alignment

I1_eq = histeq(I1_sharp);
I2_eq = imhistmatch(I2_sharp,I1_eq);
%I2_eq = histeq(I2_sharp);

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
        matchedDistorted, matchedOriginal, 'similarity', 'MaxDistance', 3, 'MaxNumTrials', 100000, 'Confidence', 99.9999);

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

outputView = imref2d(size(I1_flat));
I2_rev  = imwarp(I2_flat,tform,'OutputView',outputView);

I1_prepro = I1_flat;
I2_prepro = I2_rev;


end

