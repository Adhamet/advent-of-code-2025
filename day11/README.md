# Part 1:  
Here we just use DFS and avoid subshells as much as we can and through DFS we try every possible route from `you` and whenever we reach `out` we just count it as a path while obviously not visiting any same node twice in one path.  

# Part 2:
This solution had to be a bit more specific because if it were to be without optimizations it'd take forever with bash so isn't of counting all paths from one start to one end we count paths between specific pairs of nodes and then combine them:  

```
svr → dac → fft → out
svr → fft → dac → out
```  

That's the main trick, then the final answer is simply:  
$$(paths svr->dac * dac->fft * fft->out) + (paths svr->fft * fft->dac * fft->out)$$  

We also used dp to memorize the paths we pass by so we don't over-count them instead it just reuses the value stored in the memoization.
