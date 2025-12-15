#!/usr/bin/env bash

mapfile -t lines < inputp1.txt

ans=0
len="${#lines[@]}"
for ((i=0; i<len; i++)); do
    IFS=',' read x1 y1 <<< "${lines[i]}"

    for ((j=i+1; j<len; j++)); do
        IFS=',' read x2 y2 <<< "${lines[j]}"

        if (( x1 >= x2 )); then
            dx=$(( x1 - x2 + 1 ))
        else
            dx=$(( x2 - x1 + 1 ))
        fi
        if (( y1 >= y2 )); then
            dy=$(( y1 - y2 + 1))
        else
            dy=$(( y2 - y1 + 1 ))
        fi 
        
        if (( $(( dx * dy )) > ans )); then
            ans=$(( dx * dy ))
        fi
    done

done

echo "$ans"
