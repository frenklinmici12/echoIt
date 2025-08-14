// Author: Frenklin Mici 08/13/25
// Purpose: demo - reading and writing with stdin and stdout

package main

import (
	// refer to http://godoc.ethos-os.org/ for detailed docs! (need to be on UIC wifi or VPN)

	"ethos/altEthos" // various ethos functions
	"ethos/fmt" // for outputting
	"ethos/kernelTypes" // supported ethos types
	"ethos/syscall" // for status

	"log" // Golang's log package
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

	// echo the input back to the user
	fmt.Println("You entered:", input)
}