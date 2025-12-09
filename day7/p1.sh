#!/usr/bin/env bash

mapfile -t g < inputp1.txt

queue=()
rows="${#g[@]}"
cols="${#g[0]}"
found=0
for ((i=0; i<rows; i++)); do
    for ((j=0; j<cols; j++)); do
        if [[ "${g[i]:j:1}" == "S" ]]; then
            queue+=("$i,$j")
            found=1
            break
        fi
    done
    if (( found==1 )); then
        break
    fi
done

splits=0
declare -A seen
declare -A splitterSeen
while [ ${#queue[@]} -gt 0 ]; do
    IFS=',' read i j <<< "${queue[0]}"
    queue=("${queue[@]:1}")
    
    if [[ -n "${seen["$i,$j"]}" ]]; then
        continue
    fi
    seen["$i,$j"]=1

    for ((k=i+1; k<rows; k++)); do
        if [[ "${g[k]:j:1}" == "^" ]]; then
            if [[ -z "${splitterSeen["$k,$j"]}" ]]; then
                (( splits += 1 ))
                splitterSeen["$k,$j"]=1
            fi
            
            jj=$(( j - 1 ))
            if (( jj >= 0 )); then
                queue+=("$k,$jj")
            fi
            jj=$(( j + 1 ))
            if (( jj < cols )); then
                queue+=("$k,$jj")
            fi
            break
        fi
    done
done 

echo "$splits"
