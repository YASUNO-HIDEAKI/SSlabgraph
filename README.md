
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

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(SSlabgraph)
## basic example code
```

