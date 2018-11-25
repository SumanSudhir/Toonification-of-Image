
function sup = edgecolour()
img = imread('data/minion.jpg');
img = double(img);

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

theta = atan2(-Sxy, eigVal - Sy);
theta = theta*180/pi;

sup = zeros(rows,colm);

for i=2:(rows-1)
    for j=2:(colm-1)
        if (theta(i,j)>=-22.5 && theta(i,j) <=22.5) || (theta(i,j)>=-180 && theta(i,j) <=-157.5)
            if (edge(i,j) >= edge(i,j+1)) && (edge(i,j) >= edge(i,j-1))
               sup(i,j) = edge(i,j);
            end
            
        elseif (theta(i,j)>=22.5 && theta(i,j) <=67.5) || (theta(i,j)>=-157.5 && theta(i,j) <=-112.5)
            if (edge(i,j) >= edge(i+1,j+1)) && (edge(i,j) >= edge(i-1,j-1))
               sup(i,j) = edge(i,j);
            end
            
       elseif (theta(i,j)>=67.5 && theta(i,j) <=112.5) || (theta(i,j) >=-112.5 && theta(i,j) <=-67.5)
            if (edge(i,j) >= edge(i+1,j)) && (edge(i,j) >= edge(i-1,j))
               sup(i,j) = edge(i,j);
            end
   
       elseif (theta(i,j) >=112.5 && theta(i,j) <=157.5) || (theta(i,j) >=-67.5 && theta(i,j) <=-22.5)
            if (edge(i,j) >= edge(i+1,j-1)) && (edge(i,j) >= edge(i-1,j+1))
               sup(i,j) = edge(i,j);
            end
        end
    end
end

% sup(sup<0.08) = 0;
% sup(sup>=0.1) = 1;
%h = fspecial('gaussian',3,0.5);
%sup = imfilter(sup,h);
%edge(sup>0.11) = 1;


sup = sup/max(sup(:));
supp = sup;

low = 0.12;   %low thresold factor
high  = 0.2;   %high thresold factor

highthres  = max(sup(:))*high;
lowthres  = high*low;

weakRow = zeros(1,rows);
weakColm = zeros(1,colm);

strongRow = zeros(1,rows);
strongColm = zeros(1,colm);

strCount = 1;
weakCount = 1;


for i=2:(rows-1)
    for j = 2:(colm-1)
        if sup(i,j) > highthres
            sup(i,j) = 1;
            strongRow(strCount) = i;
            strongColm(strCount) = j;
            strCount = strCount+1;
            
            
        elseif sup(i,j) < lowthres
            sup(i,j) = 0;
            
            weakRow(weakCount) = i;
            weakColm(weakCount) = j;
            weakCount = weakCount+1;
         
        end
    end
end

figure(1),imshow(sup);
figure(2),imshow(edge);

for l = 1:strCount-1
    
    rowIndex = strongRow(l);
    colmIndex = strongColm(l);
   
    for i=-2:2
        for j = -2:2
           
            if ( rowIndex+i>0 && colmIndex+j > 0 && rowIndex+i <= rows && colmIndex+j<=colm)
                if (sup(rowIndex+i,colmIndex+j)>0) && (sup(rowIndex+i,colmIndex+j)<1)
                sup(rowIndex+i,colmIndex+j) = 1;
                
                end
            end
        end
    end
 end



for i = 1:weakCount-1
    if sup(weakRow(i),weakColm(i)) ~= 1
        sup(weakRow(i),weakColm(i)) = 0;
    end
end


figure(3),imshow(sup);

end