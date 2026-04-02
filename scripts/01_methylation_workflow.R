# 01_methylation_workflow.R
# This script outlines a comprehensive workflow for DNA methylation analysis
# using Minfi and related packages.
# It covers data import, normalization, differential methylation analysis,
# DMR detection, functional annotation, and visualization.

# Load necessary packages
library(minfi)
library(limma)
library(DMRcut)
library(heatmaply)
library(ggplot2)
library(sva)

# 1. Data Import and Quality Control

# Importing TCGA DNA methylation data
# Modify the path to your local data
data_path <- "path/to/your/TCGA_methylation_data"
rgSet <- read.metharray.exp(data_path)

# Perform quality control
qcReport(rgSet, pdf = "qc_report.pdf")

# 2. Normalization (NOOB and SWAN)

# NOOB normalization
mSetNOOB <- preprocessNoob(rgSet)

# SWAN normalization
mSetSWAN <- preprocessSWAN(rgSet)

# 3. Differential Methylation Analysis with limma

# Create design matrix for your groups (e.g., Tumor vs. Normal)
design <- model.matrix(~ factor(c(rep(0, num_normal_samples), rep(1, num_tumor_samples))))

# Fit the model
fit <- lmFit(mSetNOOB, design)
fit <- eBayes(fit)

# Get results
results <- topTable(fit, adjust = "fdr", sort.by = "P", number = Inf)

# 4. DMR Detection

# DMR detection using DMRcate
dmrcate_results <- DMRcate(mSetNOOB, p.threshold=0.05)

# 5. Functional Annotation

# Perform functional annotation
library(ChIPseeker)
annotation <- annotatePeak(rownames(dmrcate_results), tssRegion=c(-3000, 3000), TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene)

# 6. Visualization

# Heatmap of differentially methylated regions
heatmaply::heatmaply(results[,1:50], main = "Top 50 Differentially Methylated Regions")

# Manhattan plot
ggplot(data=results, aes(x=1:nrow(results), y=-log10(P.Value))) +
  geom_point() +
  labs(title="Manhattan Plot of Differential Methylation", x="CpG Sites", y="-log10(P-value)")

# PCA plot
pca <- prcomp(t(mSetNOOB), center = TRUE, scale. = TRUE)
pca_data <- as.data.frame(pca$x)
ggplot(pca_data, aes(x=PC1, y=PC2, color=factor(your_groups))) +
  geom_point() +
  labs(title="PCA of Methylation Data")

# Example usage with TCGA data structure is provided in the comments.
