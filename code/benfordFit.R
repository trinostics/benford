# benfordFit.R
# Calculate the distribution of leading digits in a 
#   in a vector x of numbers
# Also
#   Defines benford law
#   Plots the distribution using base barplot
#   Calculates a chi-square test statistic on the 
#     goodness of fit of actual distribution to expected
library(tm) # for readPDF
library(readr) # for parse_number

# https://onlinecourses.science.psu.edu/stat504/node/60
# An old-fashioned rule of thumb is that the X2 approximation 
# for X2 and G2 works well provided that n is large enough 
# to have Ej = npj ≥ 5 for every j. 
# Nowadays, most agree that we can have Ej< 5 for 
# some of the cells (say, 20% of them). 
# Some of the Ej's can be as small as 2, 
# but none of them should fall below 1. 
# If this happens, then the X2 approximation 
# isn't appropriate, and the test results are not reliable.

#================
benlaw <- function(d) log10(1 + 1 / d)
#================
benfordFit <- function(x, count = TRUE) {
  # Ignore NAs
  nna <- !is.na(x)
  nmbrs <- x[nna]
  # remove leading - sign of negative numbers
  isneg <- nmbrs<0
  nmbrs[isneg] <- -1*nmbrs[isneg]
  # ignore zeros
  iszero <- nmbrs==0
  nmbrs <- nmbrs[!iszero]
  firstDigit <- substr(gsub('[0.]', '', nmbrs), 1, 1)
  y <- c(table(firstDigit))
  if (!count) y <- y / length(firstDigit)
  y
}

plot.benfordFit <- function(x,
  xlab = "First Digit", 
  main = "Proportion of numbers with given First Digit",
  ylim = c(0, .4)) 
  {
  digits <- 1:9
  baseBarplot <- barplot(benlaw(digits), names.arg = digits, 
                         xlab = xlab, 
                         main = main,
                         ylim = ylim)
  lines(x = baseBarplot[,1], y = x, col = "blue", lwd = 1, 
        type = "b", pch = 23, cex = 1, bg = "blue")
}

chisq.benfordFit <- function(x, ...) {
  digits <- structure(1:9, names = 1:9)
  chisq.test(x, p = benlaw(digits), ...)
}

