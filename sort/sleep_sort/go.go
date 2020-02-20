package main

import (
	"fmt"
	"math/rand"
	"time"
)

func sort(array []int, d time.Duration) []int {
	result := make([]int, len(array))
	ch := make(chan int, len(array))
	for i := 0; i < len(array); i++ {
		go func(x int) {
			time.Sleep(time.Duration(x) * d)
			ch <- x
		}(array[i])
	}
	for i := 0; i < len(array); i++ {
		result[i] = <-ch
	}
	return result
}

func equalSlices(a1, a2 []int) bool {
	if len(a1) != len(a2) {
		return false
	}

	for i := 0; i < len(a1); i++ {
		if a1[i] != a2[i] {
			return false
		}
	}

	return true
}

func test(length int, d time.Duration) {
	expected := make([]int, length)
	shuffled := make([]int, length)
	for i := 0; i < length; i++ {
		expected[i] = i
		shuffled[i] = i
	}

	rand.Shuffle(length, func(i, j int) {
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	})

	if equalSlices(expected, sort(shuffled, d)) {
		fmt.Print("pass")
	} else {
		fmt.Print("FAIL")
	}
}

func main() {
	fmt.Print("x * Millisecond, 10 elements: ")
	for i := 0; i < 20; i++ {
		test(10, time.Millisecond)
	}
	fmt.Println("")

	fmt.Print("x * Millisecond, 50 elements: ")
	for i := 0; i < 20; i++ {
		test(50, time.Millisecond)
	}
	fmt.Println("")

	fmt.Print("x * Centisecond, 10 elements: ")
	for i := 0; i < 20; i++ {
		test(10, 10*time.Millisecond)
	}
	fmt.Println("")

	fmt.Print("x * Centisecond, 50 elements: ")
	for i := 0; i < 5; i++ {
		test(50, 10*time.Millisecond)
	}
	fmt.Println("")
}
