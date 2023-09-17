* This program is to compute pai, the factor productivity *

capture log close
log using c:\Empirical_Exercise\Chapter_2\pi.log,replace

set mem 30m

use c:\Empirical_Exercise\Chapter_2\trefler, clear

* number of country in the dataset *
egen C=max(indexc)
egen F=max(indexf)

* Calculate the world level of Yw, Bw and Vw *
egen Yww=sum(Y)
gen Yw=Yww/F
egen Bww=sum(B)
gen Bw=Bww/F
egen Vfw=sum(V), by(indexf)

* Calculate country share Sc *
gen Sc=(Y-B)/(Yw-Bw)

* Calculate epsilon(fc) and sigma^2(f) according to eq.2 in Trefler (1995)
gen Efc=AT-(V-Sc*Vfw)

* Construct the average epsilon for a given factor *
egen total=sum(Efc),by(indexf)
gen ave=total/C

* Construct sigma^2 and the weight *

egen tot=sum((Efc-ave)^2), by(indexf)
gen sigma2f=tot/(C-1)

codebook sigma2f
gen sigmaf=sqrt(sigma2f)
gen weight=sigmaf*sqrt(Sc)

* Using the weight, convert all the data *

gen trAT=AT/(sigmaf*sqrt(Sc))
gen trV=V/(sigmaf*sqrt(Sc))
gen trY=Y/sqrt(Sc)
gen trB=B/sqrt(Sc)
gen trVfw=Vfw/sigmaf

gen AThat=trV-Sc*trVfw
gen AThat2=(V-Sc*Vfw)/weight

* Construct Aggregate Labor Endowment *

preserve
keep if indexf==7 |indexf==8 | indexf==9
gen en=2
replace en=3 if indexf==8
replace en=4 if indexf==9
keep country factor AT V en indexc Sc

save c:\Empirical_Exercise\Chapter_2\indexf_189,replace

restore

preserve
drop if indexf==7 |indexf==8 | indexf==9

egen v_l=sum(V), by(country)
egen AT_l=sum(AT), by(country)

drop V AT factor
rename v_l V
rename AT_l AT
gen en=1
collapse (mean)AT V en indexc Sc, by(country)
gen str5 factor="Labor"
save c:\Empirical_Exercise\Chapter_2\indexf_L,replace

restore

use c:\Empirical_Exercise\Chapter_2\indexf_189,clear
append using c:\Empirical_Exercise\Chapter_2\indexf_L
sort indexc en
save c:\Empirical_Exercise\Chapter_2\pi,replace

************************************
* Compute Pi: factor productivity *
************************************

use c:\Empirical_Exercise\Chapter_2\pi, clear

gen p_0=1
gen p_1=1

local i=1
while `i'<=4{
	preserve
	keep if en==`i'
	local j=1
	while `j'<51{
		replace p_0=p_1
		gen Vp=p_0*V
		egen Vpw=sum(Vp)
		replace p_1=(AT+Sc*Vpw)/V
		replace p_1=1 if country=="USA"
		drop Vp Vpw
		local j=`j'+1
	}
	keep en country indexc p_1
	save c:\Empirical_Exercise\Chapter_2\pi_`i',replace
	restore
	local i=`i'+1
}

local i=1
while `i'<=4{
	use c:\Empirical_Exercise\Chapter_2\pi_`i',clear
	sort en indexc
	by en: list en indexc country p_1
	local i=`i'+1
}

log close

exit


