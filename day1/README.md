# Part 1 Approach  
The idea is to use modular arithmetic to simulate the circle effect of adding or subtracting to numbers in each step to keep them in the range of the circle \[0, 99\].  
Simply we loop over each line to take our code: if the first character is `'L'`, we convert the rest of the string value to a base-10 integer and move left, so we subtract `val` in modular arithmetic (and add `M` to bring it back to the positive range).  
If it is `'R'`, we add.  

# Part 2 Approach
Let us first simulate a single move as one-unit steps. We want the smallest positive step `k` (with `1 <= k <= val`) such that the arrow points at `0`.  

The modular condition is:  

$$
\text{cur} + \text{val} \equiv 0 \pmod{M}
$$  

which is equivalent to  

$$
\text{cur} \equiv -\text{val} \pmod{M}.
$$  

To convert this into real arithmetic used by Bash:  

$$
-\text{val} \bmod M = (M - \text{val}) \bmod M.
$$  

A similar one for subtraction, but then it would simply be:  

$$
k \equiv \text{prev} \pmod{M}.
$$  

If this is just one step, then obviously if `k > val`, we do not reach 0; the step size is not enough.   
If `k = 0`, then we do not move to count a crossing at all and we treat this as max as possible `k = M` s.t. it becomes unreachable since `val < M`.

Now we need to find the largest integer `n` such that:

$$
k + nM \le \text{val},
$$

and we add 1 for the first step.
