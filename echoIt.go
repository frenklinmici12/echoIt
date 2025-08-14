// Author: Frenklin Mici 08/13/25
// Purpose: Demo for taking input and outputting text from stdin and stdout

package main

import (
	"ethos/altEthos"
	"ethos/fmt" // for outputting
	"ethos/kernelTypes"
	"ethos/syscall"

	"log"
)

func main() {
	var input kernelTypes.String // will store input in here.

	fmt.Print("Enter input: ") // write to stdout

	status := altEthos.ReadStream(syscall.Stdin, &input) // Read from stdin (0), put that into the variable 'input' ReadStream returns a syscall status.
	
	// if something goes wrong (not StatusOk), exit
	if status != syscall.StatusOk {
		log.Println("Error reading from stdin. Exiting.")
		altEthos.Exit(status)
	}

	//echo the input back to the user
	fmt.Println("You entered:", input)
}