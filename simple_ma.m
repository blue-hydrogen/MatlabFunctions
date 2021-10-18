function res = simple_ma(data,index,period)
    %simple_ma means 'simple moving average'
    
    %data should be an array
    %index - where the calculation should start
    %period - number of periods before the index
    
    %Definition of SMA
    %The Simple Moving Average (SMA) is calculated by adding the price 
    %of an instrument over a number of time periods and then dividing the 
    %sum by the number of time periods. The SMA is basically the average 
    %price of the given time period, with equal weighting given to the 
    %price of each period.
    
    %SMA is commonly used in Trading

    sum = 0;
    
    %check if index is within the bounds
    if(index > length(data) )
       disp("index out of bounds")
       return
    end
    
    if( (index-period)>=1 )
        start_index = index-period;
    else
        start_index = 1;
        period = index;
    end
    
    %calculate SMA
    for i=start_index:index
       sum = sum+data(i);
    end
    
    res = sum/period;
end