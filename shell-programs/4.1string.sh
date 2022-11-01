#!/bin/bash

<<mycomment
To get substring use below. Position is zero based index
    {string:position:length}
mycomment

str="my big string i need data from it"

# big
echo ${str:3:3}

#my big string i need data from it
echo ${str:0}     # default: start from the 0th position

#y big
echo "${str:1:5}"    # start from the 1th and get 5 characters

$i
echo "${str:10:1}"   # start from 10th just one character

# g string i need data from it
echo "${str:5}"      # start from 5th until the end

#####################################################################
<<cut
    echo "STRING" | cut -d'C' -f I
    -d flag = delimiter
    C is the character to split 
    I is the index to choose.
    f substring
cut

# big
echo $str | cut -d' ' -f 2

#########################################################################

substr= awk "{print substr('Helloworldhsfaj', 5, 5)}"
echo $substr 