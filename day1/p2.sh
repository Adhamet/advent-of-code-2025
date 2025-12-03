#!/usr/bin/env bash

cnt=0
cur=50
M=100

while read line; do
    val=$((10#${line:1}))
    prev=$cur

    if [[ ${line:0:1} == "L" ]]; then
        step=$(( (M - prev) % M ))
    else
        step=$prev
    fi

    if (( step == 0 )); then
          step=$M
    fi

    if (( step > val )); then
        crossings=0
    else
        crossings=$(( 1 + (val - step) / M ))
    fi

    (( cnt += crossings ))

    if [[ ${line:0:1} == "L" ]]; then
        (( cur = (cur + val) % M ))
    else
        (( cur = (cur - val) % M ))
        (( cur += M ))
        (( cur %= M ))
    fi
done < inputp2.txt

echo "$cnt"
