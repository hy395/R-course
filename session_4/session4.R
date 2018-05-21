
#############
# session 4 #
#############
# before we start:
# go to: http://www.trii.org/courses/r_spring_2017/
# download to Desktop: session3.rdt
# download to Desktop: r-course-auxillary-functions.R

# additional libraries to install
# ComplexHeatmap
# biomaRt
install.packages("NMF")
library(DESeq)
library(NMF)
library(biomaRt)

load("session3.rdt")
# filter
cnt.final <- cnt.table.new [rowSums(rpkm_m) > 0.1, ]
cnt.final <- cnt.final + 1

##################
# DESeq analysis #
##################
conds <- factor(c('exp','exp','exp','exp','control','control'))
Alpha <- newCountDataSet(cnt.final, conds)
Alpha <- estimateSizeFactors(Alpha) # DESeq make the assumption that only a minority of genes are differentially expressed between two conditions
Alpha <- estimateDispersions(Alpha)
nbt <- nbinomTest(Alpha, 'control', 'exp')
nbt_significant_log2FC <- nbt[nbt$padj<=0.05 & abs(nbt$log2FoldChange) >=1,]

# source all the functions for plotting
source("r-course-auxillary-functions.R")

###############
# convert IDs #
###############
id_map <- Mouse_Name_Converter(nbt$id)

#######
# PCA #
#######
cnt.norm <- counts(Alpha, normalize=T)
gen_PCA(cnt.norm)

#############
# log count #
#############
plot_scatter(nbt)

###########
# Heatmap #
###########
toplot <- cnt.norm[nbt$pval < 0.05, ]
aheatmap(t(scale(t(toplot))))

