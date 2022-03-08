package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"runtime"
)

func homeHandler(w http.ResponseWriter, r *http.Request) {
	myOS, myArch := runtime.GOOS, runtime.GOARCH
	inContainer := "inside"
	if _, err := os.Lstat("/.dockerenv"); err != nil && os.IsNotExist(err) {
		inContainer = "outside"
	}
	w.Header().Set("Content-Type", "text/plain")
	w.WriteHeader(http.StatusOK)
	//_, _ = fmt.Fprintf(w, "Hello, %s!\n", r.UserAgent())
	_, _ = fmt.Fprintf(w, "I'm running on %s/%s.\n", myOS, myArch)
	_, _ = fmt.Fprintf(w, "I'm running %s of a container.\n", inContainer)
	for key, element := range r.Header {
		fmt.Fprintf(w, "%s:%s\n", key, element)
	}
	for _, c := range r.Cookies() {
		fmt.Fprintf(w, "%s:%s\n", c.Name, c.Value)
	}
}
func main() {
	http.HandleFunc("/", homeHandler)
	err := http.ListenAndServe(":38001", nil)
	if err != nil {
		log.Fatalln(err)
	}
}
