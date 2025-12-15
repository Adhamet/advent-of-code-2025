#!/bin/bash

declare -A graph
while IFS= read line; do
    [[ -z "$line" ]] && continue
    
    u=$(echo "$line" | cut -d: -f1 | tr -d ' ')
    vs=$(echo "$line" | cut -d: -f2)
    
    graph[$u]="$vs"
done < inputp1.txt

dfs() {
    local curr=$1
    local vis=$2
    local pathCnt=0
    
    if [[ "$curr" == "out" ]]; then
        echo 1
        return
    fi
    
    if [[ " $vis " == *" $curr "* ]]; then
        echo 0
        return
    fi
    
    local vs="${graph[$curr]}"
    
    if [[ -z "$vs" ]]; then
        echo 0
        return
    fi
    
    local nvis="$vis $curr"
    
    for dest in $vs; do
        local paths=$(dfs "$dest" "$nvis")
        pathCnt=$((pathCnt + paths))
    done
    
    echo $pathCnt
}

ans=$(dfs "you" "")
echo "$ans"
