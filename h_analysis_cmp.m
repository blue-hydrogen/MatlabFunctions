function h_analysis_cmp(imgs1,imgs2,channel)
    figure
    hold on
    L1 = length(imgs1);
    L2 = length(imgs2);
    bins = 100+( (channel<2)*260 );
    
    for i=1:L2
        histogram(imgs1{i}(:,:,channel)*bins,bins,'DisplayStyle','Stairs','EdgeColor','r')
        histogram(imgs2{i}(:,:,channel)*bins,bins,'DisplayStyle','Stairs','EdgeColor','b')
    end
    
    title("hue cmp of g1 and g2")
end