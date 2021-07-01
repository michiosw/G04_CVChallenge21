%% Preprocessing Workflow

%addpath(genpath('C:\Users\forst\Documents\Elektrotechnik TUM\MSEI\2. Semester\Computer Vision\Challenge\2_Datasets'));
addpath('C:\Users\forst\Documents\Elektrotechnik TUM\MSEI\2. Semester\Computer Vision\Challenge\2_Datasets\Kuwait');

I1 = imread("2015_02.jpg");
I2 = imread("2017_02.jpg");

[I1_prepro, I2_prepro] = preprocessing(I1, I2);

figure, imshowpair(I1_prepro, I2_prepro,'montage')


