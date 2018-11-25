
function cartoondataset()
dirPath = '..\data';
for i = 1:1
    dir = strcat(dirPath,"/","im_",num2str(i));
        image = strcat(dir,".bmp");
        A = double(imread(image,'bmp'));
        
        [cartoon_img, orig_scaled] = Cartoonify(A);
        %figure(i),imshow(orig_scaled);
        figure(i),imshow(cartoon_img);
     
end
end