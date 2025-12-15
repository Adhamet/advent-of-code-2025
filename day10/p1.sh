#!/bin/bash

ans=0
while read line; do
    target=$(echo "$line" | grep -o '\[[.#]*\]' | tr -d '[]')
    
    targetSz=${#target}
    
    targetMsk=0
    for ((i=0; i<targetSz; i++)); do
        if [ "${target:$i:1}" = "#" ]; then
            targetMsk=$((targetMsk | (1 << i)))
        fi
    done
    
    buttons=()
    while read button; do
        msk=0
        IFS=',' read indices <<< "$button"
        for idx in "${indices[@]}"; do
            msk=$((msk | (1 << idx)))
        done
        buttons+=($msk)
    done < <(echo "$line" | grep -oP '\([0-9,]+\)' | tr -d '()' | sed 's/^//' )
    
    buttonsSz=${#buttons[@]}
    
    curMin=$((buttonsSz + 1))
    for ((submsk=0; submsk<(1<<buttonsSz); submsk++)); do
        state=0
        presses=0
        
        for ((bit=0; bit<buttonsSz; bit++)); do
            if ((submsk & (1 << bit))); then
                state=$((state ^ buttons[bit]))
                ((presses++))
            fi
        done
        
        if [ $state -eq $targetMsk ]; then
            if [ $presses -lt $curMin ]; then
                curMin=$presses
            fi
        fi
    done
    
    ans=$((ans + curMin))
done < inputp1.txt

echo "$ans"
