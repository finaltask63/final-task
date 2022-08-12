package main

import (
  "fmt"
  "log"
  "net/http"
  "path"
)


func main() {

  http.HandleFunc("/secret", appSecret)
  http.HandleFunc("/images", appImage)
  http.HandleFunc("/", appHandler)

  log.Println("Started, serving on port 8080")
  err := http.ListenAndServe(":8080", nil)

  if err != nil {
    log.Fatal(err.Error())
  }

}


func appHandler(w http.ResponseWriter, r *http.Request) {

  fmt.Fprintf(w, "Hello, %s! v0.1", r.URL.Path[1:])

}


func appSecret(w http.ResponseWriter, r *http.Request) {

  fmt.Fprintf( w, "Secret here." )

}


func appImage(w http.ResponseWriter, r *http.Request) {

  fmt.Fprintf(w, "Image: %s", path.Base(r.URL.Path) )

}
