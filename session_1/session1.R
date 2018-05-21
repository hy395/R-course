# hello world
myfunction <- function(){
  print("Hello world!")
}
myfunction()

# object and variables.
# R script is not sensitive to indent
# R variables are case sensitive
# you can't start a variable name with numbers
x <- 100

##############
# data types #
##############
# basic: character, numeric, logical scalars.
# numeric
x <- 100
print(x)
class(a)

x <- 100
y <- 50
x + y
x - y
x * y
x / y
x %% y

# character
b <- "Alex"
b + 50

# logical
c <- TRUE

##################
# data strctures #
##################
# vectors, matrices, list, data.frame

###########
# vectors #
###########
# sequence of elements of the same type.
# create vectors
x <- 1:20
y <- c("a","b","c")
z <- c(TRUE, FALSE, FALSE)
seq()

# attributes of vectors
names()
length()

# index vectors
# by numeric vector
# by character vector (names)
# by logical vector

##########
# matrix #
##########
# 2-D vector. Again, elements must be of the same type.
m <- matrix(0, nrow = 2, ncol = 2)
colnames(m) <- c("sample1", "sample2")
rownames(m) <- c("gene1","gene2","gene3")

# index
rowMeans(m)
colMeans(m)
rowSums(m)
colSums(m)

# example, filter genes by expression level
good_genes <- rowMeans(m) > 3
m_filter <- m [good_genes,]

########
# list #
########
a <- c(1,2,3,4)
b <- c("apple", "orange", "banana")
c <- c(T,F)
mylist <- list(first_element = a, second_element = b, third_element = c)

# index
mylist [[1]]
mylist [["first_element"]]
mylist$first_element
mylist [1:2]

mylist[1]
mylist[[1]]

##############
# data.frame #
##############
people <- c("Han", "Alex")
age <- c(26, 27)
good_at_python <- c(F, T)
example <- data.frame(people, age, good_at_python, stringsAsFactors = F)

# index
example[,1:2]
example$people

############
# practice #
############
# examining a data.frame
head(iris)
dim(iris)
class(iris)

# practice #1
# for all setosa species, calculate the mean petal.length.
column <- c("a","a","b","c")
column=="a"
mean()

# solution
select <- iris$Species=="setosa"
mean(iris[select, 3])

