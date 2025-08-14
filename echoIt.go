// Author: Frenklin Mici 08/13/25
// Purpose: Demo for taking input and outputting text from stdin and stdout

package main

import (
	"ethos/altEthos"
	"ethos/fmt" // for outputting
	"ethos/kernelTypes"
	"ethos/syscall"
	"fmt"
	"log"
)

func main() {
	var input kernelTypes.String // will store input in here.

	status := altEthos.ReadStream(syscall.Stdin, &input)
	if status != syscall.StatusOk {
		log.Println("Error reading from stdin. Exiting.")
		altEthos.Exit(status)
	}

	fmt.Println("You entered: ", input)
}