clc; clear; close all;
% Default var
profile = 'Motion JPEG AVI'; % Use 'doc VideoWriter' for more profile info

% Use the menu to change these parameters
vid_length = 0; % Initial video length
vid_FPS = 3;   % Default FPS
vid_qual = 75;  % Default video quality
vid_scf = 1;    % Default scale factor
Nfile = 0;      % Initial number of file

% Specify your Image Directory 
% For the implementing of the code in the GUI Shanghai needs to be adjustable to other scenarios)
file_path = 'PersonalDatasets/Shanghai/';
Nfile = numel(dir(file_path))-2;
file_struct = dir(file_path);
%Specify your Video Directory
avi_path = 'PersonalDatasets/Shanghai';
avi_name = 'timelapse';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reading in images of choice (name of images) & determine video length
file_name = cell(1,Nfile);
for i=1:Nfile
    file_name{i} = file_struct(i+2).name;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select video file location

actual_file = strcat(avi_path, avi_name);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate video parameter
vid_length = Nfile / vid_FPS;
aviobj = VideoWriter('PersonalDatasets/Shanghai/timelapse.avi');
aviobj.FrameRate = vid_FPS;
%aviobj.Quality = vid_qual;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BUILD VIDEO

if Nfile == 0
    errordlg('No images selected')
else
    open(aviobj)
    wb = waitbar(0, 'Please wait...');
    for i = 1:Nfile
        img = imread(strcat(file_path, file_name{i}));
        if vid_scf ~= 1
            img = imresize(img, vid_scf);
        end
        writeVideo(aviobj, img);
        % Preview image
        if mod(i, round(Nfile/10)) == 1
            imshow(img)
            title(sprintf('Preview image %d/%d', i, Nfile))
            uistack(wb, 'top')
        end
        waitbar(i/Nfile, wb);
    end
    delete(wb)
    close(aviobj);
end