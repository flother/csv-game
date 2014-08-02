package main

import (
	"encoding/csv"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"runtime/pprof"
	"time"
)

var cpuprofile = flag.String("cpuprofile", "", "write cpu profile to file")
var memprofile = flag.String("memprofile", "", "write mem profile to file")

func schedule(work func(), interval time.Duration) chan struct{} {
	ticker := time.NewTicker(interval)
	quit := make(chan struct{})
	go func() {
		for {
			select {
			case <-ticker.C:
				work()
			case <-quit:
				ticker.Stop()
				return
			}
		}
	}()
	return quit
}

func main() {
	flag.Parse()
	if *cpuprofile != "" {
		f, err := os.Create(*cpuprofile)
		if err != nil {
			log.Fatal(err)
		}
		pprof.StartCPUProfile(f)
		defer pprof.StopCPUProfile()
	}
	if *memprofile != "" {
		f, err := os.Create(*memprofile)
		if err != nil {
			log.Fatal(err)
		}
		quit := schedule(func() { pprof.WriteHeapProfile(f) }, 1*time.Second)
		defer close(quit)
		defer f.Close()
	}

	reader := csv.NewReader(os.Stdin)
	sum := 0
	for {
		rows, err := reader.Read()
		if err == io.EOF {
			break
		}
		sum += len(rows)
	}
	fmt.Println(sum)

}
