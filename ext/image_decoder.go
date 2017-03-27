package main

import (
	"fmt"
	"image"
	_ "image/jpeg"
	"os"
)

func main() {
	file, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Println("Couldn't open image")
		os.Exit(1)
	}
	defer file.Close()

	image, _, err := image.Decode(file)
	if err != nil {
		fmt.Println("Couldn't decode image")
		os.Exit(1)
	}

	bounds := image.Bounds()
	width, height := bounds.Max.X, bounds.Max.Y

	var pixels []byte
	for y := 0; y < height; y++ {
		for x := 0; x < width; x++ {
			r, _, _, _ := image.At(x, y).RGBA()
			pixels = append(pixels, byte(r/257))
		}
	}
	os.Stdout.Write(pixels)
}
