function [I1_prepro, I2_prepro] = preprocessing_glacier(I1, I2)
%PREPROCESSING: 
%   Preprocess images to facilitate change detection.
%   Input: reference image, comparison image
%   Preprocessing methods: histogram equalization, flat-field correction
%   and scale/rotation/translation reversion using SURF and MSAC
%   Output: Preprocessed reference image, preprocessed comparison image
%   (aligned in terms of scale/rotation/translation)

% works for Columbia Glacier

% 1. Image Sharpening

I1_sharp = imsharpen(I1);
I2_sharp = imsharpen(I2);

% 2. Reversing scale, rotation, and translation differences in the set using:
% 2.1 Feature detection/matching (SURF) [1]

I1_gray = rgb2gray(I1_sharp);
I2_gray = rgb2gray(I2_sharp);

ptsOriginal  = detectSURFFeatures(I1_gray);
ptsDistorted = detectSURFFeatures(I2_gray);

[featuresOriginal,  validPtsOriginal]  = extractFeatures(I1_gray,  ptsOriginal);
[featuresDistorted, validPtsDistorted] = extractFeatures(I2_gray, ptsDistorted);

indexPairs = matchFeatures(featuresOriginal, featuresDistorted);

matchedOriginal  = validPtsOriginal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));

% 2.2 Robust estimation (MSAC) [2]

tform = estimateGeometricTransform2D(...
    matchedDistorted, matchedOriginal, 'similarity');

outputView = imref2d(size(I1_sharp));
I2_rev  = imwarp(I2_sharp,tform,'OutputView',outputView);

I1_prepro = I1_sharp;
I2_prepro = I2_rev;


end

