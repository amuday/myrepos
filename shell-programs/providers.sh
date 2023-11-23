#!/bin/bash
providers=$(cat provider.tf | grep -E 'source|version')

echo "${providers[*]}"


for val in "${providers[*]}"; do
    echo $val
done

for(( i=0; i<=${#providers[@]}; i+=1)); do
    printf "${providers[i]}"
done