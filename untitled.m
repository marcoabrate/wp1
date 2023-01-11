clear all;

im_dim = 720;

video_dir = "venv_blender/render_center/";
files = dir(video_dir);
files = files(~ismember({files.name},{'.','..'}));

video = zeros(im_dim, im_dim, length(files), 'uint8');

for i=1:length(files)
    file_name = files(i).name;
    disp(file_name);
    video(:,:,i) = rgb2gray(imread(strcat(video_dir, file_name)));
end

kernel_dir = "data_allen/gabor_filters_3d/";
files = dir(kernel_dir);
files = files(~ismember({files.name},{'.','..'}));

for i=1:length(files)
    file_name = files(i).name;
    disp(file_name);
    load(strcat(kernel_dir, file_name));
end

video_short = video(:,:,1:100);

video_conv = convn(video_short, k1, 'same');
video_conv_norm = video_conv - min(video_conv(:));
video_conv_norm = video_conv_norm ./ max(video_conv_norm(:));
save("video_conv/video_conv1.mat", "video_conv");

% save("video_conv/video_conv_norm1.mat", "video_conv_norm");