# Contributing to APOE Isoform CRC Analysis

Thank you for your interest in contributing to this project! This document
provides guidelines to help you get started.

---

## How to Contribute

### 1. Report Issues

If you find a bug, have a question, or want to suggest an improvement:

- Open a [GitHub Issue](https://github.com/usmangni11-boop/ApoE-isoform-CRC-analysis/issues)
- Use a clear, descriptive title
- Include steps to reproduce (for bugs)
- Mention your R/Python version and operating system

### 2. Suggest Enhancements

We welcome ideas for:

- New analysis modules (e.g., methylation, copy number variation)
- Additional immune deconvolution methods
- Improved visualizations
- Performance optimizations

### 3. Submit Code Changes

#### Fork & Branch Workflow

```bash
# 1. Fork the repository on GitHub

# 2. Clone your fork
git clone https://github.com/<your-username>/ApoE-isoform-CRC-analysis.git
cd ApoE-isoform-CRC-analysis

# 3. Create a feature branch
git checkout -b feature/your-feature-name

# 4. Make your changes and commit
git add .
git commit -m "Add: brief description of your change"

# 5. Push to your fork
git push origin feature/your-feature-name

# 6. Open a Pull Request on GitHub
```

---

## Code Style Guidelines

### R Scripts

- Follow the [tidyverse style guide](https://style.tidyverse.org/)
- Use `<-` for assignment (not `=`)
- Use `snake_case` for variable and function names
- Add roxygen-style comments for functions:

```r
#' @title Calculate Tumor Mutational Burden
#' @param maf_data A data frame of MAF-formatted mutations
#' @param exome_size Exome size in Mb (default: 38)
#' @return Numeric vector of TMB values
calculate_tmb <- function(maf_data, exome_size = 38) {
  # implementation
}
```

### Python Scripts

- Follow [PEP 8](https://peps.python.org/pep-0008/)
- Use type hints where possible
- Use `snake_case` for functions and variables

### General

- Keep scripts modular — one analysis step per script
- Read parameters from `config/params.yaml` (not hardcoded values)
- Write outputs to the appropriate `results/` subfolder
- Add comments explaining **why**, not just **what**

---

## Pipeline Conventions

| Convention | Rule |
|------------|------|
| Script naming | `XX_step_name.R` (numbered sequentially) |
| Data flow | `data/raw/` → `data/processed/` → `results/` |
| Configuration | All thresholds and paths in `config/params.yaml` |
| Figures | Save to `results/figures/` as PDF (primary) + PNG (preview) |
| Tables | Save to `results/tables/` as CSV |

---

## Reproducibility Checklist

Before submitting a Pull Request, please ensure:

- [ ] Scripts run end-to-end without errors
- [ ] New R packages are added to `renv.lock` (`renv::snapshot()`)
- [ ] New Python packages are added to `requirements.txt`
- [ ] Output figures and tables are generated correctly
- [ ] No hardcoded file paths (use `config/params.yaml`)
- [ ] No proprietary data is included (e.g., CIBERSORT source code)
- [ ] Code is commented and readable

---

## Data Policy

- **Do not** commit raw TCGA data to the repository
- **Do not** include the proprietary CIBERSORT.R source file
- **Do not** include patient-identifiable information
- All data should be downloadable via the pipeline scripts

---

## Questions?

Open an [issue](https://github.com/usmangni11-boop/ApoE-isoform-CRC-analysis/issues) or reach out directly. All contributions — big or small — are appreciated!
