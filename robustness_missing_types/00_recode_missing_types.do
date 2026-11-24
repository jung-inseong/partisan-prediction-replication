* R2-00. Recode GSS missing-value (reserve) codes for the missing-value-type robustness check (Figure S1-B).
* Run from robustness_missing_types/ (the working directory must be this folder).
*
* Input : ../data/gss7224_r3.dta   (GSS 1972-2024 cumulative data, Release 3a)
* Output: data/gss_ml_ready.dta    (input of 01_make_data.ipynb)

* [1] Load data
use "../data/gss7224_r3.dta", clear
set more off

* [2] Numeric variables only
ds, has(type numeric)
local num_vars `r(varlist)'

* [3] Recode the GSS reserve codes into negative codes for machine learning.
* The 14 standard GSS 2024 missing-value codes (.i .n .d .s .z .u .p .f .r .x .y .j .m and the generic .)
* are mapped by meaning into 5 negative buckets (-1 to -4, -9).
foreach var in `num_vars' {

    * (1) Structurally inapplicable -> -1
    * The question was not asked.
    * .i: inapplicable (IAP)
    * .j: "no job" (People Known module, 2006) - structurally inapplicable for job items
    replace `var' = -1 if `var' == .i
    replace `var' = -1 if `var' == .j

    * (2) Cognitive missing (don't know / can't choose) -> -2
    * Suspended attitude or lack of knowledge.
    replace `var' = -2 if `var' == .d

    * (3) Refusal / avoidance (intentional non-response) -> -3
    * .n: no answer, .s: skipped on web - both are "did not answer".
    * .r: refused - refusals of income (income/rincome/income16/rincom16) and the RACEACS items;
    *     a refusal like .n, so the same bucket.
    *     (-3 can be split to study mode/item effects separately)
    replace `var' = -3 if `var' == .n
    replace `var' = -3 if `var' == .s
    replace `var' = -3 if `var' == .r

    * (4) Special / irregular codes -> -4
    * .z: variable-specific reserve code (e.g. 2021 religion module recode)
    * .u: uncodeable - an open-ended answer exists but could not be coded,
    *     grouped with .z as "irregular special".
    replace `var' = -4 if `var' == .z
    replace `var' = -4 if `var' == .u

    * (5) System missing / type cannot be determined -> -9
    * No usable information.
    * .x: not available in this release, .y: not asked in this year, . : generic missing
    * .m: mixed DK/NA/IAP (1970s OCC/INDUSTRY) - the type of missing value cannot be determined.
    * .f: no date of birth (VIETDRAFT), .p: not imputable (POVLINE/INCDEF, 1972-1993)
    replace `var' = -9 if `var' == .x
    replace `var' = -9 if `var' == .y
    replace `var' = -9 if `var' == .
    replace `var' = -9 if `var' == .m
    replace `var' = -9 if `var' == .f
    replace `var' = -9 if `var' == .p
}

* [4] Save
save "data/gss_ml_ready.dta", replace
