
function [filtered,scaled_orig] = FBF2(input_image)
%tic;
imageOrig = input_image;
% h = fspecial('gaussian',5,1.4);
% imageOrig = imfilter(imageOrig,h);
n = 1;
Orig(:,:,1) = myShrinkImageByFactorD(imageOrig(:,:,1),n);
Orig(:,:,2) = myShrinkImageByFactorD(imageOrig(:,:,2),n);
Orig(:,:,3) = myShrinkImageByFactorD(imageOrig(:,:,3),n);
Orig = double(Orig);

p = size(Orig,1);
q = size(Orig,2);

ni = 15;
ns = 15;
global hs hi
hi=1.25;
hs=0.75;
iterations = 3;

ithresh = 2*hi;
sthresh = 2*hs;
sfilt = fspecial('gaussian',2*sthresh+1,hs);
tfilt(:,:) = fspecial('gaussian',2*ithresh+1,hi);
for arr = 1:2*ithresh+1
%     ifilt(arr) = gaussmf(arr,[hi 1+ithresh]);
    ifilt(1,1,:,:,arr) = tfilt(:,:)*gaussmf(arr,[hi 1+ithresh]);
end
for i = 1:2*sthresh+1
    for j = 1:2*sthresh+1
        filt(i,j,:,:,:) = ifilt * sfilt(i,j);
    end
end
filt = filt/sum(filt(:));
%%
final = double(Orig);
for count = 1:iterations
temp = final;
img_w = zeros(ceil((p)/ns)+1,ceil((q)/ns)+1,ceil(256/ni)+1,ceil(256/ni)+1,ceil(256/ni)+1,4);
img_w = double(img_w);
for i = 1:(p)
    for j = 1:(q)
        x = ceil(i/ns);
        y = ceil(j/ns);
        c(:) = ceil(temp(i,j,:)/ni);
        c = c+[1,1,1];
        img_w(x,y,c(1),c(2),c(3),1) = img_w(x,y,c(1),c(2),c(3),1) + temp(i,j,1);
        img_w(x,y,c(1),c(2),c(3),2) = img_w(x,y,c(1),c(2),c(3),2) + temp(i,j,2);
        img_w(x,y,c(1),c(2),c(3),3) = img_w(x,y,c(1),c(2),c(3),3) + temp(i,j,3);
        img_w(x,y,c(1),c(2),c(3),4) = img_w(x,y,c(1),c(2),c(3),4) + 1;
    end
end

newimg_w = imfilter(img_w,filt);

for i = 1:(p)
    for j = 1:(q)
        x = ceil(i/ns);
        y = ceil(j/ns);
        c(:) = ceil(temp(i,j,:)/ni);
        c = c+[1,1,1];
        vec1(:) = (x*ns-i)*(y*ns-j)*newimg_w(x,y,c(1),c(2),c(3),:) + (x*ns-i)*(j+ns-y*ns)*newimg_w(x,y+1,c(1),c(2),c(3),:);
        vec2(:) = (i+ns-x*ns)*(y*ns-j)*newimg_w(x+1,y,c(1),c(2),c(3),:) + (i+ns-x*ns)*(j+ns-y*ns)*newimg_w(x+1,y+1,c(1),c(2),c(3),:);
        vec = vec1 + vec2;
        if (vec == [0,0,0,0])
            vec = newimg_w(x,y,c(1),c(2),c(3),:);
        end
        final(i,j,:) = vec(1:3)/vec(4);
    end
end
end


Orig = Orig/max(Orig(:));
final = final/max(final(:));
%toc;
%%
%figure(1),imshow(Orig);
%figure(2), imshow(final);
filtered = final;
scaled_orig = Orig;
end