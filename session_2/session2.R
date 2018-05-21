########
# data #
########
dudes <- c("Alex","Han")
ages <- c(26,25)
hot <- c(FALSE,TRUE)
single <- c(TRUE,FALSE)
df <- data.frame(dudes,ages,hot,single)
rownames(df) <- c('man1','man2')
colnames(df) <- c('guys','yrs','friendly','salty')

####################
# input and output #
####################
#write out to csv file
write.csv(df,"~/Desktop/best_df_ever.csv")
df2 <- read.csv(file='~/Desktop/best_df_ever.csv')
write.table(df,"~/Desktop/best_df_ever.txt")
df3 <- read.table(file="~/Desktop/best_df_ever.txt")
df4 <- read.delim("~/Desktop/best_df_ever.txt",sep=' ')

#all the write out we did were in human readable format. Human readable formats let us 
#interpret the output, but it takes up a relatively large amount of space on the drive.
#We can reduce this file footprint by saving it in binary format.

#################
# binary format #
#################
saveRDS(df,"~/Desktop/df.rds")
df5 <- readRDS('~/Desktop/df.rds')

#####################
# control structure #
#####################
#control structures
#control structure depends on boolian operators. This means that logical conditions must
#be met or rejected for an instruction to be executed

# conditional operators: >, <, <=, >=, ==, &, |
x <- 100
y <- 20

x > 10
y > 40
x > 10 & y <= 20
x > 10 | y ==0

# if else structure
x <- 99
if (x < 100) {
  show ("x is less than 100")
  } else {
    show ("x is greater than equal to 100")
} 

#for loop
for (i in 1:10){
  print(i*2)
}

#############
# functions #
#############
#functions are modular pieces of code that execute a set of instructions given certain 
#input parameters. Their variables are local to the function and they can be thought of as
#mini scripts in your larger script

#function toy example
odd_or_even <- function(x){
  if(is.numeric(x) == TRUE){
    if(x %% 2 == 0){return("even")}
    else{return("odd")}
  }else{return("not number")}
}

################
# arithemetics #
################
# vectorized operations, point by point multiplication. Very powerful use in R
x <- c(1, 10, 30, 50)
x + 1
x - 1
x * 10
x / 10
y <- c(100, 20, 22, 44)
x + y
y <- c(1, 2)
x + y

# matrix
x <- matrix (1:4, nrow=2, ncol=2)
x + 2
y <- matrix (10, nrow=2, ncol=3)
x + y
x * y
y %*% x

#########################
# apply, lapply, tapply #
#########################
tapply(X = width(exons), INDEX = exons$transcript_id, FUN = sum)

#########
# other #
#########
c("a","d")%in%c("a","b","c")
# different plotting methods
