function sequential_comparison(path, environment)
%SEQUENTIAL_COMPARISON Summary of this function goes here
%   Detailed explanation goes here

addpath(path);
images = dir([path '/*.jpg']);
num_images = size(images, 1);
I1_name = images(1).name;
I1 = imread(I1_name);

switch(environment)
    case 'Brazilian Rainforest'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            if i == 1
                ref = change_detection_rainforest_ref(I1, I1_name);
            end
            change_detection_rainforest(I1, I2, I2_name, ref, i);
        end    
    case 'Forest'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_slow(I1, I2);
            if i == 1
                ref = change_detection_tire_ref(I1_prepro, I1_name);
            end
            change_detection_tire(I1_prepro, I2_prepro, I2_name, ref);
        end
    case 'Tire Graveyard'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            if i == 1
                ref = change_detection_tire_ref(I1, I1_name);
            end
            change_detection_tire(I1, I2, I2_name, ref);
        end
    case 'Frauenkirche'
        change_detection_frauenkirche(path);
    case 'Wiesn'
        change_detection_wiesn(path);
    case 'Glacier'
        change_detection_glacier(path);
    case 'Dubai'
        change_detection_dubai(path);
    case 'Kuwait'
        change_detection_kuwait(path);
    case 'Solar'
        change_detection_solar(path);


end

