#!/bin/bash

declare -A graph cache
RET=0
while IFS= read line; do
    [[ -z "$line" ]] && continue
    src=${line%%:*}
    dsts=${line#*: }
    graph[$src]="$dsts"
done < inputp2.txt

dfs() {
    local src=$1
    local dst=$2
    local key="$src|$dst"

    if [[ ${cache[$key]+x} ]]; then
        RET=${cache[$key]}
        return
    fi

    if [[ $src == "$dst" ]]; then
        cache[$key]=1
        RET=1
        return
    fi

    local curRes=0
    for nxt in ${graph[$src]}; do
        dfs "$nxt" "$dst"
        (( curRes += RET ))
    done

    cache[$key]=$curRes
    RET=$curRes
}

dfs svr dac;
svr_to_dac=$RET
dfs dac fft;
dac_to_fft=$RET
dfs fft out;
fft_to_out=$RET

path1=$((svr_to_dac * dac_to_fft * fft_to_out))

dfs svr fft;
svr_to_fft=$RET
dfs fft dac;
fft_to_dac=$RET
dfs dac out;
dac_to_out=$RET

path2=$((svr_to_fft * fft_to_dac * dac_to_out))

echo $((path1 + path2))
