#!/usr/bin/env Rscript
# Install required R packages for APOE CRC Analysis

cat("\n=== Installing R packages for APOE CRC Analysis ===\n")

# Check if BiocManager is installed
if (!require("BiocManager", quietly = TRUE)) {
  cat("Installing BiocManager...\n")
  install.packages("BiocManager")
}

# CRAN packages
cran_packages <- c(
  # Data manipulation
  "tidyverse",        # dplyr, ggplot2, tidyr, etc.
  "data.table",       # Fast data handling
  "stringr",          # String manipulation
  
  # Statistics
  "survival",         # Survival analysis
  "survminer",        # Survival visualization
  "igraph",           # Network analysis
  
  # Visualization
  "ggplot2",          # Grammar of graphics
  "gridExtra",        # Arrange multiple plots
  "ComplexHeatmap",   # Advanced heatmaps
  "pheatmap",         # Pretty heatmaps
  "cowplot",          # Combine plots
  
  # Utilities
  "yaml",             # Parse YAML config
  "jsonlite",         # JSON handling
  "lubridate",        # Date manipulation
  "glue",             # String interpolation
  "parallel",         # Parallel computing
  "futile.logger",    # Logging
  
  # Additional
  "corrplot",         # Correlation plots
  "scales",           # Scale utilities
  "RColorBrewer"      # Color palettes
)

# Bioconductor packages
bioc_packages <- c(
  "TCGAbiolinks",     # Download TCGA data
  "limma",            # Differential expression
  "DESeq2",           # RNA-seq analysis
  "edgeR",            # Count data analysis
  "GSVA",             # Gene set variation analysis
  "fgsea",            # Fast GSEA
  "org.Hs.eg.db",     # Human gene annotations
  "AnnotationDbi",    # Database utilities
  "clusterProfiler",  # Enrichment analysis
  "reactome.db"       # Reactome pathway database
)

# Install CRAN packages
cat("\nInstalling CRAN packages...\n")
for (pkg in cran_packages) {
  if (!require(pkg, quietly = TRUE, character.only = TRUE)) {
    cat("Installing", pkg, "...\n")
    install.packages(pkg, dependencies = TRUE)
  } else {
    cat(pkg, "already installed.\n")
  }
}

# Install Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
for (pkg in bioc_packages) {
  if (!require(pkg, quietly = TRUE, character.only = TRUE)) {
    cat("Installing", pkg, "...\n")
    tryCatch(
      BiocManager::install(pkg),
      error = function(e) cat("Warning: Could not install", pkg, "\n")
    )
  } else {
    cat(pkg, "already installed.\n")
  }
}

cat("\n=== Installation complete! ===\n")
cat("To verify installation, run: Rscript -e 'library(tidyverse); library(TCGAbiolinks)'\n")