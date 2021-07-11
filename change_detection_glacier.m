function change_detection_glacier(path)
%CHANGE_DETECTION_GLACIER Summary of this function goes here
%   Detailed explanation goes here

Nfile = numel(dir(path))-2;
file_struct = dir(path);
file_name = cell(1,Nfile);

% Read in Reference Image
file_name{1} = file_struct(3).name;
I1 = strcat(path, file_name{1});
I1 = imread(I1);

% Start Segmenting Images
for i = 2:Nfile
    % Read in Images from Path
    file_name{i} = file_struct(i+2).name;
    I2 = strcat(path, file_name{i});
    I2 = imread(I2);
    
    [I1_prepro, I2_prepro] = preprocessing_glacier(I1, I2);
    
    ref = rgb2gray(I1_prepro);
    bwImage = imbinarize(ref,0.7);
    
    if i == 2
        dif_name = erase(file_name{1}, '0a_');
        dif_name = erase(dif_name, '.jpg');
        filename = [dif_name, '.jpg'];
        imwrite(I1, ['processedData/',filename]);
    end
    
    I2_prepro =  rgb2gray(I2_prepro);
    bwImage2 = imbinarize(I2_prepro,0.7);
    
    %Difference Comparison of Glacier 
    c = imfuse(bwImage,bwImage2,"ColorChannels","red");
    dif = imfuse(I1_prepro,c,'blend','Scaling', 'joint');
    %Saving
    dif_name = erase(file_name{i}, '.jpg');
    filename = [dif_name, '.jpg'];
    imwrite(dif, ['processedData/',filename]);
        
end
end

