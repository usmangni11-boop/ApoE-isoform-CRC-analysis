# APOE Isoform Analysis in Colorectal Cancer (TCGA)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![R](https://img.shields.io/badge/R-%3E%3D4.2-276DC3?logo=r)](https://www.r-project.org/)
[![Python](https://img.shields.io/badge/Python-%3E%3D3.9-3776AB?logo=python)](https://www.python.org/)

---

## 📋 Overview

Comprehensive bioinformatics pipeline for analyzing APOE isoforms (ε2, ε3, ε4) and their associations with:

- **Expression profiling** — APOE mRNA levels across isoforms
- **Immune infiltration** — CD8+ T cells, CD4+ T cells, Macrophages, B cells, NK cells
- **Mutation burden** — Tumor mutational burden (TMB) and recurrent mutations
- **Pathway analysis** — Hallmark pathway enrichment by APOE isoform
- **Survival analysis** — Overall survival (OS) and disease-free survival (DFS)

## 🎯 Objectives

1. Characterize APOE isoform frequencies in TCGA colorectal cancer (COAD/READ)
2. Identify differential gene expression signatures by APOE isoform
3. Quantify immune cell infiltration patterns
4. Assess mutational burden and pathway activities
5. Evaluate prognostic significance of APOE isoforms
6. Generate publication-quality figures

---

## 🗂️ Repository Structure

```text
apoe-crc-analysis/
│
├── README.md
├── LICENSE
├── requirements.txt              # Python dependencies
├── renv.lock                     # R environment snapshot (renv)
│
├── data/
│   ├── raw/                      # Raw TCGA downloads (not tracked by git)
│   │   ├── clinical/             # Clinical & demographic data
│   │   ├── expression/           # HTSeq-Counts / FPKM matrices
│   │   └── mutation/             # MAF somatic mutation files
│   ├── processed/                # Cleaned, merged, analysis-ready tables
│   └── external/                 # Gene sets, annotation references
│
├── scripts/
│   ├── 01_data_download.R        # Fetch TCGA COAD/READ via TCGAbiolinks
│   ├── 02_isoform_classification.R  # Genotype APOE isoforms (rs429358/rs7412)
│   ├── 03_differential_expression.R # DESeq2 / limma-voom DEG analysis
│   ├── 04_immune_infiltration.R  # CIBERSORT / TIMER / xCell deconvolution
│   ├── 05_mutation_analysis.R    # TMB calculation & oncoplot generation
│   ├── 06_pathway_enrichment.R   # GSEA / ssGSEA with MSigDB Hallmarks
│   ├── 07_survival_analysis.R    # Kaplan-Meier & Cox regression
│   └── utils.R                   # Shared helper functions
│
├── notebooks/                    # Exploratory Jupyter / R Markdown notebooks
│   ├── exploration.Rmd
│   └── figures_draft.Rmd
│
├── results/
│   ├── tables/                   # Summary statistics, DEG lists (CSV/TSV)
│   ├── figures/                  # Publication-quality plots (PDF/PNG)
│   └── reports/                  # Rendered HTML/PDF reports
│
└── config/
    └── params.yaml               # Centralized parameters (thresholds, paths)
```

---

## ⚙️ Installation & Setup

### Prerequisites

| Tool    | Version | Purpose                        |
|---------|---------|--------------------------------|
| R       | ≥ 4.2   | Core statistical analysis      |
| Python  | ≥ 3.9   | Data wrangling, supplementary  |
| Git     | ≥ 2.30  | Version control                |

### 1. Clone the Repository

```bash
git clone https://github.com/usmangni11-boop/ApoE-isoform-CRC-analysis.git
cd ApoE-isoform-CRC-analysis
```

### 2. Set Up the R Environment

This project uses [`renv`](https://rstudio.github.io/renv/) for reproducible R package management:

```r
# Inside R console
install.packages("renv")
renv::restore()          # Installs all pinned R packages from renv.lock
```

### 3. Install Python Dependencies (optional)

```bash
python -m venv .venv
source .venv/bin/activate        # Linux/macOS
# .venv\Scripts\activate         # Windows
pip install -r requirements.txt
```

### 4. Configure Parameters

Edit `config/params.yaml` to set project-wide thresholds and file paths:

```yaml
# config/params.yaml
tcga_project:
  - "TCGA-COAD"
  - "TCGA-READ"
apoe_snps:
  - "rs429358"
  - "rs7412"
deg_thresholds:
  padj: 0.05
  log2fc: 1.0
survival:
  time_col: "OS.time"
  event_col: "OS"
```

---

## 🔬 Pipeline Steps

The analysis is designed to run sequentially. Each script reads from `data/` and writes outputs to `results/`.

| Step | Script | Description |
|------|--------|-------------|
| 1 | `01_data_download.R` | Downloads COAD/READ expression, mutation, and clinical data from GDC via `TCGAbiolinks` |
| 2 | `02_isoform_classification.R` | Classifies patients into ε2/ε3/ε4 carriers using rs429358 and rs7412 genotypes |
| 3 | `03_differential_expression.R` | Performs DEG analysis (DESeq2 or limma-voom) between isoform groups; generates volcano and heatmap plots |
| 4 | `04_immune_infiltration.R` | Estimates immune cell fractions via CIBERSORT/TIMER/xCell; produces grouped boxplots and correlation matrices |
| 5 | `05_mutation_analysis.R` | Calculates TMB per isoform group; generates oncoplots of recurrent mutations using `maftools` |
| 6 | `06_pathway_enrichment.R` | Runs GSEA/ssGSEA against MSigDB Hallmark gene sets; outputs enrichment dot plots |
| 7 | `07_survival_analysis.R` | Fits Kaplan-Meier curves and multivariate Cox models for OS and DFS stratified by APOE isoform |

---

## 🚀 Usage

### Run the Full Pipeline

```bash
# From the project root
Rscript scripts/01_data_download.R
Rscript scripts/02_isoform_classification.R
Rscript scripts/03_differential_expression.R
Rscript scripts/04_immune_infiltration.R
Rscript scripts/05_mutation_analysis.R
Rscript scripts/06_pathway_enrichment.R
Rscript scripts/07_survival_analysis.R
```

### Run a Single Step

```bash
Rscript scripts/04_immune_infiltration.R
```

### Render a Report

```r
rmarkdown::render("notebooks/exploration.Rmd", output_dir = "results/reports/")
```

### Customize Parameters

All tunable thresholds (adjusted p-value cutoffs, log2FC thresholds, survival endpoints) are centralized in `config/params.yaml` — modify there rather than editing scripts directly.

---

## 📦 Key Dependencies

### R Packages

| Package | Purpose |
|---------|---------|
| `TCGAbiolinks` | TCGA data acquisition |
| `DESeq2` / `limma` | Differential expression |
| `GSVA` | Single-sample GSEA |
| `clusterProfiler` | Pathway enrichment & visualization |
| `survival` / `survminer` | Kaplan-Meier & Cox regression |
| `maftools` | Somatic mutation analysis |
| `ggplot2` / `ComplexHeatmap` | Publication-quality visualization |
| `CIBERSORT` | Immune cell deconvolution |

### Python Packages (optional)

| Package | Purpose |
|---------|---------|
| `pandas` / `numpy` | Data manipulation |
| `matplotlib` / `seaborn` | Supplementary plotting |
| `lifelines` | Survival analysis cross-validation |

---

## 📊 Expected Outputs

| Output | Location | Format |
|--------|----------|--------|
| DEG tables | `results/tables/` | CSV |
| Volcano & heatmap plots | `results/figures/` | PDF, PNG |
| Immune infiltration boxplots | `results/figures/` | PDF, PNG |
| Oncoplots & TMB barplots | `results/figures/` | PDF, PNG |
| Pathway enrichment dot plots | `results/figures/` | PDF, PNG |
| Kaplan-Meier survival curves | `results/figures/` | PDF, PNG |
| Summary reports | `results/reports/` | HTML, PDF |

---

## 📝 Data Access & Ethics

- All data are sourced from the publicly available [TCGA Program](https://portal.gdc.cancer.gov/) (COAD and READ projects).
- No patient-identifiable information is used beyond de-identified TCGA barcodes.
- Use of TCGA data is subject to the [GDC Data Use Agreement](https://gdc.cancer.gov/access-data/data-access-policies).

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m "Add your feature"`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

Please ensure all scripts run cleanly and outputs are reproducible before submitting.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 📖 Citation

If you use this pipeline or its results in your work, please cite:

```
@misc{apoe_crc_analysis,
  author       = {Ghani},
  title        = {APOE Isoform Analysis in Colorectal Cancer (TCGA)},
  year         = {2026},
  url          = {https://github.com/usmangni11-boop/ApoE-isoform-CRC-analysis}
}
```

---

## 📬 Contact

For questions, collaborations, or issues, please open a [GitHub Issue](https://github.com/usmangni11-boop/ApoE-isoform-CRC-analysis/issues) or reach out directly.

