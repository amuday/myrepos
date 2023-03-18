package main

import "fmt"

func main() {
	card := newcard()

	fmt.Println(card)

}

func newcard() string {
	return "Five of Diamonds"
}
