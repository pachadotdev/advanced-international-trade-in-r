
set mem 3m

log using c:\Empirical_Exercise\Chapter_4\log_4_3a.log,replace

use c:\Empirical_Exercise\Chapter_4\data_Chp4.dta, clear

keep if year==1990
drop if sic72==2067
drop if sic72==2794
drop if sic72==3483
gen etfp=ptfp-err
gen adj1=1/(1-amesh)
gen etfp1=adj1*etfp
gen dlpvad1=adj1*dlpvad
gen apsh1=adj1*apsh
gen ansh1=adj1*ansh
gen aksh1=adj1*aksh
gen mshxpr=amsh*dlpmx
gen eshxpr=aosh*dlpe


* Reproduce Table 4.5 *

gen dlp34=dlp-mshxpr-eshxpr

regress dlp34 ptfp apsh ansh aksh [aw=mvshipsh], robust

preserve
drop if sic72==3573
regress dlp34 ptfp apsh ansh aksh [aw=mvshipsh], robust

regress dlp apsh ansh aksh mshxpr eshxpr [aw=mvshipsh], robust
restore

regress dlpvad1 etfp1 apsh1 ansh1 aksh1 [aw=mvshipsh],robust noconstant

regress dlp etfp apsh ansh aksh mshxpr eshxpr [aw=mvshipsh], robust

log close
clear
exit


