#!/usr/bin/env bash

ranges=()

while IFS= read line; do
    if [[ -z "$line" ]]; then
        break
    fi
    IFS='-' read a b <<< "$line"
    ranges+=("$a $b")
done < inputp2.txt

sortedRngs=$(printf "%s\n" "${ranges[@]}" | sort -n -k1,1 -k2,2)

ans=0
le=-1
while read s e; do
    if (( s > le + 1 )); then
        ans=$((ans + (le - ls + 1)))
        ls=$s
        le=$e
    else
        (( e > le )) && le=$e
    fi
done <<< "$sortedRngs"

ans=$((ans + (le - ls + 1)))

echo "$ans"
