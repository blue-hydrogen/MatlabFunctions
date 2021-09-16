function marked_image = mark_pixels(image_rgb,channel,lower_lim,upper_lim)
    %collects the position of every pixel that matches the given limit 
    %from specific channel 
    %then marks it by changing its color into
    %green
    
    %resize image from 100% to 6% of original size for faster runtime
    image_rgb = imresize(image_rgb,0.06);
    
    %create HSV copy of RGB image
    image_hsv = rgb2hsv(image_rgb);
    
    %create object for progress bar para makita kung nag hang ba hehe
    progress_bar = waitbar(0,'Starting');
    
    %get the dimentions of the given image
    %NOTE: the size of converted image and original are the same
    [rows, columns] = size(image_hsv(:,:,1));
    
    %changed the values of selected HSV channel
    %multiplied by 360 if selected channel is HUE
    %multiplied by 100 if selected channel is SATURATION or VALUE
    %notice the usage of relational operator
    image_hsv(:,:,channel) = image_hsv(:,:,channel)*(100+(260*(channel==1)));
    
    
    %traverse every pixel of the image
    for x=1:columns
        for y=1:rows
            %sets condition to find the pixel within the given range
            if( (image_hsv(y,x,channel)>=lower_lim)&&(image_hsv(y,x,channel)<=upper_lim) )
                
                %change the pixel of rgb_image into green
                image_rgb(y,x,1)=0;
                image_rgb(y,x,2)=255;
                image_rgb(y,x,3)=0;
            end
        end
        
        %update the progress bar everytime a column is fully traversed
        waitbar(x/columns, progress_bar, string(x/columns*100));
        pause(0.1);
    end
    
    %copy the mutated rgb_image to the output variable 'marked_image'
    marked_image = image_rgb;

    %close progress bar
    close(progress_bar)
    
    %display result in new figure window
    figure
    imshow(marked_image);
    
    switch channel
        case 1
            ch_name = "HUE"
        case 2
            ch_name = "SATURATION"
        case 3
            ch_name = "VALUE"
    end
    
    title(ch_name+" pixels in range "+string(lower_lim)+" to "+string(upper_lim))
    
end