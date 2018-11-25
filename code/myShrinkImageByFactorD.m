function output = myShrinkImageByFactorD(a,d)
% A = '../data/circles_concentric';
% b = imread(A,'png');

%d = 3;
filt = fspecial('gaussian',5,1);
b = imfilter(a,filt);

r = floor(size(b,1)/d);
c = floor(size(b,2)/d);

m = zeros(r,c,'double');
m(1:r,1:c) = b(d:d:d*r,d:d:d*c);

output = m;

% figure(1),imshow(b);
% title('Original Image');
% colorbar('southoutside');
% figure(2),imshow(m);
% title('Shrunken Image');
% colorbar('southoutside');
end
