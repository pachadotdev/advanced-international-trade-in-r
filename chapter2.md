# Chapter 2. The Heckscher-Ohlin Model

# Exercise 0

## Feenstra’s code

``` stata
* This is to read the data into Stata *

set mem 30m
insheet using c:\Empirical_Exercise\Chapter_2\hov_pub.csv
rename v1 country
rename v2 factor
rename v3 AT
rename v4 V
rename v5 Y
rename v6 B
rename v7 YPC
rename v8 POP

* create country index *
quietly summarize YPC
local maxYPC=_result(6)
gen ratio=YPC/`maxYPC'
replace ratio=ratio+0.0001 if country=="Italy"

sort ratio
egen indexc=group(ratio)

* create factor index *
sort factor
egen indexf=group(factor)

* include delta *

gen delta=1
replace delta=0.03 if country=="Bangladesh"
replace delta=0.09 if country=="Pakistan"
replace delta=0.10 if country=="Indonesia"
replace delta=0.09 if country=="Sri Lanka"
replace delta=0.17 if country=="Thailand"
replace delta=0.16 if country=="Colombia"
replace delta=0.28 if country=="Panama"
replace delta=0.29 if country=="Yugoslavia"
replace delta=0.14 if country=="Portugal"
replace delta=0.11 if country=="Uruguay"
replace delta=0.45 if country=="Greece"
replace delta=0.55 if country=="Ireland"
replace delta=0.42 if country=="Spain"
replace delta=0.49 if country=="Israel"
replace delta=0.40 if country=="Hong Kong"
replace delta=0.38 if country=="New Zealand"
replace delta=0.60 if country=="Austria"
replace delta=0.48 if country=="Singapore"
replace delta=0.60 if country=="Italy"
replace delta=0.58 if country=="UK"
replace delta=0.70 if country=="Japan"
replace delta=0.65 if country=="Belgium"
replace delta=0.47 if country=="Trinidad"
replace delta=0.72 if country=="Netherlands"
replace delta=0.65 if country=="Finland"
replace delta=0.73 if country=="Denmark"
replace delta=0.78 if country=="West Germany"
replace delta=0.74 if country=="France"
replace delta=0.57 if country=="Sweden"
replace delta=0.69 if country=="Norway"
replace delta=0.79 if country=="Switzerland"
replace delta=0.55 if country=="Canada"
replace delta=1 if country=="USA"

compress

label var country "Name of the country"
label var factor "Name of the factor"
label var AT "Factor content of trade F=A*T"
label var V "Endowment"
label var Y "GDP, World Bank, y=p*Q"
label var B "Trade balance, World Bank b=p*T"
label var YPC "GDP per capita, PWT"
label var indexc "Country indentifier"
label var indexf "Factor Indentifier"

save c:\Empirical_Exercise\Chapter_2\trefler,replace

exit
```

## My code

``` r
# Packages ----

library(archive)
library(readr)
library(dplyr)
```


    Attaching package: 'dplyr'

    The following objects are masked from 'package:stats':

        filter, lag

    The following objects are masked from 'package:base':

        intersect, setdiff, setequal, union

``` r
library(haven)

# Extract ----

fzip <- "first-edition/Chapter-2.zip"
dout <- gsub("\\.zip$", "", fzip)

if (!dir.exists(dout)) {
  archive_extract("first-edition/Chapter-2.zip",
    dir = "first-edition/Chapter-2"
  )
}

# Read ----

hov_pub <- read_csv("first-edition/Chapter-2/hov_pub.csv", col_names = F) %>%
  rename(
    country = X1,
    factor = X2,
    at = X3,
    v = X4,
    y = X5,
    b = X6,
    ypc = X7,
    pop = X8
  )
```

    Rows: 297 Columns: 8

    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (2): X1, X2
    dbl (6): X3, X4, X5, X6, X7, X8

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
# Transform ----

# see https://www.stata.com/manuals/rsummarize.pdf
# https://www.stata.com/manuals/degen.pdf
# https://www.stata.com/manuals/degen.pdf

hov_pub <- hov_pub %>%

  mutate(ypc_max = max(ypc)) %>%
  mutate(
    ratio = case_when(
      country != "Italy" ~ ypc / ypc_max,
      country == "Italy" ~ (ypc / ypc_max) + 0.0001
    )
  ) %>%
  
  select(-ypc_max) %>%
  arrange(ratio) %>%
  
  group_by(ratio) %>%
  mutate(indexc = cur_group_id()) %>%

  group_by(factor) %>%
  mutate(indexf = cur_group_id()) %>%

  mutate(
    delta = case_when(
      country == "Bangladesh" ~ 0.03,
      country == "Pakistan" ~ 0.09,
      country == "Indonesia" ~ 0.10,
      country == "Sri Lanka" ~ 0.09,
      country == "Thailand" ~ 0.17,
      country == "Colombia" ~ 0.16,
      country == "Panama" ~ 0.28,
      country == "Yugoslavia" ~ 0.29,
      country == "Portugal" ~ 0.14,
      country == "Uruguay" ~ 0.11,
      country == "Greece" ~ 0.45,
      country == "Ireland" ~ 0.55,
      country == "Spain" ~ 0.42,
      country == "Israel" ~ 0.49,
      country == "Hong Kong" ~ 0.40,
      country == "New Zealand" ~ 0.38,
      country == "Austria" ~ 0.60,
      country == "Singapore" ~ 0.48,
      country == "Italy" ~ 0.60,
      country == "UK" ~ 0.58,
      country == "Japan" ~ 0.70,
      country == "Belgium" ~ 0.65,
      country == "Trinidad" ~ 0.47,
      country == "Netherlands" ~ 0.72,
      country == "Finland" ~ 0.65,
      country == "Denmark" ~ 0.73,
      country == "West Germany" ~ 0.78,
      country == "France" ~ 0.74,
      country == "Sweden" ~ 0.57,
      country == "Norway" ~ 0.69,
      country == "Switzerland" ~ 0.79,
      country == "Canada" ~ 0.55,
      country == "USA" ~ 1,
      TRUE ~ 1
    )
  )

# Labels ----

# Add stata-like labels to the columns

# maybe this is not the best way to do it, but it works
attr(hov_pub$country, "label") <- "Name of the country"
attr(hov_pub$factor, "label") <- "Name of the factor"
attr(hov_pub$at, "label") <- "Factor content of trade F=A*T"
attr(hov_pub$v, "label") <- "Endowment"
attr(hov_pub$y, "label") <- "GDP, World Bank, y=p*Q"
attr(hov_pub$b, "label") <- "Trade balance, World Bank b=p*T"
attr(hov_pub$ypc, "label") <- "GDP per capita, PWT"
attr(hov_pub$indexc, "label") <- "Country indentifier"
attr(hov_pub$indexf, "label") <- "Factor Indentifier"

# Save ----

fout <- paste0(dout, "/trefler.rds")

if (!file.exists(fout)) {
  saveRDS(hov_pub, fout)
}
```
