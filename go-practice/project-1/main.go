package main

import "fmt"

func main() {
	// declare the var
	var card string = "ace of spades"
	fmt.Println(card)

	// go compiler will decide the var type. := for initialization
	myvar := "myvalue"
	fmt.Println(myvar)

	// reassign a new value
	myvar = "my new value"
	fmt.Println(myvar)

	count := 10

	fmt.Println(count)
	fmt.Println(&count)
	fmt.Println(*&count)

}
