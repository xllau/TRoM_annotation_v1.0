    
path_image =  '.\image\';
path_list = '.\list.txt';
path_save = '.\gt\';
list = char(list_cell);
list_cell = textread(path_list,'%s');

for i = 1:size(list,1)
    index = i;
    img=imread([path_image list(index,:)]);

    filename_gt = [path_save 'gt_' list(index,:)]
    gt_img = imread(filename_gt);

    imwrite(gt_img,[path_save  'gt_'  list(index,1:15) 'png'], 'Mode', 'lossless');
end