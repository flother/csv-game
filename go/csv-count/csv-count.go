package main

import (
	"encoding/csv"
	"flag"
	"fmt"
	"io"
	"os"
	"strconv"
)

func main() {
	flag.Parse()
	args := flag.Args()
	field, _ := strconv.Atoi(args[0])
	field -= 1
	inputFile := args[1]

	fh, _ := os.Open(inputFile)
	reader := csv.NewReader(fh)
	sum := 0
	for {
		rows, err := reader.Read()
		if err == io.EOF {
			break
		}
		val, _ := strconv.Atoi(rows[field])
		sum += val
	}
	fmt.Println(sum)

}
