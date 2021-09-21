# Generative Art - Paper Birds in a Forest

Paper Birds in a Forest is an art piece in which an non-ending animation of birds flying in curved paths and landing on tree branches is generated. It aims to bring an outdoors birdwatching experience indoors. The animation is meant to utilze the columns between each screen in the Leeds studio as tree trunks. The color of each projector's background, the number and position of the tree branches, and the number and direction of the birds are all randomly generated, ensuring no animations wille ever run the same. 

![IMG_8899_MOV_SparkVideo](https://user-images.githubusercontent.com/88841145/134217156-e290be83-1f65-4f7d-ba63-b4f06ae2d243.gif)

#### **Video Link: https://drive.google.com/file/d/1p5xXs-KCLgQDt4qHF67eoqZsJ5Z-b90F/view?usp=sharing**

## Setup

This generative program consists of one main file titled "genart.pde" and an accompanying data folder containing relevant images. The folder and Processing can be downloaded, and the executable file can be run from the file with a few clicks and does not need to be adjusted after aside from dragging the window to fit the Leeds projectors. 

## Language: Processing

Processing was chosen as the language and software editor of choice for this project. The advantages of Processing is that it has was made with a focus on creating visual applications/experiences so it had extensive visual display libraries and did not need to be downloaded to run on the Leeds computer. Some disadvantages of Processing included a little less freedom, because their code is already very structured, and that Processing does not have the most efficient use of memory (example: animation becomes easily too large because every element including the background is often redrawn).

## Components

The most important asset to this program were the images, which included gifs split into images of a bird flying both direction and landing both directions, as well as the tree branches. Part of the fun of this task was creating my own images and thus contributing a paper, kid's sketchbook, sort of aesthetic. Within the program, the animation is broken down into three generatable and mutable objects, the box that fills each screen, the tree branches, and the birds. The birds utilize a class that allows for the animation of gifs within Processing. The path of the birds is determined by a random selection of a point near/on a tree branch. 









