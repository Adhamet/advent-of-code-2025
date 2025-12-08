# Part 1  
In this problem, let us not view the input as a computer would which is a n by m grid of characters, but rather as a human would where we obviously understand where the numbers actually are and the operations are and solve it with that view.  

We took the input as it is and we stored the numbers in an 1d indexed array called `nums` and the operations into another 1d indexed array called `ops`.  
Then we initialized an array called `res` of same size as `ops` which should hold the values of each column independently.  
If the operation on `ops[i]` for some `i` is `*` then we initialize `res[i]` with `1`, otherwise `0`.  
Then we loop on all numbers and use modulus operations to make sure that the number in index `i` in array `nums` uses operation `ops[i % size of ops]` with `nums[i]` on `res[i % size of ops]`.  

For visuals
```
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
```  
the number in the second row and second column (`64`) will be have `index = 5` in my `nums` array, when we do `5 % 4`, where `4` is the size of the ops array, we will end up with `1`, meaning we will use `res[1]` with operation of index `1` which is `+` on `nums[5]`.


# Part 2  
In this problem, let us view the input as a computer would, a n by m grid of characters.  

For each column from right to left, we loop on each row from top to bottom, as we descend for each column we gather all the digits into some number, so for example using the example visualized above in part 1, going down the last column will only gather `empty space` + `empty space` + `4` + `empty space`, we will only take the `4`, for the column before it: it will be `4` + `3` + `1` + `empty space`, thus we will take `431`, and so on..  
For each column where we fully take in some number, we store that number into some indexed array called `nums`, so for example from right to left until the column of index `12` we will have in `nums`: `(4, 431, 623)`.  
We will also have some variable called `op`, so when we meet an operation which will happen at index `12` and it will be `+`, then we apply the given operation on all the numbers in `nums`, and then add the result to `ans`..  
And when we meet an empty column like index `11`, we clear the array `nums` and start over again the same logic until we finish all the given operations.
