## ----echo=FALSE----------------------------------------------------------
library(knitr)
opts_chunk$set(tidy.opts=list(width.cutoff=60),tidy=TRUE)

## ----include = FALSE-----------------------------------------------------
1+1
5-1
2*3
10/5
5^2

## ------------------------------------------------------------------------
1+1
5-1
2*3
10/5
5^2

## ----tidy=TRUE-----------------------------------------------------------
((4+5)/(3^2))*7
x<- ((4+5)/(3^2))*7

## ------------------------------------------------------------------------
y <- ((4^3)/(5 * 3)) + 10
x*y

## ------------------------------------------------------------------------
x

## ------------------------------------------------------------------------
#This is a comment. This will not influence any code I wish to run.

## ------------------------------------------------------------------------
c<- 5 #This code assigns the value 5 to the variable c.

## ------------------------------------------------------------------------
vec<- c(5,3,5,6,7,2)

## ------------------------------------------------------------------------
vec<- c(5,3,5,6,7,2) #This line saves 5,3,5,6,7,2 as a vector
vec #This line calls that vector so the numbers are displayed in the console
vec*2 #multiply every element in vec by 2
vec^2 #square every element in vec

## ------------------------------------------------------------------------
year<- c(1985, 1987, 1993, 1994, 1999, 2006, 2007, 2008, 2010) #create date vector
year_st<- year-1985 #shift
year_st #call shifted vector

## ----eval=FALSE----------------------------------------------------------
## num_vec<- c(1,2,3,4) #numeric vector
## num_vec2<- c(1.3, 4.7, 6.3, 5.2) #another numeric vector
## char_vec <- c("yes", "no", "maybe", "notsure") #character vector
## logical_vec<- c(TRUE, FALSE, TRUE, FALSE) #logical vector

## ------------------------------------------------------------------------
1==1
1==2

## ------------------------------------------------------------------------
logical_vec<- c(TRUE, FALSE, TRUE, FALSE)
sum(logical_vec)

## ----eval=FALSE----------------------------------------------------------
## #Say fac is a factor vector.
## #We convert to character with this code:
## as.character(fac)

## ----eval=FALSE----------------------------------------------------------
## #convert fac to numeric
## as.numeric(as.character(fac))

## ------------------------------------------------------------------------
year
year[5] #This gives us the 5th value in the year vector

## ------------------------------------------------------------------------
my_vec<-c(1,2,3,4,5,6,7,8,9,10,12,234,534,123,645,42,345,547,867)
my_vec
length(my_vec)

## ---- eval = FALSE-------------------------------------------------------
## help(mtcars)

## ------------------------------------------------------------------------
data("mtcars")

## ----eval= FALSE---------------------------------------------------------
## View(mtcars)

## ------------------------------------------------------------------------
mtcars$mpg #calls the mpg column of our data frame

## ------------------------------------------------------------------------
names(mtcars)

## ------------------------------------------------------------------------
names(mtcars)[1] = "mpg2" #rename the first column
names(mtcars) #display the new names vector

## ------------------------------------------------------------------------
head(mtcars, 15) #see the first 15 rows of the data frame
tail(mtcars, 9) #see the last 9 rows of the data frams

## ------------------------------------------------------------------------
mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("A", "M")

## ----eval=FALSE----------------------------------------------------------
## MyData <- read.csv(file="FileName.csv", header=TRUE, sep=",")

## ----eval=FALSE----------------------------------------------------------
## trump <- read.csv(file="https://github.com/dcgerard/stat234/raw/master/data/trump.csv")

## ----eval=FALSE----------------------------------------------------------
## install.packages("cowsay") #install cowsay pckg

## ----eval=FALSE----------------------------------------------------------
## install.packages( c("mosaic", "Hmisc", "fastR", "rmarkdown", "car", "vcdExtra", "Lock5withR", "tidyverse") )

## ------------------------------------------------------------------------
library(cowsay)
say("I am a cow.", "cow")

## ------------------------------------------------------------------------
library(tidyverse)

## ----eval=FALSE----------------------------------------------------------
## library(cowsay)

## ----eval=FALSE----------------------------------------------------------
## detach(cowsay)

## ----eval=FALSE----------------------------------------------------------
## glimpse(mtcars) #gives info on variable names, types, and values
## summary(mtcars) #gives a 5 number summary of each column
## head(mtcars, 10) #shows the first 10 rows of the data (can use different number)
## tail(mtcars, 5) #shows the last 5 rows of the data (can use different number)

## ------------------------------------------------------------------------
mean(mtcars$mpg2) #find the mean of the mpg2 variable
#find the mean of mpg2 for automatic and manual separately
aggregate(mtcars$mpg2, by = list(mtcars$am), FUN = "mean") 
mean(mtcars$mpg2[mtcars$am == "M"]) #find the mean of mpg2 only for manual

## ----eval=FALSE----------------------------------------------------------
## sd(mtcars$mpg2) # find the standard deviation of mpgs.
## #find the standard deviation of mpgs for automatic and manual separately
## aggregate(mtcars$mpg2, by = list(mtcars$am), FUN = sd)
## sd(mtcars$mpg2[mtcars$am == "M"]) #find the standard deviation of mpg2 only for manual

## ------------------------------------------------------------------------
median(mtcars$mpg2) #find the median of mpg2
IQR(mtcars$mpg2) #find the interquartile range of mpg2

## ------------------------------------------------------------------------
min(mtcars$mpg) #find the minimum value of mpg2
quantile(mtcars$mpg, probs = 0.25) #find the first quartile (25th percentile)
quantile(mtcars$mpg, probs = 0.5) #second quartile (50th percentile AKA median)
quantile(mtcars$mpg, probs = 0.75) #third quartile (75th percentile)
max(mtcars$mpg) #maximum value

## ------------------------------------------------------------------------
summary(mtcars$mpg)

## ------------------------------------------------------------------------
#this function uses the 1.5*IQR rule for outliers
boxplot(mtcars$disp)
boxplot(disp ~ am, data=mtcars) #separate boxplots for manual and automatic

#histogram for disp
hist(mtcars$disp, xlab="Displacement", ylab="Frequncy", 
     main="Distribution of Displacement") 

old_parameters <- par(mfrow = c(1, 2)) # Create facets and save old parameters
# separate histogram for manual
hist(mtcars$disp[mtcars$am == "M"], xlab = "displacement", main = "") 
# separate histogram for automatic
hist(mtcars$disp[mtcars$am == "A"], xlab = "displacement", main = "") 
par(old_parameters) # restore old settings

## ------------------------------------------------------------------------
hist(mtcars$disp, breaks = 10)

## ------------------------------------------------------------------------
plot(mtcars$disp, mtcars$mpg, xlab="Displacement", ylab="MPG", main="Displacement vs MPG", pch = 16)
plot(mtcars$disp, mtcars$mpg, col= mtcars$am, xlab = "Displacement", ylab = "MPG", pch = 16) # one plot, different symbols for automatic and manual
legend("topright", levels(mtcars$am), col = 1:2, pch = 16)

## ------------------------------------------------------------------------
stem(mtcars$disp) #create stem plot for disp
stem(mtcars$disp, scale=2) #create stemplot for disp with split stems for fewer outcomes per bin
stem(mtcars$disp[mtcars$am=="A"]) #create stemplot of disp for automatic only

## ------------------------------------------------------------------------
help(sort) # find out what the sort() function does
# or
?sort

