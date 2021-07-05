function direct_comparison(path, environment, I1_name, I2_name)
%DIRECT_COMPARISON Summary of this function goes here
%   Detailed explanation goes here
addpath(path);

I1 = imread(I1_name);
I2 = imread(I2_name);

switch(environment)
    case 'Forest'
        [I1_prepro, I2_prepro] = preprocessing_forest(I1, I2);
        change_detection_forest(I1_prepro, I2_prepro);
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
        [I1_prepro, I2_prepro] = preprocessing_tiregraveyard(I1, I2);
        change_detection_sea(I1_prepro, I2_prepro);
    case 'Solar Plant'
        [I1_prepro, I2_prepro] = preprocessing_solarplant(I1, I2);
        change_detection_sea(I1_prepro, I2_prepro);
end

end

