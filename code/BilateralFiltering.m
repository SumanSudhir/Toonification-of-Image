function myimg = BilateralFiltering(inputimage)
tic;
imageOrig = inputimage;
n = 4;
Orig(:,:,1) = myShrinkImageByFactorD(imageOrig(:,:,1),n);
Orig(:,:,2) = myShrinkImageByFactorD(imageOrig(:,:,2),n);
Orig(:,:,3) = myShrinkImageByFactorD(imageOrig(:,:,3),n);
Orig = double(Orig);


global hs hi
hi=20;
hs=10;
iterations = 6;

ithresh = 2*hi;
sthresh = 2*hs;

size = (512/n)*(512/n);

imglist(1,:) = reshape(Orig(:,:,1),[1,size]);
imglist(2,:) = reshape(Orig(:,:,2),[1,size]);
imglist(3,:) = reshape(Orig(:,:,3),[1,size]);

xlist(:,1) = 1:(512/n);
ylist(1,:) = 1:(512/n);
imglist(4,:) = reshape(repmat(xlist,1,(512/n)),[1,size]);
imglist(5,:) = reshape(repmat(ylist,(512/n),1),[1,size]);



nextlist = imglist;

for count = 1:iterations
    imglist = nextlist;
    for i = 1:size

        vector = imglist(:,i).';
        
        window = imglist(:,abs(vector(4)-imglist(4,:))<=sthresh & abs(vector(5)-imglist(5,:))<=sthresh);
        window = window(:,abs(vector(1)-window(1,:))<=ithresh & abs(vector(2)-window(2,:))<=ithresh & abs(vector(3)-window(3,:))<=ithresh);

        dist = sqrdist(vector,window.');
        
        kernel_list = exp(-(dist)./2);
        
        kernel_list = kernel_list./sum(kernel_list);
        nextlist(1:3,i) = sum((window(1:3,:).*kernel_list).');

    end
end
myimg = reshape(nextlist(1:3,:).',[(512/n),(512/n),3]);

Orig = Orig./max(Orig(:));
myimg = myimg./max(myimg(:));

toc;
% figure(1),imshow(Orig);
% figure(2),imshow(myimg);
end

function d = sqrdist(vector,matrix)
    global hs hi
    r = size(matrix,1);
    diff = (repmat(vector,r,1)-matrix);
    diff(:,1:3) = diff(:,1:3)./hi;
    diff(:,4:5) = diff(:,4:5)./hs;
    d = sum((diff.^2).');
end
