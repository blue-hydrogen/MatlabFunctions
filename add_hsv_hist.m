function add_hsv_hist(imgs,channel,fignum,color)
    %displays hsv_histogram to a specific figure
    
    figure(fignum)
    hold on
    bins = 100+( (channel<2)*260 );
    for i=1:length(imgs)
        hold on
        histogram(imgs{i}(:,:,channel)*bins,bins,'DisplayStyle','Stairs','EdgeColor',color)
    end
end