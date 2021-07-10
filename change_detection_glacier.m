function change_detection_glacier(i, I1_prepro, I2_prepro, I1_name, I2_name)
%CHANGE_DETECTION_GLACIER Summary of this function goes here
%   Detailed explanation goes here

% Grayscale & Binarize Image
% Setting first Image as Reference Image
ref = rgb2gray(I1_prepro);
bwImage = imbinarize(ref,0.7);
    
if i == 1
    % Saving
    dif_name = erase(I1_name, '0a_');
    dif_name = erase(dif_name, '.jpg');
    filename = [dif_name, '_TireGraveyard.jpg'];
    imwrite(I1_prepro, ['processedData/',filename]);
end

recovered = rgb2gray(I2_prepro);
bwImage2 = imbinarize(recovered,0.7);

%Difference Comparison of Glacier
c = imfuse(bwImage,bwImage2,"ColorChannels","red");
dif = imfuse(I1_prepro,c,'blend','Scaling', 'joint');

%Saving
dif_name = erase(I2_name, '.jpg');
imwrite(dif, ['processedData/', dif_name, '_dif.jpg']);
end

