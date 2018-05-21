# review:
# practice 1: generate a 2 * 3 matrix, fill in the values 1:6 BY ROW.
m <- matrix(data = 1:6, nrow = 2, ncol = 3, byrow = T)
m
# practice 2: create a list of 3 elements:
# first element: a numeric vector 1,2,3
# second element: a string vector: a,b,c
# third element: a logical vector: TRUE, TRUE, FALSE
mylist <- list(first=c(1,2,3), second=c("a","b","c"), third=c(T,T,F))

# todays topics:
# 1. input and outpput
# 2. control structure
# 3. functions
# 4. vector and matrix arithmetics

# data
dudes <- c("Alex", "Han")
age <- c(27,26)
happy <- c(T,T)
df <- data.frame(dudes, age, happy, stringsAsFactors = F)

# input and output
getwd()
# for mac "~/Desktop"
setwd("C:/Users/yuanh_000/Desktop/")
getwd()
list.files()

# write.table
write.table(df, file = "test.tsv", quote = F, sep = "\t", row.names = F)
write.table(df, file = "test.csv", quote = F, sep = ",", row.names = F)
system("cat test.tsv")
system("cat test.csv")

# read.table
input1 <- read.table("test.tsv", sep = "\t", header=T)
input2 <- read.table("test.csv", sep = ",", header=T)

# binary format
saveRDS(df, file = "df.rds")
input3 <- readRDS("df.rds")

save(input1, input2, input3, file = "session2_input.rdt")
load("session2_input.rdt")

# control structures
# condition operators: >, <, >=, <=, ==, &, |
1 > 2
2 >= 1
1 == 1
1 == 2

# &, TRUE if both conditions have to be met
(2 == 1) & (3 > 2)

# |, TRUE if any of the conditions is met
(2 == 1) | (3 > 2)

# if statement
if (x > 100) {
  print("x is too large")
} else {
  print("x is ok")
}

x <- 25
if (x > 100) { 
  print("x is greater than 100")
  } else if ( x > 50 ){
  print("x is between 50 and 100")
} else {
  print ("x is small")
}

# for loop
for (i in 1:10) {
  z <- i * 2
  print(z)
}

# practice: for 1:10, write a for loop 
# to decide whether each number is odd or even.
# print out "odd" for odd number, print "even" for even number.
# condition to use: x%%2==0
for (i in 1:10) {
  if (i%%2==0) {
    print("even")
  } else {
    print("odd")
  }
}

# function
odd_or_even <- function (x) {
  if (x%%2 == 0) {
    #print("even")
    z <- "even"
  } else {
    #print ("odd")
    z <- "odd"
  }
  return (z)
}

# 1:10 are even or odd
outputs <- vector()
for (i in 1:10) {
  outputs[i] <- odd_or_even(i)
}

# arithmeitcs
# vectorized operation
x <- 1:100000
system.time(x + 1)

z <- vector()
system.time(for(i in 1:100000) {z[i] <- i+1})
  
# vector and a number
x <- 1:4
x+1
x-1
x*10
x/10
x%%4

# vector and vector (same length)
y <- c(10,20,30,40)
x + y
x - y
x*y
x/y
a <- 1:2
y
a + y

# matrix
x <- matrix(1:4, 2, 2)
y <- matrix(c(10,20,30,40, 50, 60),2,3)

# matrix and number
x + 1
x - 1
x*2
x/2

# matrix and matrix
x + y[,1:2]
x * y[,1:2]

x%*%y

# string operator
"a" %in% c("a","b","c")
c("a","b","d", "e") %in% c("a","b","c")

rownames(y) <- c("PDCD1","CTCF")
immune_genes <- c("PDCD1","CTLA4","TCR1")
y[rownames(y)%in%immune_genes,]

# apply, lapply, tapply.
y

# apply
apply(y, 2, function(column){
  mean(column+10)
  })

apply(y, 2, function(column) mean(column))
apply(y, 2, mean)


for (i in 1:1:ncol(y)) {
  x <- y[,i]
  mean(x + 10)
}

# lapply
mylist <- list(c(1,2,3), c(1,2,3,4,5), c(2,2,2,2))
lapply(mylist, sum)

# tapply
exon_sizes <- c(1,2,3,4,5,6,7)
gene_name <- c("CTCF","CTCF","CTCF","CTCF","PDCD1","PDCD1","PDCD1")
tapply(exon_sizes, INDEX = gene_name, sum)

# practice #2
m <- matrix(c(10,5,100,10,2,1,5,2), 4, 2, 
            dimnames=list(c("gene1","gene2","gene3","gene4"),c("sample1","sample2"))
            )
norm_factor <- c(15, 1.2)

# function to normalize a RNA-seq count matrix by norm_factor.
# return normalized matrix.
 