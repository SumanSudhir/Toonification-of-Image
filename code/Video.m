orig_video = VideoReader('original_3.mp4');
tooned_video = VideoWriter('output.avi');
scaled_orig = VideoWriter('scaled_original.avi');

tooned_video.FrameRate = orig_video.FrameRate;
scaled_orig.FrameRate = orig_video.FrameRate;

open(tooned_video);
open(scaled_orig);

while hasFrame(orig_video)
    [cartoon_img, orig_scaled] = Cartoonify(readFrame(orig_video));
    writeVideo(tooned_video,cartoon_img);
    writeVideo(scaled_orig,orig_scaled);
end    

close(tooned_video);
close(scaled_orig);
