Toonification: Cartoon Photo Effect Application

Project Proposal
1) Paper to be implemented
We plan on implementing the algorithm in the following paper as a starter: https://stacks.stanford.edu/file/druid:yt916dh6570/Dade_Toonify.pdf

 We will use simple bilateral filtering and edge detection at the beginning and will try to implement fast bilateral      filtering  as given here : http://people.csail.mit.edu/sparis/publi/2006/eccv/Paris_06_Fast_Approximation.pdf

 We will also try to make our algorithm work on generic images without changing the parameters

2) Dataset to be used:
https://drive.google.com/open?id=15LrR9C-bmTGtp9Gjj3-w14CopoGikwBb


3) Validation
Since the algorithm seeks to achieve an aesthetic goal, it will be difficult to evaluate its success. The algorithm should achieve large regions of continuous colour with a reduced colour palette. Also the edges should be highlighted without introducing small line clutter in the output image.

Final Work Done

Video by frames
Configured our phone camera to take snapshot using matlab and than to show the toonified result on it instantaneously.
We also applied it on video and through webcam

Edge detection:
First tried out finding the edge on each of the R G B components of Image but it was not working as some edges was not detected.Then we find out edges using structure tensor and  tried to get better edges by non maximal suppression and thresholding but
We get better view of toonified image without doing non maximal suppression as we need a thick edge in our image.
We built median filter in order to remove some higher or lower intensity pixel if we have to deal with image having salt and
pepper noise.

FBF:
Individual rgb FBF
Coloured image Fast bilateral filtering
Interpolation was a challenge, used only bilateral interpolation
Sampling in higher dimension reduces a lot of time.

It gives good result except on faces


