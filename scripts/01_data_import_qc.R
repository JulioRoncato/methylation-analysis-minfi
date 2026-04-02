'Load necessary libraries\nlibrary(minfi)\nlibrary(ggplot2)\n\n
# Define function to load IDAT files\nload_idat_files <- function(idat_dirs) {\n  rg_set <- read.metharray.exp(idat_dirs)\n  return(rg_set)\n}\n\n
# Perform quality control\nperform_quality_control <- function(rg_set) {\n  
# Basic QC metrics\n  qc_metrics <- getQC(rg_set)\n  \n  
# Print summary of QC metrics\n  print(qc_metrics)\n\n  
# Generate QC plots\n  png(filename = "qc_report.png")\n  plotQC(rg_set)\n  dev.off()\n  \n  return(qc_metrics)\n}\n\n
# Example usage\nidat_dirs <- "path/to/idat/files"\nrg_set <- load_idat_files(idat_dirs)\nqc_results <- perform_quality_control(rg_set)\n'
