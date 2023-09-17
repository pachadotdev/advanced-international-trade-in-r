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

