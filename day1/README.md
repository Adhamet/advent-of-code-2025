# Part 1 Approach:   
The idea is to use modular arithmetic to simulate the circle effect of adding or subtracting to numbers in each other to keep them in the range of the circle [0,99].  
Simply we loop over each line to take our code, if first character is 'L', we convert the rest of the string value to a 10-based integer, we're going towards the left, so we subtract by val in modular arithmetic (and add M to get it back to the positive region), or if positive we simply just add.

# Part 2 Approach:
Let us first simulate a single move as one unit step at a time, we want the smallest positive step k (1 <= k <= val) s.t. that the arrow is pointing at 0.  

The modular condition is:  
\[
\text{cur} + \text{val} \equiv 0 \pmod{M}
\]  

which is equivalent to  

\[
\text{cur} \equiv -\text{val} \pmod{M}.
\]  

To convert this into real arithmetic used by Bash:  

\[
-\text{val} \bmod M = (M - \text{val}) \bmod M.
\]  

A similar one for subtraction but then it would simply be k = prev
\[
\text{k} \equiv \text{prev} \pmod{M}
\]  

Now, if this is just one step, then obviously if k > val then we don't even get to 0 in the first place as val is not enough, and if k = 0 then obviously again we don't even move to count some crossing we give it a arbitrary max value of M=100 so val could never reach it.  
Now we need to find n s.t. step + nM <= val and n is as big as possible, and we add 1 for the first ever step.
