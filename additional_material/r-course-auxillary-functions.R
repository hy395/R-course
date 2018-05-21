#######################
# Auxillary Functions #
# 11.8.2017           #
# Han Yuan            #
#######################

# PCA
gen_PCA <- function(cnts) {
  x <- prcomp(t(log(cnts)))
  vars <- round(x$sdev^2/sum(x$sdev^2)*100,1)
  plot(x$x[,1], x$x[,2], xlab=paste0("PC1: ",vars[1],"% variance"), ylab=paste0("PC2: ",vars[2],"% variance"))
  text(x$x[,1], x$x[,2], labels = rownames(x$x), pos = 3)
}

# plot logcount versus logcount
plot_scatter <- function(deseq, res) {
  tmp <- counts(deseq, normalize=T)
  conditions <- levels(deseq$condition)
  
  x <- log2(rowMeans(tmp[,deseq$condition==conditions[1]]))
  y <- log2(rowMeans(tmp[,deseq$condition==conditions[2]]))
  
  plot(x, y, xlim=c(0,max(c(x,y))), ylim=c(0,max(c(x,y))), 
       pch=20, col = ifelse(res$padj< .05, "red", "black"))
  abline(0,1)
}

#convert names from RefSeq to Canonical Gene IDs (Mouse)
Mouse_Name_Converter <- function(refseq_ids){
  mouse <- useMart(host="www.ensembl.org",biomart='ENSEMBL_MART_ENSEMBL', dataset="mmusculus_gene_ensembl")
  Mouse_GeneSymbols <- getBM(attributes=c("mgi_symbol","refseq_mrna"), filters ="refseq_mrna",values=refseq_ids, mart=mouse)
  return(Mouse_GeneSymbols)
}

