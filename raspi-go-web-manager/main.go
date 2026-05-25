package main

import (
    "fmt"
    //"encoding/json"
    "net/http"
    "os/exec"
    "os"
)

func homeHandler(w http.ResponseWriter, r *http.Request) {
    // Read the entire file into a byte slice
	content, err := os.ReadFile("index.html")
	if err != nil {
        fmt.Fprintf(w, "404 File not found")
		return
	}

	// Convert the byte slice to a string
	result := string(content)

    // fmt.Println(result)
    fmt.Fprintf(w, result)
}

func aboutHandler(w http.ResponseWriter, r *http.Request) {
    cmd := exec.Command("/usr/bin/wall","new_dterr")
    _, err := cmd.Output()

    if err != nil {
        fmt.Println(err.Error())
        return
    }
    fmt.Fprintf(w, "This is the about page.")
}

func postHandler(w http.ResponseWriter, r *http.Request) {
	// 1. Verify it is a POST request
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}
    
    path := r.URL.Path
    
    if path == "/relay_1_on" {
    } else if path == "/relay_1_off" {
    } else if path == "/relay_1_sw" {
    } else if path == "/relay_2_on" {
    } else if path == "/relay_2_off" {
    } else if path == "/relay_2_sw" {
    }
    // w.Write([]byte("The request path is: " + path))
	// 3. Send a response
	fmt.Fprintf(w, "The request path is: " + path + " OK!\n")
}

func main() {
    // Регистрируем обработчики для разных маршрутов
    http.HandleFunc("/", homeHandler)
    http.HandleFunc("/about", aboutHandler)

    // Запускаем сервер
    fmt.Println("Starting server at port 8080")
    err := http.ListenAndServe(":8080", nil)
    if err != nil {
        fmt.Println("Error starting the server:", err)
    }
}
