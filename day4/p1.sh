#!/usr/bin/env bash

ans=0

mapfile -t g < inputp1.txt # grid
n="${#g[@]}" # rows
m="${#g[0]}" # columns
for ((i=0; i<n; i++)); do
    for ((j=0; j<m; j++)); do
        if [[ "${g[i]:j:1}" == "@" ]]; then
            cnt=0
            if (( j-1>=0 )) && [[ "${g[i]:j-1:1}" == "@" ]]; then
                (( cnt += 1 ))
            fi
            if (( j+1<n )) && [[ "${g[i]:j+1:1}" == "@" ]]; then
                (( cnt += 1 ))
            fi
            if (( i-1>=0 )) && [[ "${g[i-1]:j:1}" == "@" ]]; then
                (( cnt += 1 ))
            fi
            if (( i+1<n )) && [[ "${g[i+1]:j:1}" == "@" ]]; then
                (( cnt += 1 ))
            fi
            if (( i-1>=0 && j-1>=0 )) && [[ "${g[i-1]:j-1:1}" == "@" ]]; then
                (( cnt += 1 ))
            fi
            if (( i-1>=0 && j+1<n )) && [[ "${g[i-1]:j+1:1}" == "@" ]]; then
                (( cnt += 1 ))
            fi
            if (( i+1<n && j-1>=0 )) && [[ "${g[i+1]:j-1:1}" == "@" ]]; then
                (( cnt += 1 ))
            fi
            if (( i+1<n && j+1<n )) && [[ "${g[i+1]:j+1:1}" == "@" ]]; then
                (( cnt += 1 ))
            fi

            if (( cnt < 4 )); then
                (( ans += 1 )) 
            fi
        fi
    done
done

echo "$ans"
