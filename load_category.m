function imageSet = load_category(days,category,indexStart,indexEnd)
   %returns array of images 
   imageSet{indexEnd}=0;
   directory = strcat(int2str(days)," Days/",category,"/");
   
   files = dir(directory);
   counter = 1;
   for i = indexStart:indexEnd
       try
            imageSet{counter} = image_load(directory,files(i+2).name);
       catch ME
            %disp(ME.identifier)
            if(strcmp(ME.identifier,'MATLAB:badsubscript'))
                disp("MESSAGE: >>>>>>>>>>> INDEX out of range, loaded valid indexes")
                imageSet2 = reduce_cell_array(imageSet,counter);
                clear imageSet
                imageSet = imageSet2;
                
            end
       end
            counter = counter+1;    
   end
end