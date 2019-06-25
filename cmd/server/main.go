package main

import (
	"flag"
)

func main() {
	port := flag.Int("port", 3000, "Server port")
	flag.Parse()

	server := NewServer(*port)
	server.Start()
}
