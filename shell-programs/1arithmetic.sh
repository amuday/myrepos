#!/bin/bash

# read data from user

read -p 'Enter a: ' a 
read -p 'Enter b: ' b 

add=$((a+b))
echo addition of a and b is $add 

diff=$((a-b ))
echo addition of a and b is $diff 

mul=$(( a*b ))
echo addition of a and b is $mul 

# you dont need $ here
div=$(( $a/$b ))
echo addition of a and b is $div

echo 2 ^ 8 = $[ 2 ** 8 ]
echo 2 ^ 8 = $((2**8))