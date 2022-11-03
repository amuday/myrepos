#!/bin/bash

# function keyword is optional, its not recommended
# without function keyword its easilyn portable
sayHello(){
    echo "Hello world !!!"

}

sayHelloWithParam(){
    echo "Hello $1 !!!"
}

add(){
    return $(( $1+$2))
}


##### calling ##

sayHello

# passing arguments
sayHelloWithParam "John"


# works
echo $(add 1 2)

# works
sum=$(add 1 2)
echo $sum