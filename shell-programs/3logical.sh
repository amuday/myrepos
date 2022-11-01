#!/bin/bash

i=10

if [ $i -ge 5 ] && [ $i -le 15 ]; then
    echo "value is between 5 and 15."
fi

## [[]] does string compare dont use it.
if ((i>5)) && ((i < 15 )); then
    echo " i is between 5 and 15 new style"
fi    

VAR1="Linuxize"
VAR2="Linuxize"

if [ "$VAR1" = "$VAR2" ]; then
    echo "Strings are equal."
else
    echo "Strings are not equal."
fi

<<comm
read -p "Enter first string: " VAR1
read -p "Enter second string: " VAR2

if [[ "$VAR1" == "$VAR2" ]]; then
    echo "Strings are equal."
else
    echo "Strings are not equal."
fi
comm


read -p "Enter true or false for a " a 
read -p "Enter true or false for b " b 

if [[ $a = "true" &&  $b = "true" ]]; then
    echo both are true
elif [[ "$a" == "false"  &&  "$b" == "false" ]]; then
    echo both false
fi 

if [[ "$a" == "true" || "$b" == "true" ]]; then
    echo either a or b is true
fi