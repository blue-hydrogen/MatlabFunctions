function image = image_load(directory,filename)
    image = imread(convertStringsToChars(strcat(directory,filename)));
end