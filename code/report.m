%%
%It gives good result except on faces 
%We applied it on video and also through webcam 
%We tried edge detection on each of the R G B components of Image but it 
%was not giving the desired result as some edges were not detected so
%finally we used the coloured edge detection method using the structure
%tensor
%Fast Bilateral filtering is used for segmentation.
%
%Here are the some reults using the following parameter values:
%ni (sampling rate in intensity axes) = 15;
%ns (sampling rate in spacial axes) = 15;
%hi (intensity sigma in sampled space) =1.25;
%hs (spacial sigma in sampled space) =0.75;
%iterations = 3;
%threshold used for edge detection in Cartoonify() = 0.18;

cartoondataset()