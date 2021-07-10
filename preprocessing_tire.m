function [I1_prepro, I2_prepro] = preprocessing_tire(I1, I2)
%PREPROCESSING: 
%   Preprocess images to facilitate change detection.
%   Input: reference image, comparison image
%   Preprocessing methods: histogram equalization, flat-field correction
%   and scale/rotation/translation reversion using SURF and MSAC
%   Output: Preprocessed reference image, preprocessed comparison image
%   (aligned in terms of scale/rotation/translation)

% 1. Image Sharpening

I1_sharp = imsharpen(I1);
I2_sharp = imsharpen(I2);

% 2. Histogram Equalization for Contrast Alignment

I1_eq = histeq(I1_sharp);
I2_eq = histeq(I2_sharp);

% 3. Flat-Field Correction (Gaussian Smoothing) to correct shading

sigma = 30;

I1_flat = imflatfield(I1_eq,sigma);
I2_flat = imflatfield(I2_eq,sigma);

I1_prepro = I1_flat;
I2_prepro = I2_flat;


end

