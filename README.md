# 🧬 DNA Methylation Analysis with minfi - TCGA Data

## 🔬 Biological Background

DNA methylation is an epigenetic modification that regulates gene expression without altering DNA sequence. Aberrant methylation patterns are hallmarks of cancer, including:
- **Hypermethylation** of CpG islands in promoter regions (gene silencing)
- **Hypomethylation** of repetitive elements (chromosomal instability)

This project analyzes methylation patterns from TCGA datasets to identify cancer-specific methylation signatures.

---

## 🧪 Experimental Design

Illumina 450K or EPIC methylation microarray data from TCGA cohorts (e.g., BRCA, LUAD, COAD)

| Analysis Type | Goal |
|---|---|
| Quality Control | Detect failed samples, technical artifacts |
| Normalization | Remove batch effects (Noob, SSN, SWAN) |
| Differential Methylation | Identify DM-CpGs between phenotypes |
| DMR Detection | Regional methylation changes |

---

## ⚙️ Bioinformatics Workflow

### 1️⃣ Data Import & Quality Control
- Load IDAT files using **minfi**
- Quality metrics (detection p-values, intensities)
- Sample filtering based on QC thresholds

### 2️⃣ Normalization
- **NOOB** (Normal-Exponential Out-of-Band) normalization
- **SWAN** (Subset-Quantile Within Array Normalization)
- Batch effect removal with **ComBat** or **SVA**

### 3️⃣ Differential Methylation Analysis
- Beta-value analysis with **limma**
- DMR detection with **DMRcate** or **Bumphunter**
- Annotation to genes and regulatory regions

### 4️⃣ Functional Annotation
- CpG island status
- Gene promoter associations
- Pathway enrichment of hypermethylated genes

### 5️⃣ Visualization
- Heatmaps of top DM-CpGs
- Manhattan plots
- CpG density across chromosomes
- PCA/MDS for sample relationships

---

## 📊 Data Visualization

### Quality Control
![QC Plots](figures/methylation_qc.png)

### Differential Methylation
![DMR Heatmap](figures/dmr_heatmap.png)

### Functional Enrichment
![Pathway Enrichment](figures/methylation_enrichment.png)

---

## 🔐 Data Source

Methylation data from The Cancer Genome Atlas (TCGA)
- **Cohorts**: BRCA, LUAD, COAD, OV
- **Platform**: Illumina 450K/EPIC array

---

## 🛠️ Tools and R Packages Used

### R / Bioconductor
- **minfi** - Preprocessing and analysis of Illumina methylation microarrays
- **limma** - Differential methylation analysis
- **DMRcate** - Detection and annotation of differentially methylated regions
- **IlluminaHumanMethylation450kanno.ilmn12.hg19** - Annotation package
- **SVA** - Surrogate Variable Analysis (batch correction)
- **ggplot2** - Visualization

### Databases
- TCGA (https://www.cancer.gov/ccg/research/genome-sequencing/tcga)
- CpG Island Database

---

## 📌 Clinical Relevance

This project demonstrates:
- Identification of **cancer-specific methylation biomarkers**
- **Epigenetic stratification** of tumor subtypes
- Application of methylation patterns for **prognosis and treatment prediction**
- Connection between epigenetic changes and gene silencing in cancer

---

## ⚠️ Considerations

- **Microarray vs Sequencing**: This analysis uses microarray data (targeted CpG coverage)
- **Batch Effects**: TCGA samples processed across multiple centers; batch correction is critical
- **FDR Control**: Multiple testing correction necessary for millions of CpG sites
