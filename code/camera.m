clear

mycam = ipcam('http://192.168.31.164:8080/video')

%cam = webcam
img = snapshot(mycam);
figure(1),imshow(img);
[cartoon_img, orig_scaled] = Cartoonify(img);
figure(4),imshow(cartoon_img);