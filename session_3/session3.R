#Generalized RNA-Seq analysis script
#By:Alexendar R. Perez & Han Yuan
#Memorial Sloan-Kettering Cancer Center, Computational Biology Department
#Christina Leslie Lab

# start by talking about RNA-seq processing pipeline (starting from fastq files)

# install libraries
source("https://bioconductor.org/biocLite.R")
biocLite(c("DESeq","rtracklayer","biomaRt"))
install.packages("NMF")

###########
# library # 
###########

library(DESeq) # for differential expression analysis
library(biomaRt) # for convert between different gene ids and gene symbol (ENTREZ, ENSEMBL, REFSEQ, SYMBOL, etc.)
library(rtracklayer) # for reading gene annotation, alignment files (bam, bed, gtf) into R
library(NMF) # for plot heatmap

setwd("C://users/yuanh_000/Desktop/R-course/session_34/")

#########
# input #
#########

# count table is generated from "summarizeOverlaps" function from "GenomicAlignments" package
Count_Table <- read.table(file='rcourse_countTable.txt',header=TRUE, stringsAsFactors = FALSE)
rownames(Count_Table) <- Count_Table[,1]
Count_Table <- Count_Table[,-1]


################
# compute rpkm #
################
# how to get annotation files from ucsc
# https://genome.ucsc.edu/cgi-bin/hgTables?hgsid=542419345_U8pLmk5hjWHXjaDWGcmoGVFmPW0y
refseq <- read.table("mm9.gtf", stringsAsFactors = F)
refseq.gr <- GRanges(seqnames = refseq$V1, seqinfo = NULL, IRanges(refseq$V4, refseq$V5), 
                     strand = refseq$V7, data.frame(type=refseq$V3, transcript_id=refseq$V13, stringsAsFactors = F))
exons <- refseq.gr[refseq.gr$type=="exon"]
# use tapply to compute gene size
transcript_widths <- tapply(X = width(exons), INDEX = exons$transcript_id, FUN = sum) # introduce tapply


#######################
# filter based on rpk #
#######################
# read per kilobase: compare between genes
# read per million: compare between samples

# filter count table so that it only includes genes in the refseq list.
Count_Table <- Count_Table[ rownames(Count_Table)%in%names(transcript_widths) , ]
transcript_widths_filt <- transcript_widths[rownames(Count_Table)]

# filter gene_widths vector
# calculate Read per kb
# read/widths = read_per_base
# read_per_base * 1000 = read per kilobase
# method 1
rpk <- Count_Table
for (i in 1:ncol(rpk)) {
  rpk[,i] <- rpk[,i]/transcript_widths_filt*1000
}

