#!/bin/bash

while true
do
  echo "1. Add"
  echo "2. Subsctract"
  echo "3. Multiply"
  echo "4. Divide"
  echo "5. Average"
  echo "6. Quit"

  read -p "Enter your choice: " choice
  read -p "Enter Number1: " number1
  read -p "Enter Number2: " number2
  case $choice in
    1) 
        echo Answer=$(( $number1 + $number2 ))
        ;;
    2) 
        echo Answer=$(( $number1 - $number2 ))
        ;;
    3) 
        echo Answer=$(( $number1 * $number2 ))
        ;;
    4) 
        echo Answer=$(( $number1 / $number2 ))
        ;;
    5)
        sum=$(( $number1 + $number2 ))
        echo Answer=$(echo "$sum / 2" | bc -l)
        ;;    
    6)

         break
         ;;
  esac

done