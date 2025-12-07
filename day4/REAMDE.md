# Part 1
Today's problem is fairly simple and simulative, all you need to do is loop on each cell in the column and for each cell such that it is a roll: check in the eight adjacent cells `{(i-1,j-1), (i-1,j), (i-1,j+1), (i,j-1), (i,j+1), (i+1,j-1), (i+1,j), (i+1,j+1)}` if one of them holds the value `@` then you increase a counter by `1`.  
This operation for each cell signifies the number of rolls around my current cell, and for each: if `number of rolls around my current cell < 4` then we can remove it and we count it into `answer` variable.  

# Part 2
The same idea so we do the operation mentioned in part 1 fully.. then after-wards we delete all the cells that satifised the condition `number of rolls around my current cell < 4` by marking them with some marker 2d array during the operation, then we repeat the operation as-long as we delete rolls in the previous operation.
