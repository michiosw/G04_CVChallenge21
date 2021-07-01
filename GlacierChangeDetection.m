%Specify file path and name
files = dir('Datasets\ColumbiaGlacier\')
path = 'Datasets/ColumbiaGlacier/'
%%%Change Detection for Timeline
for k=4:length(files)
    
    %%Preprocessing
    I1 = imread([path files(3).name]);
    I2 = imread([path files(k).name]);

    I2_prepro = preprocess(I1, I2)
    
    %%Show Comparison
    
    %Greyscale
    ref = rgb2gray(I1)
    recovered = rgb2gray(I2_prepro)
    
    %Binarize Picture
    if k == 4
       bwImage=imbinarize(ref,0.7); 
    end
    bwImage2=imbinarize(recovered,0.7);  
    
    %Difference Comparison of Glacier 
    i = imfuse(bwImage,bwImage2,"ColorChannels","red");
    dif = imfuse(I1,i,'blend','Scaling', 'joint')
    
    %Saving
    dif_name = erase(files(k).name, '.jpg')
    imwrite(dif, [dif_name, '_dif.jpg'])
    
end
