capture log close
log using c:\Empirical_Exercise\Chapter_5\gravity_1.log, replace


set matsize 100

use c:\Empirical_Exercise\Chapter_5\trade_93,clear
sort c_e
merge c_e using c:\Empirical_Exercise\Chapter_5\gdp_ce_93
drop _merge
sort c_i
merge c_i using c:\Empirical_Exercise\Chapter_5\gdp_ci_93
drop _merge
drop if vx==0
drop if dist==0

gen lnvx=log(vx)
gen lndist=log(dist)
gen lngdp_ce=log(gdp_ce)
gen lngdp_ci=log(gdp_ci)

* Estimate Gravity Equation from the Canadian Perspective *

preserve
gen d_ca=0
replace d_ca=1 if (l_ex==2) & (l_im==2)
drop if (l_ex==1) & (l_im==1)

regress lnvx lngdp_ce lngdp_ci lndist d_ca
restore

* Estimate Gravity Equation from the U.S. Perspective *

preserve
gen d_us=0
replace d_us=1 if (l_ex==1) & (l_im==1)
drop if (l_ex==2) & (l_im==2)

regress lnvx lngdp_ce lngdp_ci lndist d_us
restore

* Estimate Gravity Equation by Pooling All Data *

preserve
gen d_ca=0
gen d_us=0
replace d_ca=1 if (l_ex==2) & (l_im==2)
replace d_us=1 if (l_ex==1) & (l_im==1)

regress lnvx lngdp_ce lngdp_ci lndist d_ca d_us
vce
restore

clear

log close



