function change_detection_wiesn(path)

Nfile = numel(dir(path))-2;
file_struct = dir(path);
file_name = cell(1,Nfile);

% Read in Reference Image
file_name{1} = file_struct(3).name;
ref = strcat(path, file_name{1});
ref = imread(ref);

% Start Segmenting Images
for i = 2:Nfile
    % Read in Images from Path
    file_name{i} = file_struct(i+2).name;
    I1 = strcat(path, file_name{i-1});
    I1 = imread(I1);
    I2 = strcat(path, file_name{i});
    I2 = imread(I2);
    
    %%Show Comparison
    [~, I1_prepro] = preprocessing_wiesn(ref, I1);
    [I1_ref, I2_prepro] = preprocessing_wiesn(I1_prepro, I2);    
    
    %Difference Comparison of Glacier 
    k = imfuse(I1_ref,I2_prepro,"ColorChannels","red");
    %Saving
    if i == 2
        dif_name = erase(file_name{i-1}, '0a_');
        imwrite(ref, ['processedData/',dif_name]);
    end
    imwrite(k, ['processedData/', file_name{i}]);
    
end
end