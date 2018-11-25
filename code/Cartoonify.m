function [cartoon_img, scaled_orig] = Cartoonify(img)

%img = imread('../data/im_2.bmp');
[filtered, scaled_orig] = FBF2(img);
edges = edgecolour(scaled_orig);
edges = edges/max(edges(:));
cartoon_img = filtered;
%%
for i = 1:3
    t = filtered(:,:,i);
    t(edges>0.18) = 0;
    cartoon_img(:,:,i) = t;
end

% figure(1),imshow(cartoon_img);
% figure(2),imshow(scaled_orig);
% figure(3),imshow(filtered);
% figure(4),imshow(edges);

end