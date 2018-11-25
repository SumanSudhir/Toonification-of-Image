%%
% 
%  RMSE based Comparison on baboon image
%  Using spacial sigma hs = 10;
%  And intensity sigma hi = 20;
%  
img = imread('../data/baboonColor.png');
output = BilateralFiltering(img);
[fast_output, scaled_orig] = FBF2(img);
RMSE = sqrt(sum((fast_output(:)-output(:)).^2))/sqrt(sum((output(:)).^2));
RMSE_plot = imread('../report/Report_for_Fast_Bilateral_Filtering/RMSE_plot.bmp');
Speed_Gain_Plot = imread('../report/Report_for_Fast_Bilateral_Filtering/Speed_Gain_Plot.bmp');
figure(3),imshow(RMSE_plot);
figure(4),imshow(Speed_Gain_Plot);
%%
% 
%  For Visual comparison for 6 iterations
%  1st figure is by normal bilateral filtering
%  2nd figure is by Fast Bilateral Filtering
% 
figure(1),imshow(output);
figure(2),imshow(fast_output);
