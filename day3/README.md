# Part 1  
This one was rather a simple brute-force where you just do 2 nested loops for loop from `0` to `n-1` inside it a loop from `i+1` to `n-1` so for each string[i] find the maximum number after it such that when both are combined they create the maximum coupled digits following our given rules.  

# Part 2  
This problem could be solved the same way with part 1 with `12` nested loops since there are no restrictions in AOC, but it'll take a long-time and it is quite in-efficient as time complexity here would be $n^{12}$. A more efficient way would be to dp, first I thought of a recursive solution of parameters  

[idx][current character taken out of the 12 we need respective to their order in the resulting subsequence]  
where each dp[i][j] holds the max subsequence so far.

but unfortunately I learnt that bash is very bad with recursions the hard way, and as intuitive as the solution was I couldn't get it to be effective enough so I had to figure out something else..  

The second obvious choice is turning the dp iteratively as it would be much better and then I wouldn't have to deal with bash's large overhead for recursions and also use the space-efficiency trick of dp where instead of having `dp[idx][...]`, we can take advantage of the fact that each idx goes next only to idx + 1, so we can skip this in memory with dp and ndp containers by swapping each previous container with current one.    
Getting more into the algorithm (and honestly not being able to fully figure out the solution by myself, I got help..), this is a knapsack dp.  
The idea is pretty much not that complicated at all, we firstly would obviously need our main outer loop on the indices to be backwards because we work on the suffix and since we want to form a string of 12 characters forwards so it's important to know before-hand the max subsequence from the back. For each new index introduced in my loop we unlock a new character by which we see which place in my subsequence would be best for it while respecting the restrictions of the problem through simple if conditions and having to build the dp from it's back, or simply skipping the current character as a whole, and we greedily pick which-ever is lexicographically largest.
