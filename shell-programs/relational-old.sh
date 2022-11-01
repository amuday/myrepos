#!/bin/bash

read -p 'Enter a: ' a
read -p 'Enter b: ' b

if [[ $a -eq $b ]]; then
    echo a equal to b
else
    echo a not equal to b
fi

if [ $a -ne $b ]; then
    echo a is not equal to b.
else
    echo a is equal to b.
fi
   
if [ $a -lt $b ]; then
    echo a is less than b.
else
    echo a is not less than b.
fi
   
if [ $a -le $b ]; then
    echo a is less than or equal to b.
else
    echo a is not less than or equal to b.
fi
   
if [ $a -gt $b ]; then
    echo a is greater than b.
else
    echo a is not greater than b.
fi
   
if [ $a -ge $b ]; then
    echo a is greater than or equal to b.
else
    echo a is not greater than or equal to b.
fi