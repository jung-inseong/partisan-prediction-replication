# The Changing Predictability of American Partisanship — replication code

Code for the analyses in the paper, using the General Social Survey (GSS), 1988–2024.

## Data

The GSS data are not included. Download the **GSS 1972–2024 Cross-Sectional Cumulative Data, Release 3a**
(Stata format) from NORC (https://gss.norc.org/get-the-data) and save it as `data/gss7224_r3.dta`.

`data/occ10-to-egp-class-crosswalk.csv` (2010 Census occupation codes → EGP classes) is included.
`inputs/` holds the final feature lists with their variable metadata.

## Setup

Python 3.12 with the packages in `requirements.txt`:

```
pip install -r requirements.txt
```

## Running

Run the notebooks in order from the repository root. Results are written to `outputs/`.

| Notebook | Content | Paper |
|---|---|---|
| `01_make_data` | Preliminary-model data (party identity) | |
| `02_preliminary` | Preliminary model, all variables | Figure S1-A |
| `03_preliminary_logit` | Preliminary model, logistic regression | Figure S2 |
| `04_feature_selection` | Feature selection (M1/M3/M4, top 10–90) | Figure S3 |
| `05_final_model` | Final model (40 variables per ballot) | Figure 2-A |
| `06_parsimonious_models` | Reduced models | Figure 2-C–F, S4 |
| `07_descriptives` | Descriptive statistics and trends | Table S1, Figures 3–4 |
| `08_race_sex_make_data` | Preliminary-model data (race and sex) | |
| `09_race_sex_preliminary` | Preliminary race and sex models | |
| `10_race_sex_feature_selection` | Feature selection (race and sex) | |
| `11_race_sex_final` | Final race and sex models | Figure 5 |
| `12_figures` | Figures and Table 1 from the saved results | Figures 2, 5, S1–S4, Table 1 |

Each model is trained with 5-fold cross-validation repeated 20 times, so the full set of notebooks takes many hours.

### Robustness check: missing-value types (Figure S1-B)

In `robustness_missing_types/`, run `00_recode_missing_types.do` (Stata), then `01_make_data.ipynb` and
`02_preliminary.ipynb`, all from inside that folder.

## License

MIT (see `LICENSE`).
