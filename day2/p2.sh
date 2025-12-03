#!/usr/bin/env bash

ans=0
read line < inputp2.txt
IFS=',' read -a pairs <<< "$line"

for pair in "${pairs[@]}"; do
      IFS='-' read val1 val2 <<< "$pair"
      for ((i=val1; i<=val2; i++)); do
            str="$i"
            len=${#str}

            ok=0
            for ((p=1; p<=len/2; p++)); do
                  if (( (len % p != 0) || (len / p < 2) )); then
                        continue
                  fi

                  deny=1
                  for ((j=0; j<len; j++)); do
                        if [[ ${str:j:1} != ${str:$((j%p)):1} ]]; then
                              deny=0
                              break
                        fi
                  done

                  if (( deny == 1 )); then
                        ok=1
                        break
                  fi
            done

            if (( ok == 1 )); then
                  (( ans += i ))
            fi
      done
done

echo "$ans"
