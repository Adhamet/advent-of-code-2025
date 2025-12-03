# Part 1 Approach  
This problem is a pretty simple brute-force, for each range we loop from its start to finish and for each number we loop on we check if obviously its divisble by 2 first to be sure that it has two equal parts, and then check the each character in the first part to its corresponding character in the second part with comparison `i` with `i + (length of string) / 2`.  

# Part 2 Approach
Same idea as the first one just another simple brute-force where we add checking for each possible `p-lengthed` prefix, check it's corresponding occurances, so if for index for a 9-lengthed string for example take a 3-lengthed prefix, for `index = 3,4,5` they should be equal to `index 0,1,2` and for `index = 6,7,8` should also be equal to `index 0,1,2` and this idea generalizes to all lengths.
