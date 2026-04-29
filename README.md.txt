# APOE Isoform Analysis in Colorectal Cancer (TCGA)

## 📋 Overview

Comprehensive bioinformatics pipeline for analyzing APOE isoforms (ε2, ε3, ε4) and their associations with:

- **Expression profiling** - APOE mRNA levels across isoforms
- **Immune infiltration** - CD8+ T cells, CD4+ T cells, Macrophages, B cells, NK cells
- **Mutation burden** - Tumor mutational burden (TMB) and recurrent mutations
- **Pathway analysis** - Hallmark pathway enrichment by APOE isoform
- **Survival analysis** - Overall survival (OS) and disease-free survival (DFS)

## 🎯 Objectives

1. Characterize APOE isoform frequencies in TCGA colorectal cancer (COAD/READ)
2. Identify differential gene expression signatures by APOE isoform
3. Quantify immune cell infiltration patterns
4. Assess mutational burden and pathway activities
5. Evaluate prognostic significance of APOE isoforms
6. Generate publication-quality figures

## 🚀 Quick Start

### Prerequisites
- R >= 4.0
- Python >= 3.8
- ~10 GB disk space

### Installation

```bash
Rscript install_packages.R
pip install -r requirements.txt
Rscript scripts/01_data_download.R
Rscript scripts/02_apoe_genotyping.R
Rscript scripts/03_expression_analysis.R
Rscript scripts/04_immune_deconvolution.R
Rscript scripts/05_mutation_analysis.R
Rscript scripts/06_pathway_analysis.R
Rscript scripts/07_survival_analysis.R
Rscript scripts/08_generate_figures.R

6. **Save the file** (Ctrl+S)

---

## **Confirm When Done:**

Reply with: ✅ **"README.md created"**

Then I'll give you the next file! 📝