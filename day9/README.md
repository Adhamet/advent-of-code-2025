# Part 1:  
Is very straight forward, just simply for each pair of hashes find the area through their distances of xs and ys, the xs represents the width and ys the length and that's it calculate the best `length * height`.  

# Part 2:  
This problem might be the most filled with ideas problem for this year's advent of code. It was very tricky and I took a couple of days where I massively failed at solving it because the trick that required for it to be more manageable went immediatley over my head was the fact that we need co-ordinate compression to make the problem more manageable, and I have to say I couldn't solve this one on my own I had help.
Co-ordinate compression says if I have for example: points = `{7,11,13}`, I only care about these exact points and nothing else so we don't need to loop over all co-ordinates up to 13, we can compress them to `{0,1,2}` and make them 3. This optimization is critical for huge grids with sizes of 10,000 and more.  

So in order to solve this problem for each index `{x,y}` we compress them as explained above but also leave a single point between each hash that will hold the value of the length of `X`s between the two hashes thus comrpessing the hash too.  

```
0   .   1   .   2
^   ^   ^   ^   ^
points and spaces between them!
```  

We then connect each hash to each other to mark the wall of our loop. Then since everything is compressed we have the ability to also mark the outside of the wall with BFS flood-fill, then obviously anything that we can't reach from outside is obviously inside then we mark all of those as valid green tiles.  

Lastly instead of checking every single tile in a rectangle each time (and we might have many common areas involved) it would be better off to have a prefix sum array which answers the question `what's the number of tiles in this rectangle?` So we build that prefix, then we loop on every rectangle and pick the best answer.  

This problem taught me alot about the language.
