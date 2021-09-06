function newArray = reduce_cell_array(array,cutInIndex)
    newArray{cutInIndex-1}=0;
    for x = 1:cutInIndex-1
        newArray{x} = array{x};
    end 
end