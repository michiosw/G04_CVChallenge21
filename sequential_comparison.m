function sequential_comparison(path, environment)
%SEQUENTIAL_COMPARISON Summary of this function goes here
%   Detailed explanation goes here

addpath(path);
images = dir([path '/*.jpg']);
num_images = size(images, 1);
I1 = imread(images(1).name);

switch(environment)
    case 'Forest'
        for i = 1:(num_images-1)
            I2 = imread(images(i+1).name);
            [I1_prepro, I2_prepro] = preprocessing_forest(I1, I2);
            %change_detection_forest(I1_prepro, I2_prepro);
        end
    case 'Glacier'
        [I1_prepro, I2_prepro] = preprocessing_glacier(I1, I2);
        change_detection_glacier(I1_prepro, I2_prepro);
    case 'City'
        [I1_prepro, I2_prepro] = preprocessing_city(I1, I2);
        change_detection_city(I1_prepro, I2_prepro);
    case 'Sea'
        [I1_prepro, I2_prepro] = preprocessing_sea(I1, I2);
        change_detection_sea(I1_prepro, I2_prepro);
    case 'Waters'
        [I1_prepro, I2_prepro] = preprocessing_waters(I1, I2);
        change_detection_sea(I1_prepro, I2_prepro);
    case 'Tire Graveyard'
        [I1_prepro, I2_prepro] = preprocessing_waters(I1, I2);
        change_detection_sea(I1_prepro, I2_prepro);
    case 'Solar Plant'
        [I1_prepro, I2_prepro] = preprocessing_waters(I1, I2);
        change_detection_sea(I1_prepro, I2_prepro); 
end

