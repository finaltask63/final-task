package main

import (
  "fmt"
  "log"
  "net/http"
  "path"
  "regexp"
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

//  if regexp.MatchString( "images/", r.URL.Path ) {
//    fmt.Fprintf(w, "images found" )
//  } else {
//    fmt.Fprintf(w, "No images found" )
//  }

  fmt.Fprintf(w, "Url path: %s", r.URL.Path[1:])

}


func appSecret(w http.ResponseWriter, r *http.Request) {

  fmt.Fprintf( w, "Secret here." )

}


func appImage(w http.ResponseWriter, r *http.Request) {

  fmt.Fprintf(w, "Image: %s", path.Base(r.URL.Path) )

}
