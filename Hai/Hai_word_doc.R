require(MASS)
#get first digit from any numeric number
first_digit <- function(k){
  as.numeric(head(strsplit(as.character(k),'')[[1]],n=1))
}
#this get all the first digit from sets of numbers
all_first_digit <- function(x){
  sapply(x, function(k) first_digit(k))
}
truehist(all_first_digit(rlnorm(10000, 10, 0.8)), nbins=9)
firstDigit <- function(x) {
  y <- substr(gsub('[0.]', '', x), 1, 1)
  # zero amounts look like "" in y
  y[sapply(y, nchar) > 0]
}
x <- rlnorm(10000, 10, 0.8)
firstx <- firstDigit(x)
truehist(as.numeric(firstx), nbins = 9)
truehist(as.numeric(firstDigit(rlnorm(10000, 5, 0.6))), nbins = 9)
truehist(as.numeric(firstDigit(rlnorm(10000, 6, 0.6))), nbins = 9)
truehist(as.numeric(firstDigit(rnorm(10000, 5, 0.6))), nbins = 9)
truehist(as.numeric(firstDigit(rnorm(10000, 5, 0.6))), nbins = 6)
x <- rnorm(10000, 5, 0.6)
firstx <- firstDigit(x)
w <- list()
for (i in 1:9) w[[i]] <- which(firstx == as.character(i))
truehist(as.numeric(firstx), nbins = 6) # more bell-like

x <- read.csv(choose.files(), header=TRUE)
truehist(all_first_digit(x[,"TotalLoss"]), nbins=9)

# Sample actual real claim data
load(choose.files())
truehist(all_first_digit(ClaimTable[,"lossrptd"]), nbins=9)
truehist(all_first_digit(ClaimTable[,"losspaid"]), nbins=9)
sum(is.na(ClaimTable[,"lossrptd"]))
truehist(as.numeric(firstDigit(ClaimTable[,"lossrptd"])))
truehist(all_first_digit(ClaimTable[,"losspaid"]), nbins=9)
head(firstDigit(ClaimTable$losspaid))
