package main

import (
  "fmt"
  "log"
  "net/http"
//  "path"
  "regexp"
  "io/ioutil"
)


func main() {

  http.HandleFunc("/", appHandler)

  log.Println("Started, serving on port 8080")
  err := http.ListenAndServe(":8080", nil)

  if err != nil {
    log.Fatal(err.Error())
  }

}


func appHandler(w http.ResponseWriter, r *http.Request) {

  var img = regexp.MustCompile(`images\/`)
  var lst = regexp.MustCompile(`list`)


  switch {

    case img.MatchString( r.URL.Path ):
      appImage( w, r )
    case lst.MatchString( r.URL.Path ):
      fmt.Fprintf(w, "List" )
    default:
      appHtml( w, r );
  }

  //fmt.Fprintf(w, "Url path: %s", r.URL.Path[1:])

}


func appImage(w http.ResponseWriter, r *http.Request) {

  //fmt.Fprintf(w, "Image: %s", path.Base(r.URL.Path) )
  fileBytes, err := ioutil.ReadFile("images/test.jpg")
  if err != nil {
    panic(err)
  }
  w.WriteHeader(http.StatusOK)
  w.Header().Set("Content-Type", "application/octet-stream")
  w.Write(fileBytes)
  return

}


func appHtml(w http.ResponseWriter, r *http.Request) {

  var htmlstr = `<doctype html>
<html>
<head>
<title>The final task</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="header">
<select id="sel">
<option value="0">-- select --</option>
</select>
</dev>
<div class="info">
</dev>
<script src="/js/script.js" />
</body>
</html>`;

  w.Header().Set("Content-Type", "text/html; charset=utf-8")
  fmt.Fprintf(w, "%s", htmlstr )

}



func handleRequest(w http.ResponseWriter, r *http.Request) {
}