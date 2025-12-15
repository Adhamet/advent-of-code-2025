#!/bin/bash

declare -a xs ys
while IFS=',' read x y; do
    xs+=("$x")
    ys+=("$y")
done < inputp2.txt

n=${#xs[@]}

xs=($(printf '%s\n' "${xs[@]}" | sort -n | uniq))
ys=($(printf '%s\n' "${ys[@]}" | sort -n | uniq))

declare -A xIdx yIdx
for i in "${!xs[@]}"; do
    xIdx[${xs[i]}]=$i
done
for i in "${!ys[@]}"; do
    yIdx[${ys[i]}]=$i
done

gw=$((${#xs[@]} * 2 - 1))
gh=$((${#ys[@]} * 2 - 1))

declare -A grid

for ((i=0; i<n; i++)); do
    j=$(( (i + 1) % n ))
    
    x1=${xs[i]}
    y1=${ys[i]}
    x2=${xs[j]}
    y2=${ys[j]}
    
    cx1=$((${xIdx[$x1]} * 2))
    cx2=$((${xIdx[$x2]} * 2))
    cy1=$((${yIdx[$y1]} * 2))
    cy2=$((${yIdx[$y2]} * 2))
    
    if ((cx1 > cx2)); then t=$cx1; cx1=$cx2; cx2=$t; fi
    if ((cy1 > cy2)); then t=$cy1; cy1=$cy2; cy2=$t; fi
    
    for ((cx=cx1; cx<=cx2; cx++)); do
        for ((cy=cy1; cy<=cy2; cy++)); do
            grid["$cx,$cy"]=1
        done
    done
done

declare -A outside
declare -a queue=("-1,-1")
outside["-1,-1"]=1

while ((${#queue[@]} > 0)); do
    pos="${queue[0]}"
    queue=("${queue[@]:1}")
    
    IFS=',' read tx ty <<< "$pos"
    
    for dir in "-1,0" "1,0" "0,-1" "0,1"; do
        IFS=',' read dx dy <<< "$dir"
        nx=$((tx + dx))
        ny=$((ty + dy))
        
        ((nx < -1 || ny < -1 || nx > gw || ny > gh)) && continue
        
        if ((nx >= 0 && nx < gw && ny >= 0 && ny < gh)); then
            [[ "${grid[$nx,$ny]}" == "1" ]] && continue
        fi
        
        [[ -n "${outside[$nx,$ny]}" ]] && continue
        
        outside["$nx,$ny"]=1
        queue+=("$nx,$ny")
    done
done

for ((x=0; x<gw; x++)); do
    for ((y=0; y<gh; y++)); do
        if [[ -z "${outside[$x,$y]}" ]]; then
            grid["$x,$y"]=1
        fi
    done
done

declare -A pref2d
for ((x=0; x<gw; x++)); do
    for ((y=0; y<gh; y++)); do
        val=${grid[$x,$y]:-0}
        
        left=0; top=0; topleft=0
        ((x > 0)) && left=${pref2d[$((x-1)),$y]:-0}
        ((y > 0)) && top=${pref2d[$x,$((y-1))]:-0}
        ((x > 0 && y > 0)) && topleft=${pref2d[$((x-1)),$((y-1))]:-0}
        
        pref2d[$x,$y]=$((left + top - topleft + val))
    done
done

valid() {
    local x1=$1 y1=$2 x2=$3 y2=$4
    
    local cx1=$((${xIdx[$x1]} * 2))
    local cx2=$((${xIdx[$x2]} * 2))
    local cy1=$((${yIdx[$y1]} * 2))
    local cy2=$((${yIdx[$y2]} * 2))
    
    if ((cx1 > cx2)); then t=$cx1; cx1=$cx2; cx2=$t; fi
    if ((cy1 > cy2)); then t=$cy1; cy1=$cy2; cy2=$t; fi
    
    local left=0 top=0 topleft=0
    ((cx1 > 0)) && left=${pref2d[$((cx1-1)),$cy2]:-0}
    ((cy1 > 0)) && top=${pref2d[$cx2,$((cy1-1))]:-0}
    ((cx1 > 0 && cy1 > 0)) && topleft=${pref2d[$((cx1-1)),$((cy1-1))]:-0}
    
    local count=$((${pref2d[$cx2,$cy2]:-0} - left - top + topleft))
    local expected=$(( (cx2 - cx1 + 1) * (cy2 - cy1 + 1) ))
    
    [[ $count -eq $expected ]] && return 0 || return 1
}

ans=0

for ((i=0; i<n; i++)); do
    for ((j=0; j<i; j++)); do
        x1=${xs[i]}
        y1=${ys[i]}
        x2=${xs[j]}
        y2=${ys[j]}
        
        if valid "$x1" "$y1" "$x2" "$y2"; then
            area=$(( (${x1#-} > ${x2#-} ? ${x1#-} - ${x2#-} : ${x2#-} - ${x1#-}) + 1 ))
            area=$(( area * ((${y1#-} > ${y2#-} ? ${y1#-} - ${y2#-} : ${y2#-} - ${y1#-}) + 1) ))
            ((area > ans)) && ans=$area
        fi
    done
done

echo "$ans"
