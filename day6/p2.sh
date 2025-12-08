#!/usr/bin/env bash

mapfile -t g < inputp2.txt

rows="${#g[@]}"
cols="${#g[0]}"

ans=0
nums=()
for ((i=cols-1; i>=0; i--)); do
    curnum=""
    op="."
    for((j=0; j<rows; j++)); do
        if [[ "${g[j]:i:1}" == [0-9] ]]; then
            curnum+="${g[j]:i:1}"
        elif [[ "${g[j]:i:1}" == "*" ]] || [[ "${g[j]:i:1}" == "+" ]]; then 
            op="${g[j]:i:1}"
        fi
    done

    if [[ -z "$curnum" ]]; then
        nums=()
        continue
    fi

    nums+=("$((10#$curnum))")
    if [[ "$op" == "." ]]; then
        continue
    elif [[ "$op" == "*" ]]; then
        res=1
        for ((j=0; j<${#nums[@]}; j++)); do
            res=$(( res * nums[j] ))   
        done
        (( ans += res ))
    else
        res=0
        for ((j=0; j<${#nums[@]}; j++)); do
            res=$(( res + nums[j] ))   
        done
        (( ans += res ))
    fi
done

echo "$ans"
