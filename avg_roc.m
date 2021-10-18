function res = avg_roc(x1,x2,y1,y2)
    %this function calculates the Average Rate of Change of variable y with
    %respect to variable x
    
    change_in_y = y2-y1;
    change_in_x = x2-x1;
    
    res = change_in_y/change_in_x;
end