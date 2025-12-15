# Part 1:  
By noticing from the input that the number of buttons will be maximally around 11 buttons, I had the idea that we could simply represent the buttons through a bitmask, so for example choosing all buttons for a count of 5 buttons will be `1111111`, choosing only the 3rd and 5th would be `0010100` and so on. We also have a bitmask for the target itself, so for example if the target is 
```
[#.#.#]
``` 
Which means I will have the target lights mask `10101`, and we start off with havin a current lights bitmask of `00000`. Now what's left is to simply iterate over all possible buttons' bitmasks frm `00000` to `11111` signifying I will choose the ith button or not by having the bit turned on or off, and if a button's bit is on then we will see what bits does that button turn on in the current mask of lights and go on until we reach the best mask which takes minimum button presses (bits).  

# Part 2:  
Unfortunately I completely failed to solve this part, people say it requires Gaussian Elimination or some complicated optimization algorithm or some special library for languages like Py that I am not completely aware how'd implement it specifically in bash, so unfortunately I spent a long time in this problem but I was unable to solve it in bash.
