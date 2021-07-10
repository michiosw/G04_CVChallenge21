function [I1_prepro, I2_prepro] = preprocessing_slow(I1, I2)
%PREPROCESSING: 
%   Preprocess images to facilitate change detection.
%   Input: reference image, comparison image
%   Preprocessing methods: histogram equalization, flat-field correction
%   and scale/rotation/translation reversion using SURF and MSAC
%   Output: Preprocessed reference image, preprocessed comparison image
%   (aligned in terms of scale/rotation/translation)

% Successful tests:
% Glacier
% Dubai
% Kuwait (also 2015-2018)
% Wiesn (also 2015-2021)
% Frauenkirche 2012_08-2015_08 / 2012-2018

% Unsuccessful tests:
% Rainforest
% Dubai 1990-2020

% 1. Histogram Equalization for Contrast Alignment

I1_eq = histeq(I1);
I2_eq = histeq(I2);

% 2. Flat-Field Correction (Gaussian Smoothing) to correct shading

sigma = 30;

I1_flat = imflatfield(I1_eq,sigma);
I2_flat = imflatfield(I2_eq,sigma);

% 3. Reversing scale, rotation, and translation differences in the set using:
% 3.1 Feature detection/matching (SURF) [1]

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
    matchedDistorted, matchedOriginal, 'similarity', 'MaxDistance', 3, 'MaxNumTrials', 10000, 'Confidence', 99.9999);

outputView = imref2d(size(I1));
I2_rev  = imwarp(I2,tform,'OutputView',outputView);

I1_prepro = I1;
I2_prepro = I2_rev;

end

