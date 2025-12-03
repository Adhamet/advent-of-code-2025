#!/bin/bash

cnt=0
cur=50
M=100

while read line; do
      val=$((10#${line:1}))
      if [[ ${line:0:1} == "L" ]]; then
            cur=$(( (cur - val + M) % M))
      else
            cur=$(( (cur + val) % M ))
      fi
      cnt=$(( cnt + (cur == 0) ))
done < inputp1.txt

echo "$cnt"

