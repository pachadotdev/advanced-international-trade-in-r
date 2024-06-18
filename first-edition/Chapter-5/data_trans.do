* Input data set into STATA and save as STATA file *

insheet using c:\Empirical_Exercise\Chapter_5\dist.csv
sort c_e c_i
save c:\Empirical_Exercise\Chapter_5\dist,replace

clear
insheet using c:\Empirical_Exercise\Chapter_5\trade_93.csv
sort c_e c_i

merge c_e c_i using c:\Empirical_Exercise\Chapter_5\dist
drop _merge

sort c_e c_i

save c:\Empirical_Exercise\Chapter_5\trade_93,replace

clear

insheet using c:\Empirical_Exercise\Chapter_5\gdp_ce_93.csv
gen gce=gdp_ce*0.775134
drop gdp_ce
ren gce gdp_ce
sort c_e
save c:\Empirical_Exercise\Chapter_5\gdp_ce_93,replace

clear

insheet using c:\Empirical_Exercise\Chapter_5\gdp_ci_93.csv
gen gci=gdp_ci*0.775134
drop gdp_ci
ren gci gdp_ci
sort c_i
save c:\Empirical_Exercise\Chapter_5\gdp_ci_93,replace

clear
