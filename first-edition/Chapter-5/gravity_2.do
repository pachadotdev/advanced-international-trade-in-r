capture log close
log using c:\Empirical_Exercise\Chapter_5\gravity_2.log, replace

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

tab c_e, gen (ced)
tab c_i, gen (cid)

gen d_border=1
replace d_border=0 if (l_ex==1) & (l_im==1)
replace d_border=0 if (l_ex==2) & (l_im==2)

gen lnvx=log(vx)
gen lndist=log(dist)
gen lngdp_ce=log(gdp_ce)
gen lngdp_ci=log(gdp_ci)
gen lnn_vx=lnvx-lngdp_ce-lngdp_ci

regress lnn_vx lndist d_border ced* cid*

clear
log close
