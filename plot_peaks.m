function peak_points = plot_peaks(hsv,channel,steps,sma_period)
    %hsv is an hsv image
    %steps is the distance between two points when calculating slope
    %sma_period is simple moving average period

    peak_points = [];
    
    %create a figure
    figure
    
    %histcoutns is similar to histogram but it does not display a
    %histogram figure, it returns values similar to object histogram
    
    %Values - array of values in y-axis
    %edges - array of values in x-axis
    [Values, edges] = histcounts(hsv(:,:,channel),'Normalization','probability');
    
    %display original histogram, color blue
    histogram(hsv(:,:,channel),'DisplayStyle','Stairs','EdgeColor','b','Normalization','probability');
    hold on
    
    %copy Values in temporary variable
    %temp will be used as reference for simple moving average
    temp = Values;
    
    for i=1:length(temp)
        %replace elements of Values into simple moving average
        Values(i) = simple_ma(temp,i,sma_period);
    end
    
    %plot the graph of simple moving average, in red
    %the array size of Values is 200, and the array size of edges is 201
    %we started at 2nd index of edges to match the size of Values.
    plot(edges(2:end),Values,'r-')
    
    %finding_peak will serve as boolean a value
    finding_peak = 1;
    
    %variables for storing starting point of spike up
    peak_x = 0;
    peak_y = 0;
    
    
    function marked = identify_avg(x1,x2,y1,y2,avg)
        %marked is boolean value that will indicate if marking has been
        %done on the x,y point. it is the return value of this (identify_avg) function
        marked = 0;
        
        %when finding_peak is true, check for starting point of 
        %spike up (peak) of the slope
        if(finding_peak)
            
            %if slope is above 0.005 then it is a starting point
            if(avg>0.005)
                
                %mark the starting point of spike up
                %marked with red upright triangle
                plot(x1,y1,'r^','LineWidth',3)
                
                %save coordinate to set reference of end point 
                peak_x = x1;
                peak_y = y1;
                
                %mark second coordinate of the slope and add label
                %mark with red plus sign, then display values of slope
                plot(x2,y2,'r+')
                text(x2,y2+0.0012,string(avg),'FontSize',7)
                
                %invert value of finding_peak after marking,
                finding_peak =~ finding_peak;
                marked = 1;
            end
        %if finding_peak is false, then this means the function will 
        %check for a flatline value of slope
        else
            
            %we specified that a slope within the range of
            % -0.005 to +0.005 is a flatline or almost flatline
            if( (avg>=-0.005) && (avg<=0.005)   )
                
                %if almost flatline is identified then
                %check if the current coordinate is near the 
                %value of starting point of spike up
                if( (y2>=peak_y-0.0005) && (y2<=peak_y+0.0005) )
                    
                    %mark and label the end point of spike up
                    plot(x2,y2,'rv','LineWidth',3)
                    text(x2,y2+0.0012,string(avg),'FontSize',7)                

                    %save range of peak_points
                    peak_points = [peak_points;peak_x x2];
                    
                    %invert finding_peak after marking
                    finding_peak = ~finding_peak;
                    marked = 1;
                end
            end
        end
    end
    
    %calculate and slope or rate of change in first index of Values
    x1 = edges(1);
    x2 = edges(2);
    y1 = 0;
    y2 = Values(1);
    
    avg = avg_roc(x1,x2,y1,y2);
    
    %stack displays on the created figure
    hold on
    
    %if slope is not identified as starting or end point in indentify_avg
    %then it will be marked in this block of 'if statement'
    if(identify_avg(x1,x2,y1,y2,avg)==0)
        
        %mark slope with red plus sign, then display value of slope
        plot(x2,y2,'r+')
        text(x2,y2+0.0012,string(avg),'FontSize',7)
    end    
    
    %create array of indexes incrementing by the number of steps
    if(mod(length(Values),steps)~=0)
        indexes = 1:steps:length(Values);
        indexes = [indexes length(Values)];
    else
        indexes = 1:steps:length(Values);
    end
    
    
    for i=1:length(indexes)-1
        
%         if( size(peak_points,1)==2 )
%             return
%         end
        
        x1 = edges(indexes(i)+1);
        x2 = edges(indexes(i+1)+1);
        y1 = Values(indexes(i));
        y2 = Values(indexes(i+1));
            
        %get average rate of change
        avg = avg_roc(x1,x2,y1,y2);

        if(identify_avg(x1,x2,y1,y2,avg)==0)
            %mark the point in histogram
            plot(x2,y2,'r+','LineWidth',1)

            %print label on top of the marking
            text(x2,y2+0.0012,string(avg),'FontSize',7)
        end
    end
    
%     if( finding_peak==0 && size(peak_points,1)<2 )
%         peak_points = [peak_points;peak_x edges(end)];
%         plot(edges(end),Values(end),'r^','LineWidth',3)
%     end
    
    if( finding_peak==0 )
        peak_points = [peak_points;peak_x edges(end)];
        plot(edges(end),Values(end),'rv','LineWidth',3)
    end
end