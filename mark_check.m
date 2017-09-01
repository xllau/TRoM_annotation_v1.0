%%%%%%%%%%%%%%%%%%----- CREAT MASK FOR THE REFERENCE FRAME
figure;


list = 1:94;
for i = 13:1:size(list,2)
    name = sprintf('./image_2/umm_%06d.png',list(i))
    image = imread(name);
    name = sprintf('./gt_image/umm_road_%06d.png',list(i))
    gt =  imread(name);
    idx = find(gt == 1);
    image_b = image(:,:,2);
    image_b(gt == 1) = 200;
    image(:,:,2) = image_b;
    imshow(image);
    
    pause
end
