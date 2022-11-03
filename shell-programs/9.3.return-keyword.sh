#!/bin/bash

add(){
    local result=$(($1+$2))
    # Bash return statement
    echo $result
    return 100
}

myresult=$(add 2 3)
echo "Return value of the function is $?"
echo $myresult
echo $?
