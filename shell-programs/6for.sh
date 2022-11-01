#!/bin/bash
# iterating a range
for num in {1..10}; do
  echo ${num}
done

# using command output 
for file in $(ls .); do
  echo "script file name is ${file}"
done

for((i=0; i<10; i++)); do
  echo "${i}"
done


colors="red blue green yellow blue"

for color in $colors; do
  echo "color ${color}"
done

