package main

import "github.com/labstack/echo/v4"

func main() {
	e := echo.New()
	e.File("/", "src/video.webm")
	e.Logger.Fatal(e.Start(":8080"))
}
