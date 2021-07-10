clear all;
%Specify file path and name
files = dir('Datasets\Wiesn\');
path = 'Datasets/Wiesn/';

ref = imread([path files(3).name]);

%%%Change Detection for Timeline
for k=4:length(files)
    %%Preprocessing
    I1 = imread([path files(k-1).name]);
    I2 = imread([path files(k).name]);
    
    %%Show Comparison
    [~, I1_prepro] = preprocessing_wiesn(ref, I1);
    [I1_ref, I2_prepro] = preprocessing_wiesn(I1_prepro, I2);    
    
    %Difference Comparison of Glacier 
    i = imfuse(I1_ref,I2_prepro,"ColorChannels","red");
    figure, imshow(i);
    %Saving
    dif_name = erase(files(k).name, '.jpg');
    imwrite(dif, [dif_name, '_wiesn_dif.jpg']);
    
end
