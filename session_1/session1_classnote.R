# variables
# R script is not sensitive to indent
# R varbiles are case sensitive
# you can't start a variable name with numbers
x <- 100
X <- 10

10x <- 1
x.1
x_1

# numeric, character, logical
x <- 100
class(x)

y <- "aaa"
class(y)

z <- FALSE
class(  z  )

# vectors, matrices, lists, data.frame
# vectors
a <- c(1,2,3)
class(a)

b <- c("A","B","AAAAA","BBBB")
b_special <- c("!!!!","####", "~~~")

c <- c(TRUE,FALSE,TRUE)
c <- c(T, F, T)

d <- 1:100
d

e <- seq(from=1, to=100, by=2)
f <- seq(from=1, to=100, by=0.5)

# index
f <- c("a","b","c","d","e")

f_select <- f[3]

f_select <- f [c(3,4,5)]
f_select <- f[3:5]
f_select <- f[c(T,T,F,F,F)]

length(f)
f_names <- c("name1","name2","name3","name4","name5")
names(f) <- f_names
f[c("name3", "name5")]

# matrix
m <- matrix(1:6, nrow = 3, ncol = 2); m
m_byrow <- matrix(1:6, nrow = 3, ncol = 2, byrow = T); m_byrow

colnames(m) <- c("sample1", "sample2")
rownames(m) <- c("gene1","gene2","gene3")
m

# index
m [1,]
m [,1]
m[1,1]

m [1:2, 1:2]
m[c("gene1", "gene2"),c("sample1")]
class(m)

rowMeans(m)
colMeans(m)
rowSums(m)
colSums(m)

# talk about subset genes by expression
good_genes <- rowMeans(m) > 3
m_filter <- m [good_genes,]

# list
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
mylist [c(1,3)]

# data.frame
people <- c("Han", "Alex")
age <- c(26, 27)
good_at_python <- c(F, T)

example <- data.frame(people, age, good_at_python, stringsAsFactors = F)
mode(example)

# factors
x <- c("a", "b", "c", "a")
as.numeric(factor(x))
m [c("gene2","gene3"),]
m [factor(c("gene2","gene3")),]

# index
example[,1:2]
example$people

# examining a data.frame
head(iris)
dim(iris)
class(iris)

# practice #1
# for all setosa species, calculate the mean petal.length.
column <- c("a","a","b","c")
column=="a"
mean()

select <- iris$Species=="setosa"
mean(iris[select, 3])
