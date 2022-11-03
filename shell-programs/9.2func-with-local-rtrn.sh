#!/bin/bash

myfunc(){
    # with space next to =, you will get error
    local myresult="this is set from inside function"
    echo $myresult
}

echo $(myfunc)

# To capture value from the function
result=$(myfunc)
echo $result