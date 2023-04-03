package test

import "testing"

func TestYourName(t *testing.T) {

	v1 := "hello world"
	//v2 := "hello john"

	if len(v1) != 11 {
		t.Errorf("Expected length is 11, but got %v", len(v1))
	}

}
