
clear
capture log close
log using c:\Empirical_Exercise\Chapter_8\unit_value.log,replace

use c:\Empirical_Exercise\Chapter_8\car_7990,clear

gen value=price*quan
egen aquan=mean(quan), by(year)
egen avalue=mean(value), by(year)
gen uvalue=avalue/aquan
collapse (mean) uvalue, by(year)
list
clear

use c:\Empirical_Exercise\Chapter_8\truck_7990,clear
gen value=price*quan
egen aquan=mean(quan), by(year)
egen avalue=mean(value), by(year)
gen uvalue=avalue/aquan
collapse (mean) uvalue, by(year)
list
clear

log close
exit
