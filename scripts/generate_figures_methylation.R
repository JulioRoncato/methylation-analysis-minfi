# R script to generate figures for methylation analysis

# Load necessary libraries
library(ggplot2)
library(ComplexHeatmap)
library(ggrepel)
library(DESeq2)

# Random seed for reproducibility
set.seed(123)

# Simulating TCGA-like methylation data
n_genes <- 1000
n_samples <- 50
meth_data <- replicate(n_genes, rnorm(n_samples))
colnames(meth_data) <- paste0("Sample_", 1:n_samples)
row.names(meth_data) <- paste0("CpG_", 1:n_genes)

# Create output directory if it doesn't exist
if (!dir.exists('figures')) dir.create('figures')

# 1) QC beta-value distribution plot
beta_values <- apply(meth_data, 2, mean)
qc_plot <- ggplot(data.frame(Beta_Values = beta_values), aes(x = Beta_Values)) + 
  geom_histogram(bins = 30, fill = 'blue', alpha = 0.7) + 
  labs(title = 'QC Beta-Value Distribution', x = 'Beta Values', y = 'Frequency') + 
  theme_minimal()
ggsave('figures/qc_beta_value_distribution.png', plot = qc_plot)

# 2) Heatmap of top differentially methylated CpGs
# Simulating differential methylation results
diff_methylation_indices <- sample(1:n_genes, 50)
diff_methylated_data <- meth_data[diff_methylation_indices, ]
heatmap_plot <- Heatmap(diff_methylated_data, name = "Methylation", column_title = "Samples", row_title = "CpGs", show_row_names = TRUE)
png('figures/heatmap_top_diff_methylated.png')
draw(heatmap_plot)
dev.off()

# 3) Manhattan plot showing -log10(p-values) across genome
manhattan_data <- data.frame(CpG = paste0("CpG_", 1:n_genes), P_Value = runif(n_genes)
)
manhattan_data$Negative_Log10_PValue <- -log10(manhattan_data$P_Value)
manhattan_plot <- ggplot(manhattan_data, aes(x = 1:n_genes, y = Negative_Log10_PValue)) + 
  geom_point(alpha = 0.5) + 
  labs(title = 'Manhattan Plot of Methylation Data', x = 'CpGs', y = '-log10(p-values)') + 
  theme_minimal()
ggsave('figures/manhattan_plot.png', plot = manhattan_plot)

# 4) Volcano plot of differential methylation results
volcano_data <- data.frame(CpG = paste0("CpG_", 1:n_genes), logFC = rnorm(n_genes), P_Value = runif(n_genes))
volcano_data$Negative_Log10_PValue <- -log10(volcano_data$P_Value)
volcano_plot <- ggplot(volcano_data, aes(x = logFC, y = Negative_Log10_PValue)) + 
  geom_point(alpha = 0.5) + 
  labs(title = 'Volcano Plot of Differential Methylation', x = 'Log Fold Change', y = '-log10(p-values)') + 
  theme_minimal()
ggsave('figures/volcano_plot.png', plot = volcano_plot)
