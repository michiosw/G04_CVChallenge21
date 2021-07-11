function preprocessing_switch(path, environment)
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
            [I1_prepro, I2_prepro] = preprocessing_rainforest(i, I1, I2);
            if i == 1
                dif_name = erase(I1_name, '.jpg');
                filename = [dif_name, '.jpg'];
                imwrite(I1_prepro, ['processedData/',filename]);
            end
            name = erase(I2_name, '.jpg');
            filename = [name, '.jpg'];
            imwrite(I2_prepro, ['processedData/',filename]);
        end    
    case 'Forest'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_slow(I1, I2);
            if i == 1
                dif_name = erase(I1_name, '.jpg');
                filename = [dif_name, '.jpg'];
                imwrite(I1_prepro, ['processedData/',filename]);
            end
            name = erase(I2_name, '.jpg');
            filename = [name, '.jpg'];
            imwrite(I2_prepro, ['processedData/',filename]);
        end
    case 'Glacier'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            I2_prepro = preprocessing_basic(I1, I2);
            if i == 1
                dif_name = erase(I1_name, '.jpg');
                filename = [dif_name, '.jpg'];
                imwrite(I1, ['processedData/',filename]);
            end
            name = erase(I2_name, '.jpg');
            filename = [name, '.jpg'];
            imwrite(I2_prepro, ['processedData/',filename]);
        end
    case 'Tire Graveyard'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_tire(I1, I2);
            if i == 1
                dif_name = erase(I1_name, '.jpg');
                filename = [dif_name, '.jpg'];
                imwrite(I1_prepro, ['processedData/',filename]);
            end
            name = erase(I2_name, '.jpg');
            filename = [name, '.jpg'];
            imwrite(I2_prepro, ['processedData/',filename]);
        end
    case 'Dubai'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            I2_prepro = preprocessing_basic(I1, I2, I2);
            if i == 1
                dif_name = erase(I1_name, '.jpg');
                filename = [dif_name, '.jpg'];
                imwrite(I1, ['processedData/',filename]);
            end
            name = erase(I2_name, '.jpg');
            filename = [name, '.jpg'];
            imwrite(I2_prepro, ['processedData/',filename]);
        end
    case 'Kuwait'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            I2_prepro = preprocessing_basic(I1, I2, I2);
            if i == 1
                dif_name = erase(I1_name, '.jpg');
                filename = [dif_name, '.jpg'];
                imwrite(I1, ['processedData/',filename]);
            end
            name = erase(I2_name, '.jpg');
            filename = [name, '.jpg'];
            imwrite(I2_prepro, ['processedData/',filename]);
        end
    case 'Frauenkirche'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_frauenkirche(I1, I2);
            if i == 1
                dif_name = erase(I1_name, '.jpg');
                filename = [dif_name, '.jpg'];
                imwrite(I1_prepro, ['processedData/',filename]);
            end
            name = erase(I2_name, '.jpg');
            filename = [name, '.jpg'];
            imwrite(I2_prepro, ['processedData/',filename]);
        end
    case 'Wiesn'
        for i = 1:(num_images-1)
            I2_name = images(i+1).name;
            I2 = imread(I2_name);
            [I1_prepro, I2_prepro] = preprocessing_wiesn(I1, I2);
            if i == 1
                dif_name = erase(I1_name, '.jpg');
                filename = [dif_name, '.jpg'];
                imwrite(I1_prepro, ['processedData/',filename]);
            end
            name = erase(I2_name, '.jpg');
            filename = [name, '.jpg'];
            imwrite(I2_prepro, ['processedData/',filename]);
        end
end