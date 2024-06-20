clear
capture log close
log using c:\Empirical_Exercise\Chapter_8\pindex_t.log,replace

use c:\Empirical_Exercise\Chapter_8\truck_7990,clear
keep year model type price quan

preserve
keep if year==80
keep model type price quan
ren price price_80
ren quan quan_80
sort model
save c:\Empirical_Exercise\Chapter_8\truck_80,replace
restore

sort model
merge model using c:\Empirical_Exercise\Chapter_8\truck_80
keep if _merge==3
drop _merge

sort year model
egen value_80=sum(price_80*quan_80), by(year)
egen value_cp=sum(price*quan_80),by(year)
gen lasp=value_cp/value_80

egen value_c=sum(price*quan), by(year)
egen value_cq=sum(price_80*quan), by(year)
gen pasp=value_c/value_cq
 
gen pindex=(lasp*pasp)^0.5

collapse (mean) pindex, by(year)
list


log close
