#!/bin/bash


<<mycomment
=	    equal
!=	    not equal
<	    less then
>	    greater then
-n s1	string s1 is not empty
-z s1	string s1 is empty
mycomment

# check strings are equal
# No spaces next to =
var1="abc"
var2="abc"

# $ is needed for vars
if [[ $var1 = $var2 ]]; then 
    echo var1 and var2 are same
fi 


S1="Bash"
S2="Scripting"

if [ $S1 = $S2 ]; then
	echo "Both Strings are equal"
else 
	echo "Strings are NOT equal"
fi

var3="monday"

## pattern match, space is mandatory
if [[ $var3 =~ .*day ]]; then
    echo var3 is valid day
fi

var4="abc/feature/abc-123"

# contains
if [[ $var4 =~ .*feature.* ]]; then
    echo contains feature 
fi

var5="feature/abc-123"
# begin
if [[ $var5 =~ feature.* ]]; then
    echo begin with feature 
fi

branch="main"

if [[ $branch =~ ^(main|production)$ ]]; then 
    echo branch is either main or production
fi

branch="production"
if [[ $branch =~ (main|production) ]]; then 
    echo branch is either main or production
fi

str=""

if [[ -z $str ]]; then
    echo str is empty
fi

str="abc"

if [[ -n $str ]]; then
    echo str is not empty
fi

## Lexicographic Comparison #
VAR1="Linuxize"
VAR2="Ubuntu"

if [[ "$VAR1" > "$VAR2" ]]; then
    echo "${VAR1} is lexicographically greater then ${VAR2}."
elif [[ "$VAR1" < "$VAR2" ]]; then
    echo "${VAR2} is lexicographically greater than ${VAR1}."
else
    echo "Strings are equal"
fi

# String replace
str1="Today is Monday"
str2=${str1//day/abc}
echo "string after replace ${str2}"

# string length

str3=""
if [[ -z $str3 ]]; then
  echo "str3 is zero length"
else
  echo "str3 length is ${#str3}"
fi 

str3="x"
if [[ -z $str3 ]]; then
  echo "str3 is not empty"
else
  echo "str3 length is ${#str3}"
fi 


# Str wih length
str4="abcc"
if [[ -n $str4 ]]; then
  echo "str4 not empty and length: ${#str4}"
else
  echo "str4 length is ${#str4}"
fi 