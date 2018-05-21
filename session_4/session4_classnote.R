#############
# session 4 #
#############

# before we start:
# go to: http://www.trii.org/courses/r_spring_2017/
# download to Desktop: session3.rdt
# download to Desktop: r-course-auxillary-functions.R
# install the following libraries
#source("https://bioconductor.org/biocLite.R")
#biocLite("biomaRt")

# load the following libraries: DESeq, NMF, biomaRt
# install through bioconductor
library(DESeq2)
library(biomaRt)
# install by install.packages function
library(pheatmap)

# load the data we saved
setwd("~/Desktop/R-course/session_4/")
source("r-course-auxillary-functions.R")
load("session3.rdt")

# read the data, repeat the filtering
dim(cnt.table.new)
dim(rpkm_m)
a <- rowSums(rpkm_m)
cnt.filter <- cnt.table.new[rowSums(rpkm_m) > 0.1,]
cnt.filter <- cnt.filter + 1

# create DESeq object
conds <- factor(c(rep("treatment", 4), rep("control", 2)), 
                levels = c("control", "treatment"))
dds <- DESeqDataSetFromMatrix(data.frame(cnt.filter), colData=data.frame(condition=conds), design=~condition)

# run DESeq
deseq <- DESeq(dds)
sizeFactors(dds)
cnt.norm <- counts(deseq, normalize=T)

# PCA
gen_PCA(cnt.norm)

# perform differential expression analysis
res <- results(deseq, independentFiltering = F)

#convert id
id_map <- Mouse_Name_Converter(rownames(res))
# to add symbols to nbt table
id_map <- id_map[!duplicated(id_map[,2]),] # remove duplicated refseq ids from map
rownames(id_map) <- id_map[,2] # add rownames
res$symbol <- id_map[rownames(res),1] # index

# log count
plot_scatter(deseq, res)

# heatmap
rownames(cnt.norm) <- res$symbol
toplot <- cnt.norm[res$pvalue < 0.05 & abs(res$log2FoldChange) > 1 , ]
pdf("Rplot.pdf", 10, 10)
pheatmap(t(scale(t(toplot))))
dev.off()

# volcano plot
toplot <- nbt[nbt$pval < 0.05 & abs(nbt$log2FoldChange) > 1 , ]
plot(nbt$log2FoldChange, -log10(nbt$padj), 
     pch=20, xlim=c(-3,3), ylim=c(0,7), 
     col = ifelse(nbt$padj< .05, "red", "black"))
text(nbt$log2FoldChange[nbt$padj<0.05], 
     -log10(nbt$padj)[nbt$padj<0.05],
     labels = nbt$symbol[nbt$padj<0.05], pos=3)


