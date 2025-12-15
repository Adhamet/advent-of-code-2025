#!/bin/bash

input=$(cat inputp1.txt)

lastBlock=$(echo "$input" | awk 'BEGIN{RS=""; ORS="\n"} END{print}')

ans=0
while IFS= read line; do
    [[ -z "$line" ]] && continue
    
    nums=($(echo "$line" | grep -oE '[0-9]+'))
    
    x=${nums[0]}
    y=${nums[1]}
    
    sum=0
    for ((i=2; i<${#nums[@]}; i++)); do
        sum=$((sum + nums[i]))
    done
    
    result=$(( (x / 3) * (y / 3) ))
    
    if (( result >= sum )); then
        ans=$((ans + 1))
    fi
done <<< "$lastBlock"

echo "$ans"
