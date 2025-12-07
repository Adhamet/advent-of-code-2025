# Part 1  
I am not sure if the issue is with me or what, but, part 1 today was more difficult than part 2, maybe because I wanted an efficient solution implemented and not just basic brute force.  
My idea of the solution is: for each k in our query, binary search on the ranges' first elements after sorting the ranges..  
If found that the found by binary-search first satisfies `first of that range <= k <= second of that range` then we count it into our answer, but the edge case is that we can't solve it without dealing with the overlapping ranges, so we have to merge overlapping ranges one into one range.  

# Part 2
For each range, you need to calculate the count of numbers between the first element and the second element inclusive, this has a popular counting equation, `last element - first element + 1`.
