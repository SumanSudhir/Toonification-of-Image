
function edge = edgecolour(input_img)
%img = imread('data/minion.jpg');
img = double(input_img);

%h = fspecial('gaussian',5,1.4);
%img = imfilter(img,h);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

[rows,colm] = size(R);

[Rx,Ry] = gradient(R);
[Gx,Gy] = gradient(G);
[Bx,By] = gradient(B);

Sx = Rx.^2+Gx.^2+Bx.^2;
Sy = Ry.^2+Gy.^2+By.^2;
Sxy = Rx.*Ry+Gx.*Gy+Bx.*By;

D = sqrt(abs((Sx+Sy).^2-4*(Sx.*Sy-Sxy.^2)));   %Discriminant of 2x2 matrix

eigVal = (Sx+Sy+D)/2;
eigVal2 = (Sx+Sy-D)/2;     %non real

edge  = sqrt(eigVal);

end