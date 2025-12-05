#!/usr/bin/env bash

ans=0

better() {
    local a="$1" b="$2"
    if [[ $a == "__NONE__" ]]; then echo "$b"; return; fi
    if [[ $b == "__NONE__" ]]; then echo "$a"; return; fi
    if [[ $a > $b ]]; then echo "$a"; else echo "$b"; fi
}

solve() {
    local str="$1"
    local len=${#str}
    local -a dp ndp
    for ((i=0; i<=12; i++)); do dp[i]="__NONE__"; done
    dp[12]=""

    for ((idx=len-1; idx>=0; idx--)); do
        ndp=("${dp[@]}") # leave
        for ((ch=0; ch<12; ch++)); do
            local rem=$(( $len - $(($idx + 1)) ))
            local need=$(( 12 - $(($ch + 1)) ))
            if (( rem >= need )); then
                if [[ ${dp[ch+1]} != "__NONE__" ]]; then
                    local take="${str:idx:1}${dp[ch+1]}"
                    ndp[ch]=$(better "${ndp[ch]}" "$take")
                fi
            fi
        done
        dp=("${ndp[@]}")
    done

    echo "${dp[0]}"
}

while read line; do
    best=$(solve "$line")
    (( ans += best ))
done < inputp2.txt

echo "$ans"
