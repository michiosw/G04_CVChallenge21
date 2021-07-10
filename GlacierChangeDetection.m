clear all;
%Specify file path and name
files = dir('Datasets\ColumbiaGlacier\')
path = 'Datasets/ColumbiaGlacier/'
%%%Change Detection for Timeline
for k=4:length(files)
    
    %%Preprocessing
    I1 = imread([path files(3).name]);
    I2 = imread([path files(k).name]);

    [I1_prepro, I2_prepro] = preprocess(I1, I2);

    %%Show Comparison
    
    %Greyscale
    ref = rgb2gray(I1_prepro)
    I2_prepro =  rgb2gray(I2_prepro)
    
    %Binarize Picture
    bwImage=imbinarize(ref,0.7); 
    figure, imshow(bwImage);
    bwImage2=imbinarize(I2_prepro,0.7); 

    
    %Difference Comparison of Glacier 
    i = imfuse(bwImage,bwImage2,"ColorChannels","red");
    dif = imfuse(I1_prepro,i,'blend','Scaling', 'joint');
    %Saving
    dif_name = erase(files(k).name, '.jpg')
    imwrite(dif, [dif_name, '_glacier_dif.jpg'])
    
end
