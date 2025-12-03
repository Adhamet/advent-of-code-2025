#!/usr/bin/env bash

ans=0
read line < inputp1.txt
IFS=',' read -a pairs <<< "$line"

for pair in "${pairs[@]}"; do
      IFS='-' read val1 val2 <<< "$pair"
      for ((i=val1; i<=val2; i++)); do
            str="$i"
            len=$(( ${#str} / 2 ))

            if (( ${#str} % 2 != 0 )); then
                  continue
            fi

            ok=1
            for ((j=0; j<len; j++)); do
                  if [[ ${str:j:1} != ${str:$((len+j)):1} ]]; then
                        ok=0
                  fi
            done

            if (( ok == 1 )); then
                  (( ans += i ))
            fi
      done
done

echo "$ans"
