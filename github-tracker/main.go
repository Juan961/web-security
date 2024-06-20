package main

import (
	"fmt"
	"io"
	"net/http"

	"github.com/gorilla/mux"
)

func postHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Received POST request!")

	defer r.Body.Close() // Cerrar el body cuando termina la ejecución de este módulo

	// Leer la request que viene en bytes
	body, err := io.ReadAll(r.Body)

	if err != nil {
		fmt.Println("Error reading request!")

		return
	}

	fmt.Printf(string(body))
}

func main() {
	router := mux.NewRouter()

	router.HandleFunc("/hello", postHandler).Methods("POST")

	fmt.Println("Server listening on port 8080")

	err := http.ListenAndServe(":8080", router)

	if err != nil {
		fmt.Println(err.Error)

		return
	} 
}
