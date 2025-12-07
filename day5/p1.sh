#!/usr/bin/env bash

ranges=()
numbers=()

sep=0
while IFS= read line; do
    if [[ -z "$line" ]]; then
        sep=1
        continue
    fi
    if (( sep == 0 )); then
        IFS='-' read a b <<< "$line"
        ranges+=("$a $b")
    else
        numbers+=("$line")
    fi
done < inputp1.txt

sortedRngs=$(printf "%s\n" "${ranges[@]}" | sort -n -k1,1 -k2,2)

mergedFst=()
mergedScd=()
while read s e; do
    if ((${#mergedFst[@]} == 0)); then
        mergedFst+=("$s")
        mergedScd+=("$e")
        continue
    fi
    lidx=$((${#mergedFst[@]} - 1))
    if (( s > mergedScd[lidx] )); then
        mergedFst+=("$s")
        mergedScd+=("$e")
    else
        (( e > mergedScd[lidx] )) && mergedScd[lidx]=$e
    fi
done <<< "$sortedRngs"

lower_bound() { # first index with arr[idx] >= k
    local k="$1"
    local -n arr="$2"

    local l=0
    local r=${#arr[@]}
    while (( l < r )); do
        local md=$(((l + r) / 2))
        if (( arr[md] < k )); then
            l=$((md + 1))
        else
            r=$md
        fi
    done
    echo "$l"
}

ans=0
for num in "${numbers[@]}"; do
    idx=$(lower_bound "$num" mergedFst)
    if (( idx == 0 )); then
        (( num >= mergedFst[0] && num <= mergedScd[0] )) && (( ans++ ))
    else
        x=$((idx - 1))
        (( num >= mergedFst[x] && num <= mergedScd[x] )) && (( ans++ ))
    fi
done

echo "$ans"
