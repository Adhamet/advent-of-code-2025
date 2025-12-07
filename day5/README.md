# Part 1  
I am not sure if the issue is with me or what, but, part 1 today was more difficult than part 2, maybe because I wanted an efficient solution implemented and not just basic brute force.  
My idea of the solution is basically just binary searching each k in a query on our ranges' first elements after sorting the ranges, if found that the found by binary-search first satisfies `first of that range <= k <= second of that range` then we count it into our answer, that simply, but the edge case is that we can't solve it without dealing with the overlapping ranges, so we have to merge overlapping ranges one into one range.  

# Part 2
For each range, you need to calculate all the numbers between the first element and the second element, this has a popular counting equation, `last element - first element + 1`.
