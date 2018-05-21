# review:

# exercise 1: create a function that take a vector, and output whether each
# element is odd or even.
odd_or_even <- function(t) {
  output <- vector()
  for (i in 1:length(t)) {
    if (t[i]%%2 == 1) {
      output[i] <- "odd"
    } else {
      output[i] <- "even"
    }
  }
  return(output)
}
# to apply a function that works with single value to a vector
# apply, tapply
lapply(vector, function_name)
odd_or_even(c(1,3,6,8))

# exercise 2: create the following matrix:
# 1 2
# 3 4
# 5 6
# and compute the sum of each row using apply function
m <- matrix(1:6, 3, 2, byrow = T)
apply(m, 1, sum)


# NOTE: remember to look at the documentation of functions if you don't know that
# they do.

# go to this address: http://www.trii.org/courses/r_spring_2017
# download: mm9.gtf, and rcourse_counttable.txt to Desktop
# if you already have the files on desktop, don't worry about it.
# problem with internet connection. save files somewhere else.

# install bioconductor packages: GenomicRanges and DESeq2

###############
# count table #
###############
setwd("C://Users/yuanh_000/Desktop/R-course/additional_material/")
#setwd("~/Desktop/R-course/additional_material/")
list.files()

cnt.table <- read.table(file = "rcourse_countTable.txt", 
                        header=T, stringsAsFactors = F)
cnt.table[1:5,]
# assign first column as row names
rownames(cnt.table) <- cnt.table[,1]
cnt.table <- cnt.table[,-1]

# for both: source("https://bioconductor.org/biocLite.R")
# for installing DESeq: biocLite("DESeq")
# for installing GenomicRanges: biocLite("GenomicRanges")
library(GenomicRanges)
library(DESeq2)

#####################
# compute gene size #
#####################
refseq <- read.table("mm9.gtf", stringsAsFactors = F)
dim(refseq)
head(refseq) # or refseq[1:6,]
class(refseq)
# create a genomicRange object
refseq.gr <- GRanges(seqnames = refseq$V1,
                     ranges = IRanges(refseq$V4, refseq$V5),
                     strand = refseq$V7,
                     mcols = data.frame(type=refseq$V3, transcript_id=refseq$V13, stringsAsFactors = F)
                     )
exons <- refseq.gr[refseq.gr$mcols.type=="exon"]
# compute gene size
transcript_width <- tapply(X = width(exons), INDEX = exons$mcols.transcript_id, sum)

# make sure same set of genes in count table and gene size vector
length(transcript_width)
dim(cnt.table)
ovlp_genes <- intersect(rownames(cnt.table), names(transcript_width))
cnt.table.new <- cnt.table[ovlp_genes, ]
transcript_width_new <- transcript_width[ovlp_genes]

##################
# calculate rpkm #
##################
# read per kilobase: comparison between genes
# read per million: comparison between samples
get_rpkm <- function(exp, gene_size, coverage) {
  rpkm <- exp/gene_size * 1000 / coverage * 10^6
  return (rpkm)
}

covs <- colSums(cnt.table)

rpkm_m <- matrix( , nrow(cnt.table.new), ncol(cnt.table.new))

for (i in 1:ncol(cnt.table.new) ){
  tmp <- cnt.table.new[,i]
  rpkm_m[,i] <- get_rpkm(tmp, transcript_width_new, covs[i])
}

save(rpkm_m, cnt.table.new, file="session3.rdt")
