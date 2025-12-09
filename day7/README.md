This problem is one of the most fun ones of this year's AOC.  
# Part 1  
We could write a simulation code. Let us start from `S`, we simulate going down unti we get to the bottom or `^`. If we get to the bottom that's it. If we meet a `^`, we continue searching both directions `j-1` and `j+1`, and repeat.  
There are many ways to accomplish this, the way I did it is I used a queue, a BFS-like search, first I put index of `S` in a queue, then went down until I meet a `^`, if that happens, I push to the queue the cell `(i, j-1)` if `j-1` doesn't go out of the bounds of the grid, same goes for `(i, j+1)` and stop. The queue will then go ahead and process both points and so on until we have processed all possible points. And obviously for each point we meet in the queue and we start processing we remove it from the queue, so we repeat such a process until the queue is empty. For each `^` I meet while processing, we count into the answer, that's it.... or actually there's a very very sneaky edge-case where you might meet the same splitter more than once, so you also need to make sure you count each splitter (`^`) only once.  

# Part 2
This problem took me a while to figure it out, I love this problem.  
At first I attempted solving it with combinatorics, but that can't work because the number of ways totally depends on how the grid looks like and that may give many different values not necessarily perhaps something related to only some $2^x$ formula.  

I've tried to approach this problem in many ways the only way that worked is the following:  
Let us start from the bottom to the top, so that we can accumulate the answers of each `^` up to the upper-most splitter `^`.  
To better understand the problem, for a simple grid like this:
```
..S..
.....
..^..
.....
```  
There are only 2 ways, that I drop down from `S` to `^`, then go to the left, or go to the right.  
For something like this:
```
..S..
.....
..^..
.....
.^...
.....
```  
There are only 3 ways, when I drop to the lower left-most `^`, that gives 2 ways, and the upper `^` also has a go-to-the-right option so that makes it 3 ways.  

The approach I took to solve this problem is that for each `^` we give it 2 data-types, `left`: which indicates the number of ways there are if I go to the left, and `right`: which indicates the number of ways there are if I go to the right. If we simulate going upwards by hand from some `^`, notice that total number of ways it holds (aka: `left` + `right`) will be given to any `^` by which it is above it and exists in `j-1`'s' or `j+1`'s cell: so if I found a `^` in index `j-1` as I am going up from my current `^`, then the `right` of that `^` that I found in `j-1` will hold all the total number of ways my current `^` holds (aka: `left` + `right`), same for a `^` that we find in some `j+1` where it is above me. Visualization for more understanding:
```
..S..
..^..
.....
...^.
.....
```  
The upper `^`'s `right` will now take the lower `^`'s total ways (aka: `left` + `right`), and we can detect that upper `^` by looping upwards for each `^` we meet while iterating on the grid from right-most bottom to left-most top. And we stop if there's a we meet a `^` above as and in the same column `j`.

If we simulate the algorithm above, then the uppermost `^` will simply have the total number of ways accumlated in it, so just print it's total ways (`left` + `right`).
