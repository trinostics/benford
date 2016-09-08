library(tm) # for readPDF
library(readr) # for parse_number

#================
benlaw <- function(d) log10(1 + 1 / d)
digits <- 1:9
baseBarplot <- barplot(benlaw(digits), names.arg = digits, 
                       xlab = "First Digit", 
                       main = "Proportion of non-zero numbers in document\n with given First Digit",
                       ylim = c(0, .4))
#================

firstDigit <- function(x) substr(gsub('[0.]', '', x), 1, 1)
pctFirstDigit <- function(x) data.frame(table(firstDigit(x)) / length(x))

od <- setwd("data")

#================

(files <- list.files(pattern = "pdf$|PDF$"))
files <- rev(files)
n <- length(files)
clrs <- rainbow(n)
clrs <- c("red", "blue", "darkgreen", "black")
labl <- c("Exhibits", "Rate Filing", "Annual Statement", "Schedule P")
xndx <- c(1:3, 5)

#================

for (i in 1:n) {
  txt <- readPDF(control=list(text="-layout"))(elem=list(uri=files[i]), 
                                               language="en")$content
  words <- scan(text=txt, what = "")
  y <- suppressWarnings(sapply(words, parse_number))
  nna <- !is.na(y)
  nmbrs <- y[nna]
  isneg <- nmbrs<0
  nmbrs[isneg] <- -1*nmbrs[isneg]
  iszero <- nmbrs==0
  nmbrs <- nmbrs[!iszero]
  length(nmbrs)
  df1 <- pctFirstDigit(nmbrs)
  
  lines(x = baseBarplot[,1], y = df1$Freq, col = clrs[i], lwd = 1, 
        type = "b", pch = 23, cex = 1, bg = clrs[i])
  text(x = baseBarplot[xndx[i],1], y=df1$Freq[xndx[i]], 
       paste0(labl[i], " (", length(nmbrs), ")"), 
       col = clrs[i], pos=4)
  
}

#================

# Sch P

(files <- list.files(pattern = "csv"))

L <- list()
for (f in files) {
  y <- read.csv(f)
  y <- setNames(y[6:8], c("Incd", "Paid", "Bulk"))
  L[[f]] <- y
}
y <- do.call(rbind, L)
y <- c(as.matrix(y))


nna <- !is.na(y)
nmbrs <- y[nna]
isneg <- nmbrs<0
nmbrs[isneg] <- -1*nmbrs[isneg]
iszero <- nmbrs==0
nmbrs <- nmbrs[!iszero]
length(nmbrs)
df1 <- pctFirstDigit(nmbrs)
i = 4
lines(x = baseBarplot[,1], y = df1$Freq, col = clrs[i], lwd = 1, 
      type = "b", pch = 23, cex = 1, bg = clrs[i])
text(x = baseBarplot[xndx[i],1], y=df1$Freq[xndx[i]], 
     paste0(labl[i], " (", length(nmbrs), ")"), 
     col = clrs[i], pos=4, offset=2.8)



setwd(od)
