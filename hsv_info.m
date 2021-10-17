function hsv_info(rgb_image)
    %accepts RGB image and displays Histogram of Hue, Sat, and Val
    
    hsv_image = rgb2hsv(rgb_image);
    figure
    subplot(1,3,1)
    histogram(hsv_image(:,:,1)*360,361,'DisplayStyle','Stairs','EdgeColor','r')
    title('HUE Channel')
    
    subplot(1,3,2)
    histogram(hsv_image(:,:,2)*100,101,'DisplayStyle','Stairs','EdgeColor','g')
    title('SAT Channel')
    
    subplot(1,3,3)
    histogram(hsv_image(:,:,3)*100,101,'DisplayStyle','Stairs','EdgeColor','b')
    title('VAL Channel')
end