function change_detection_frauenkirche(path)
Nfile = numel(dir(path))-2;
file_struct = dir(path);
file_name = cell(1,Nfile);

% Read in Reference Image
file_name{1} = file_struct(3).name;
I1 = strcat(path,'\', file_name{1});
I1 = imread(I1);

% Start Segmenting Images
for i = 1:Nfile
    % Read in Images from Path
    file_name{i} = file_struct(i+2).name;
    I2 = strcat(path, '\', file_name{i});
    I2 = imread(I2);
    %Comparison
    if i == 1
        dif_name = erase(file_name{i}, '.jpg');
        imwrite(I1, [dif_name, '.jpg']);
    else
        [I1_prepro, I2_prepro] = preprocessing_frauenkirche(i-1,I1,I2);
        c = imfuse(I1_prepro, I2_prepro, "ColorChannels","red");
        %Saving
        dif_name = erase(file_name{i}, '.jpg');
        imwrite(c, [dif_name, '.jpg']);
    end

end
end

