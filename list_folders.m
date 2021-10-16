function dir_folders = list_folders(abs_directory)
    %this function returns the list of directories in a specific directory
    %abs_directory is means absolute directory
    
    %NOTE: the term 'directory' and 'folder' are user interchangeably

    %get list of items in the absolute directory
    dir_files = dir(abs_directory);
    
    %check if address is valid
    if( isempty(dir_files) )
        disp('invalid address')
        return
    end

    %set container variable for folder names
    dir_folders = [];
    
    %set excluded directories
    %directory names that ends with these elements are excluded
    %these are usually system hidden folders
    exclude_dir = ['.','.git'];   
    
    
    %-----------------------------------------------------------
    %create function to check if folder is valid
    function res = is_valid(folder_name)
        %set result as true (boolean)
        res = 1;
        
        %check if the folder_name is in the excluded folders
        for j=1:length(exclude_dir)

            %if it is in the excluded then continue to loop
            %if not in excluded then add it as valid folder
            if(  endsWith(folder_name,exclude_dir(j))  )
                
                %set result as false then break loop to return
                res = 0;
                break
            end
        end
    end
    %----------------------------------------------------------
    

    %traverse to the directory of items
    for i=1:length(dir_files)
        
        %check whether the item is a 'directory' or a 'file'
        if(dir_files(i).isdir==1)

            if( is_valid(dir_files(i).name) )
                %add name of the folder to a variable if name is valid
                dir_folders = [dir_folders;convertCharsToStrings(dir_files(i).name)];
            end
        end
    end
end