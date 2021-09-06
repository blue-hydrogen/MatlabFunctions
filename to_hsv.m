function hsv_imgs = to_hsv(imgs)
    %this function converts array of rgb imgs ro hsv

    %acccepts array of RGB images
    %then returns the array as HSV
    
    hsv_imgs{length(imgs)}=0;
    for i=1:length(imgs)
        hsv_imgs{i} = rgb2hsv(imgs{i});
    end
end