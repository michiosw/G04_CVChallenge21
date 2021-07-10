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
            [I1_prepro, I2_prepro] = preprocessing_slow(i, I1, I2);
            change_detection_forest(i, I1_prepro, I2_prepro, I1_name, I2_name);
        end
    case 'Glacier'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_glacier(I1, I2);
            change_detection_glacier(i, I1_prepro, I2_prepro, I1_name, I2_name);
        end
    case 'Tire Graveyard'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_tire(I1, I2);
            if i == 1
                ref = change_detection_tire_ref(I1_prepro, I1_name);
            end
            change_detection_tire(I1_prepro, I2_prepro, I2_name, ref);
        end
    case 'Dubai'
        change_detection_dubai(path);
    case 'Kuwait'
        change_detection_kuwait(path);
    case 'Frauenkirche'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_frauenkirche(i, I1, I2);
            % only for development purposes
            figure, imshowpair(I1_prepro, I2_prepro,'montage')
            % change_detection_frauenkirche(i, I1_prepro, I2_prepro, I1_name, I2_name);
        end
    case 'Wiesn'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_wiesn(I1, I2);
            % only for development purposes
            figure, imshowpair(I1_prepro, I2_prepro,'montage')
            %change_detection_wiesn(i, I1_prepro, I2_prepro, I1_name, I2_name);
        end
end

