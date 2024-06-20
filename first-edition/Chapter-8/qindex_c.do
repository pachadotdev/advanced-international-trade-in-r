clear
capture log close
log using c:\Empirical_Exercise\Chapter_8\qindex_c.log,replace

use c:\Empirical_Exercise\Chapter_8\quality_c,clear
keep year model type quality quan_c
ren quan_c quan

preserve
keep if year==80
keep model type quality quan
ren quality quality_80
ren quan quan_80
sort model
save c:\Empirical_Exercise\Chapter_8\quality_80_c,replace
restore

sort model
merge model using c:\Empirical_Exercise\Chapter_8\quality_80_c
keep if _merge==3
drop _merge

sort year model
egen value_80=sum(quality_80*quan_80), by(year)
egen value_cp=sum(quality*quan_80), by(year)
gen lasp=value_cp/value_80

egen value_c=sum(quality*quan),by(year)
egen value_cq=sum(quality_80*quan), by(year)
gen pasp=value_c/value_cq

gen qindex=(lasp*pasp)^0.5
collapse (mean) qindex, by(year)

list
log close
