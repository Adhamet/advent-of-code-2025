#!/usr/bin/env bash


mapfile -t coords < inputp1.txt
n=${#coords[@]}
diff=()
for ((i=0; i<n; i++)); do
    IFS=',' read x1 y1 z1 <<< "${coords[i]}"
    for ((j=i+1; j<n; j++)); do
        IFS=',' read x2 y2 z2 <<< "${coords[j]}"
        dx=$(( x2 - x1 ))
        dy=$(( y2 - y1 ))
        dz=$(( z2 - z1 ))
        diff+=("$((dx*dx + dy*dy + dz*dz)),$i,$j")
    done
done

sortedDiff=$(printf "%s\n" "${diff[@]}" | sort -t',' -k1,1n)
readarray -t sortedDiffArr <<< "$sortedDiff"

# --- DSU ------------------------------
declare -A par sz
for ((i=0; i<n; i++)); do
    par[$i]=$i
    sz[$i]=1
done

_root=0
getRoot() {
    local x="$1"
    while [[ ${par[$x]} -ne $x ]]; do
        par[$x]=${par[${par[$x]}]}
        x=${par[$x]}
    done
    _root=$x
}

union() {
    local a="$1" b="$2"
    local ra rb
    
    getRoot "$a"
    ra=$_root
    
    getRoot "$b"
    rb=$_root

    [[ $ra -eq $rb ]] && return 1

    if (( sz[$ra] < sz[$rb] )); then
        par[$ra]=$rb
        (( sz[$rb] += sz[$ra] ))
    else
        par[$rb]=$ra
        (( sz[$ra] += sz[$rb] ))
    fi
    return 0
}
# --------------------------------------

m=${#sortedDiffArr[@]}
for ((i=0; i<m && i<1000; i++)); do
    IFS=',' read _ a b <<< "${sortedDiffArr[i]}"
    union "$a" "$b"
done

declare -A roots
for ((i=0; i<n; i++)); do
    getRoot "$i"
    r=$_root
    roots["$r"]=1
done

sizes=()
for r in "${!roots[@]}"; do
    sizes+=("${sz[$r]}")
done

sortedSizes=$(printf "%s\n" "${sizes[@]}" | sort -nr)
readarray -t sortedSizesArr <<< "$sortedSizes"

product=1
for ((i=0; i<3 && i<${#sortedSizesArr[@]}; i++)); do
    product=$((product * sortedSizesArr[i]))
done

echo "$product"
