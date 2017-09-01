%%%%%%%%%%%%%%%%%%----- CREAT MASK FOR THE REFERENCE FRAME
figure;

%frame data and show
%list = [3,4,11,50,51,61,66,69,71,73,74,78,79,80,87,90,91,92,93]
list = 57:99;
%list = [35,
%list = [0]
%list = [14,18,28,29,30,42,56,59]
for i = 1:1:size(list,2)
    name = sprintf('./image_2/uu_%06d.png',list(i))
    frame1 = imread(name);
    imshow(frame1);

    % %draw roi 1
    % title('first component');
    % h = imfreehand;
    % position = wait(h); % position represents the roi data
    % mask1 = createMask(h);
    
    title(sprintf('um-%06d.png',list(i)))
    h = impoly;
    position = wait(h);
    mask = createMask(h);
    imshow(mask)

    name_save = sprintf('./gt_image/uu_road_%06d.png',list(i))
    imwrite(mask,name_save);
    display(name_save)
    pause(0.5)
end
