package main

import (
  "log"
  "net/http"
  "regexp"
  "io/ioutil"
  "path"
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
  var secret = regexp.MustCompile(`secret`)

  switch {
    case img.MatchString( r.URL.Path ):
      appImage( w, r )
      break
    case secret.MatchString( r.URL.Path ):
      appSecret( w, r )
    default:
      appHtml( w, r );
  }

  //fmt.Fprintf(w, "Url path: %s", r.URL.Path[1:])

}


func appImage(w http.ResponseWriter, r *http.Request) {

  //fmt.Fprintf(w, "Image: %s", path.Base(r.URL.Path) )
  var fileBytes []byte
  var err error

  fileBytes, err = ioutil.ReadFile("images/"+path.Base(r.URL.Path))
  if err != nil {
    fileBytes, err = ioutil.ReadFile("images/none.png")
  }
  w.WriteHeader(http.StatusOK)
  w.Header().Set("Content-Type", "application/octet-stream")
  w.Write(fileBytes)
  return

}


func appHtml(w http.ResponseWriter, r *http.Request) {

  fileBytes, err := ioutil.ReadFile("page.html")
  if err != nil {
    return
  }
  w.WriteHeader(http.StatusOK)
  w.Header().Set("Content-Type", "text/html")
  w.Write(fileBytes)
  return

}


func appSecret(w http.ResponseWriter, r *http.Request) {

  fileBytes, err := ioutil.ReadFile("secret.html")
  if err != nil {
    return
  }
  w.WriteHeader(http.StatusOK)
  w.Header().Set("Content-Type", "text/html")
  w.Write(fileBytes)
  return

}
