function hsv_info_picker(abs_directory, days, channel)
    %from a given egg days this function selects 5 random images in each of 4 random category
    %and displays the images histogram based on the specified hsv channel.
    %20 histograms will be displayed in a single figure using 'subplot'
    %function with the dimention of 4 rows and 5 columns.
    
    %number of bins for histogram, number of bins depends on hsv channel
    bins = 100+( (channel<2)*260 );
    
    %set working directory
    working_dir = strcat(abs_directory,"\",int2str(days)," Days");
    
    %get list of categories in working directory
    categories = list_folders(working_dir);
    
    %get number of categories
    num_cat = length(categories);

    %set counter for image displayed
    img_displayed = 0;
    
    %create display figure
    figure
    
    %create object for progress bar para makita kung nag hang ba hehe
    progress_bar = waitbar(0,'Starting');


    %loop 4 times for selecting 4 random categories
    for h=1:4

        %select random category 
        cat = categories( floor(rand(1)*num_cat+1) );

        %store address of selected category
        cat_dir = strcat(working_dir,"\",cat);

        %get list of image names in selected category
        image_names = dir(strcat(cat_dir,"\*.jpg"));

        %select and display 5 random images from category
        for i=1:5

            %get random integer from 1 to total number of image_names
            img_index = floor(rand(1)*length(image_names)+1);

            %load image then convert to hsv
            img = image_load(strcat(cat_dir,"\"),image_names(img_index).name);
            img = rgb2hsv(img);

            %select a subplot of the figure
            subplot(4,5,img_displayed+1)

            %display histogram of specified channel
            histogram(img(:,:,channel)*bins,bins+1,'DisplayStyle','Stairs','EdgeColor','r')
            img_displayed = img_displayed+1;
            title(strcat(cat," - ",image_names(img_index).name))

            %update the progress bar everytime an image is displayed
            waitbar(img_displayed/20, progress_bar, string(img_displayed/20*100));
            pause(0.1);

        end
    end
    
    %close progress bar
    close(progress_bar)

%     imahe = [];
%     for j=1:length(image_names)
%         imahe = [imahe;convertCharsToStrings(image_names(j).name)];
%     end
%     
%     disp(cat)
%     disp(imahe)
end