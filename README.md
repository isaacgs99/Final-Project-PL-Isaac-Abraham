# Final Project Programming Languages - Image Processing

* Isaac Garza Strimlingas - A01025798
* Abraham García del Corral - A01023256

## Project Topic

Image processing is a set of techniques used for altering an image integrity. An image viewed from the perspective of a computer is in reality a set of bytes (bytes are a set of 8 bits and a bit can be a 1 or a 0), that translates into three different colors: red, green and blue, that combined can make almost every color. 
In this project, we want to process different colored images in a special format called ```.bmp``` (windows bitmap), a type of file that contains a map of bits or in simpler terms a matrix of bits, and convert it into different types of image (for example, grayscale or sepia).  


## Language

```Elixir```


## Solution

The program will read the bmp format image and store the value of the bitmap in a list, in order to process it (<b>File I/O</b>). Then using (<b>recursion or list comprehension</b>), to access the pixels of the image and modify them according to the filter desired (grayscale, negative). As in functional programming variables are not mutable, the modified pixels will be stored in another list, and finally the program will write the modified list in an output bmp file.
The program will read the first 54 bytes which corresponds to the header of the image. This bytes contain metadata of the image and have to be the same in order to let the OS what type of file is.
The data structure that the solution will be using is a matrix of a list of lists:

```
Outer list => image matrix
    inner lists => pixel
        1st deep inner lists => Red
        2nd deep inner lists => Green
        3rd deep inner lists => Blue

[ 
    [ [],[],[] ],
    [ [],[],[] ],
    [ [],[],[] ]
]
```
### Colored to negative
For each pixel, we will have 3 colors (red, green and blue) and each color channel are 1 byte long (8 bits), so the equivalent value on decimal base will range from 255 to 0. In order to make an image negative, the function will save each byte, convert it into decimal and make a decision based on the following condition; if the values ranges from 255 to 1, it will have to substract value from 255. in case the value is 0, it will have to add 255 to the value.

### Colored to grayscale 
As in colored to negative, the program will read 3 bytes corresponding to the R G B channels. Then for each channel, apply the corresponding formula to grayscale (R * 0.21 + G * 0.71 + B * 0.07) and save the result in the output list. 

## References

* [Color Calculations by NVIDIA](http://harmanani.github.io/classes/csc447/Notes/Lecture16.pdf)
* [Colored to negative](https://dyclassroom.com/image-processing-project/how-to-convert-a-color-image-into-negative)
* [Joy of Elixir](https://joyofelixir.com/toc.html)
* [Elixir Documentation](https://hexdocs.pm/elixir/Kernel.htm)