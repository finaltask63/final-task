package main

import (
  "fmt"
  "log"
  "net/http"
  "time"
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

  fmt.Println(time.Now(), "Hello from my new fresh server")

  fmt.Fprintf(w, "Hello, %s!", r.URL.Path[1:])

}


func appSecret(w http.ResponseWriter, r *http.Request) {

  fmt.Fprintf( w, "Secret here." )

}


func appImage(w http.ResponseWriter, r *http.Request) {

  fmt.Fprintf(w, "Image: %s", path.Base(r.URL.Path) )

}
