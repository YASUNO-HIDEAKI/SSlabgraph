
# SSlabgraph

<!-- badges: start -->
<!-- badges: end -->

The goal of SSlabgraph is to allow the Soil Science Laboratory members to easy create box plot, RDA plot, and NMDS plot.

## Installation

You can install the development version of SSlabgraph from [GitHub](https://github.com/YASUNO-HIDEAKI/SSlabgraph.git) with:

``` r
# install.packages("devtools")
devtools::install_github("YASUNO-HIDEAKI/SSlabgraph")
```

## Usage

Show that how to use the SSlabgraph

### box plot
If you want to create box plot, you read your data sheet.
You can at least create a box plot with enter X and Y axis title, and Y-axis label name.

``` r
# data <- read.csv("data.csv", header = T, stringsAsFactors = T)

SSlabgraph::boxplot(data = data, x = X, y = Y, ylab = "Y")
```

In addition, you can enter X-axis label name and change colors.
When you change colors, you enter fill and col. You enter the item name to "fill" that you want to change colors. You enter the color name or hexadecimal color codes to "col".

``` r
SSlabgraph::boxplot(data = data, x = X, y = Y, ylab = "Y", xlab = "X")

SSlabgraph::boxplot(data = data, x = X, y = Y, ylab = "Y", xlab = "X", fill = X, col = c("green", "yellow"))

SSlabgraph::boxplot(data = data, x = X, y = Y, ylab = "Y", xlab = "X", fill = X, col = c("#006400", "#ffff00"))
```

### NMDS
You can analyse NMDS and create NMDS plot easily.
First, You read the amplicon or PLFA data sheet and location data sheet.

``` r
input <- read.csv("input.csv", header = T, stringsAsFactors = T)
loc <- read.csv("loc.csv", headet = T, stringsAsFactors = T)
```
Second, you ran "f.NMDS.analysis"
The variables are "data" and "loc". 
The "data" is enter the amplicon or PLFA data.
The "loc" is enter location data. 

``` r
SSlabgraph::f.NMDS.analysi(data = input, loc = loc)
```

Third, to creat NMDS graph, you ran "f.NMDS.graph".
The variables are "data",  "color" and "shape"
The "data" is the "nmds.result" that is result of "f.NMDS.result".
Default of the data is "nmds.result"
The "color" is legend color. If you want to change color.
The "shape" is legend shape. If you want to change shape.

``` r
#You can create the simple NMDS graph only this
SSlabgraph::f.NMDS.graph

#change color and/or shape
SSlabgraph:: f.NMDS.graph(color = c("red", "green", "yellow", .....), shape = c(1, 2, 3, ......))
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(SSlabgraph)
## basic example code
```

