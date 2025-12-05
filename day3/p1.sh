#!/usr/bin/env bash

ans=0
while read line; do
      mx=0
      len=${#line}
      for ((i=0; i<=len; i++)); do
            for ((j=i+1; j<=len; j++)); do
                  num="${line:i:1}${line:j:1}"
                  num=$((10#$num))
                  if ((${num} > ${mx})); then
                        mx=${num}
                  fi
            done
      done
      (( ans += mx ))
done < inputp1.txt

echo "$ans"
