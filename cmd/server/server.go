package main

import (
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/sirupsen/logrus"
)

// Server contains all server logics
type Server struct {
	port int
}

// NewServer will return a new runnable server
func NewServer(port int) *Server {
	return &Server{port: port}
}

// Start will start the server
func (s *Server) Start() {
	r := mux.NewRouter()
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello Golang !"))
	})

	logrus.Info(http.ListenAndServe(
		fmt.Sprintf(":%d", s.port),
		r,
	))
}
