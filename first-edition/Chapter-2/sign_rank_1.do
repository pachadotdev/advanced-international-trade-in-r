* This program is to conduct sign test, Rank test and Missing trade test *

capture log close
log using c:\Empirical_Exercise\Chapter_2\sign_rank_1.log, replace

set mem 30m

use C:\Empirical_Exercise\Chapter_2\trefler, clear

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

* Calculate epsilon(fc) and sigma^2(f) according to eq.2 in Trefler (1995)*
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

* Correlation, should be .28 *

corr trAT AThat2

*************
* Sign Test *
*************

sort indexc
by indexc: count if trAT*AThat2>0

count if trAT*AThat2>0
display _result(1)/_N

*****************
* Missing Trade *
*****************

* Checking for the missing trade, should be .032 *

quietly summarize trAT
local varAT=_result(4)
quietly summarize AThat
local varHat=_result(4)
quietly summarize AThat2
local varHat2=_result(4)
display `varAT'/`varHat'
display `varAT'/`varHat2'

**************
* Rank Tests *
**************

keep country indexc indexf trAT AThat2

sort indexc indexf
reshape wide trAT AThat2, i(indexc) j(indexf)

local i=1
while `i'<9{
	local j=`i'+1
	while `j'<=9{
		gen rank`i'`j'=((trAT`i'-trAT`j')*(AThat2`i'-AThat2`j')>0)
		local j=`j'+1
	}
	local i=`i'+1
}

keep country indexc rank*
reshape long rank, i(indexc) j(factor)
egen r1=sum(rank), by(indexc)
gen r2=r1/36
collapse r2,by(indexc country)
sum r2
list

log close
exit


