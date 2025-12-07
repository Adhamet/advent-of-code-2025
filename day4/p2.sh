#!/usr/bin/env bash

ans=0

mapfile -t g < inputp2.txt # grid
n="${#g[@]}" # rows
m="${#g[0]}" # columns

notDone=1
while (( notDone == 1 )); do
    notDone=0

    unset remove
    declare -A remove
    for ((i=0; i<n; i++)); do
        for ((j=0; j<m; j++)); do
            if [[ "${g[i]:j:1}" == "@" ]]; then
                cnt=0
                if (( j-1>=0 )) && [[ "${g[i]:j-1:1}" == "@" ]]; then
                    (( cnt += 1 ))
                fi
                if (( j+1<m )) && [[ "${g[i]:j+1:1}" == "@" ]]; then
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
                if (( i-1>=0 && j+1<m )) && [[ "${g[i-1]:j+1:1}" == "@" ]]; then
                    (( cnt += 1 ))
                fi
                if (( i+1<n && j-1>=0 )) && [[ "${g[i+1]:j-1:1}" == "@" ]]; then
                    (( cnt += 1 ))
                fi
                if (( i+1<n && j+1<m )) && [[ "${g[i+1]:j+1:1}" == "@" ]]; then
                    (( cnt += 1 ))
                fi

            if (( cnt < 4 )); then
                notDone=1
                remove[$i,$j]=1
            fi
            fi
        done
    done

    for key in "${!remove[@]}"; do
        IFS=',' read -r i j <<< "$key"
        g[i]="${g[i]:0:j}.${g[i]:j+1}"
        (( ans += 1 ))
    done
done

echo "$ans"
