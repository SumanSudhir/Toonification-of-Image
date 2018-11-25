img = imread('data/images.jpeg');

figure(1),imshow(img,[]);

for l=1:3
pad = padarray(img(:,:,l),[3,3],0,'both');
[rows,colm] = size(img(:,:,l));
med = zeros(rows,colm);
    for i = 4:(rows+3)
        for j = 4:(colm+3)
        A = pad((i-3):(i+3),(j-3):(j+3));
        B = A(:);
        med((i-3),(j-3)) = median(B);
        end
    end
 filt_img(:,:,l) = med(:,:);
end


figure(5),imshow(uint8(filt_img));
    