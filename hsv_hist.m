function hsv_hist(imgs,channel,color)
    %this function displays combined histogram of an array of hsv imgs

    %imgs - array of HSV images
    %channel - accepts integers 1,2,3 for channels Hue, Sat,and Val
    %color - 'r' for red, 'b' for blue, 'g' for green
    %read documentation for other colors
    
    figure
    hold on
    L = length(imgs);
    bins = 100+( (channel<2)*260 );
    for i=1:L
        histogram(imgs{i}(:,:,channel)*bins,bins+1,'DisplayStyle','Stairs','EdgeColor',color)
    end
end