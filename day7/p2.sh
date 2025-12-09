#!/usr/bin/env bash

mapfile -t grid < inputp2.txt
rows="${#grid[@]}"
cols="${#grid[0]}"

declare -A gridVals
fstI=-1
fstJ=-1
for ((i=0; i<rows; i++)); do
    for ((j=0; j<cols; j++)); do
        if [[ "${grid[i]:j:1}" == "^" ]]; then
            if [[ $fstI == -1 ]]; then
                fstI=$i
                fstJ=$j
            fi
            gridVals["$i,$j,left"]=1
            gridVals["$i,$j,right"]=1
        fi
    done
done

for ((i=rows-1; i>=0; i--)); do
    for ((j=cols-1; j>=0; j--)); do
        if [[ "${grid[i]:$j:1}" == "^" ]]; then
            k=$((i-1))
            val=$(( ${gridVals["$i,$j,left"]} + ${gridVals["$i,$j,right"]} ))

            while ((k >= 0)) && [[ "${grid[k]:$j:1}" != "^" ]]; do
                if (( j-1 >= 0 )) && [[ "${grid[k]:$((j-1)):1}" == "^" ]]; then
                    gridVals["$k,$((j-1)),right"]=$val
                fi
                if (( j+1 < cols )) && [[ "${grid[k]:$((j+1)):1}" == "^" ]]; then
                    gridVals["$k,$((j+1)),left"]=$val
                fi
                ((k--))
            done
        fi
    done
done

ans=$(( ${gridVals["$fstI,$fstJ,left"]} + ${gridVals["$fstI,$fstJ,right"]} ))
echo "$ans"
