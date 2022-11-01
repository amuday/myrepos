#!/bin/bash

file="./1arithmetic.sh"
file="1arithmetic.sh"

if [[ -e $file ]]; then 
    echo $file exists
fi

dir="./../shell-programs"

if [[ -d $dir ]]; then 
    echo $dir exists
fi 