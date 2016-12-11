# benfordFitScript.r
# source("benfordFit.r")

# run fit on sample data, send to Hai
load(choose.files()) #C:\Users\Dan\Documents\PCData\Analysis\ClaimDetail\workingdir\Sample.RData
first_digit <- function(k){
  as.numeric(head(strsplit(as.character(k),'')[[1]],n=1))
}
#this get all the first digit from sets of numbers
all_first_digit <- function(x){
  sapply(x, function(k) first_digit(k))
}
library(MASS)
truehist(all_first_digit(ClaimTable$losspaid), nbins = 9)
truehist(all_first_digit(subset(ClaimTable,
  evaldate = as.Date("2015-12-31"), 
  select = losspaid)$losspaid), nbins = 9)
x <- ClaimTable$losspaid
x <- benfordFit(ClaimTable$losspaid)
plot.benfordFit(x)
# source("ThreeActuals.R")
# Why are these two results so different?
chisq.benfordFit(df1$Freq * length(nmbrs))
chisq.test(df1$Freq * length(nmbrs), y = benlaw(digits)*length(nmbrs))
