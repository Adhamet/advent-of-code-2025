#!/usr/bin/env bash

mapfile -t g < inputp1.txt

nums=()
ops=()
for line in "${g[@]}"; do
    IFS=' ' read -a fline <<< "$line"
    for ch in "${fline[@]}"; do
        if [[ "${ch}" == "+" ]] || [[ "${ch}" == "*" ]]; then
            ops+=("${ch}")
        else
            nums+=("${ch}")
        fi
    done
done

res=()
for ((i=0; i<${#ops[@]}; i++)); do 
    if [[ "${ops[i]}" == "*" ]]; then
        res[i]=1
    else
        res[i]=0
    fi
done

for ((i=0; i<${#nums[@]}; i++)); do
    curOpIdx=$(( i % ${#ops[@]} ))
    curOp="${ops[ ${curOpIdx} ]}"

    if [[ "${curOp}" == "*" ]]; then
        res[curOpIdx]=$(( res[curOpIdx] * nums[i] ))        
    else
        res[curOpIdx]=$(( res[curOpIdx] + nums[i] ))
    fi
done

ans=0
for x in "${res[@]}"; do
    (( ans += x ))
done

echo "$ans"
