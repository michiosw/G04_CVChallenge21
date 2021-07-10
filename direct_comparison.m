function direct_comparison(path, environment, I1_name, I2_name)
%DIRECT_COMPARISON Summary of this function goes here
%   Detailed explanation goes here
addpath(path);

I1 = imread(I1_name);
I2 = imread(I2_name);

switch(environment)
    case 'Brazilian Rainforest'
        [I1_prepro, I2_prepro] = preprocessing_forest(I1, I2);
        change_detection_forest(1, I1_prepro, I2_prepro, I1_name, I2_name);
    case 'Glacier'
        [I1_prepro, I2_prepro] = preprocessing_glacier(I1, I2);
        change_detection_glacier(1, I1_prepro, I2_prepro, I1_name, I2_name);
    case 'Tire Graveyard'
        [I1_prepro, I2_prepro] = preprocessing_tire(I1, I2);
        change_detection_tire(1, I1_prepro, I2_prepro, I1_name, I2_name);
    case 'Dubai'
        change_detection_dubai(path);
    case 'Kuwait'
        change_detection_kuwait(path);
    case 'Frauenkirche'
        [I1_prepro, I2_prepro] = preprocessing_frauenkirche(I1, I2);
        change_detection_frauenkirche(I1_prepro, I2_prepro, I1_name, I2_name);
    case 'Wiesn'
        [I1_prepro, I2_prepro] = preprocessing_wiesn(I1, I2);
        change_detection_wiesn(I1_prepro, I2_prepro, I1_name, I2_name);
end

end

