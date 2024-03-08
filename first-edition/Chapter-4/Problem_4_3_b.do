set mem 3m
capture log close
log using c:\Empirical_Exercise\Chapter_4\log_4_3b.log,replace

use c:\Empirical_Exercise\Chapter_4\data_Chp4, clear

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
gen t4dlpvad=(dlpvad+etfp)*adj1
preserve

* Reproduce the first column of Table IV  *
* generating difference measure of outsourcing *

gen dsimatd1=dsimat1a-dsimat1b

* generating difference measure of high tech share *

gen dhtdsh=dhtsh-dofsh

* check whether we are using the right variable as described in table II *

sum dsimatd1 dhtdsh dofsh [aw=mvshipsh]

regress t4dlpvad dsimat1b dsimatd1 dofsh dhtdsh [aw=mvshipsh], cluster(sic2)

* Reproduce Table V using the coefficients in column(1) of Table IV *

gen wt=mvshipsh^.5
gen apsh5=apsh1*wt
gen ansh5=ansh1*wt
gen aksh5=aksh1*wt
gen narrout=dsimat1b*wt*_coef[dsimat1b]
gen diffout=dsimatd1*wt*_coef[dsimatd1]
gen comsh=dofsh*wt*_coef[dofsh]
gen difcom=dhtdsh*wt*_coef[dhtdsh]

sum narrout diffout comsh difcom

regress narrout apsh5 ansh5 aksh5, noconstant
regress diffout apsh5 ansh5 aksh5, noconstant
regress comsh apsh5 ansh5 aksh5, noconstant
regress difcom apsh5 ansh5 aksh5, noconstant

restore

* Reproduce column (2) of Table IV *

preserve

* generating difference measure of outsourcing *

gen dsimatd1=dsimat1a-dsimat1b

* generate difference measure of high tech share with ex ante rental price *

gen dhtdsh1=dhtsh1-dofsh1

* check whether we are using the right variable as described in table II *

sum dsimatd1 dhtdsh1 dofsh1 [aw=mvshipsh]

regress t4dlpvad dsimat1b dsimatd1 dofsh1 dhtdsh1 [aw=mvshipsh], cluster(sic2)

* Reproduce column (3) of Table IV *

* generating difference measure of high tech share *

gen dhtdsh=dhtsh-dofsh

regress t4dlpvad dsimat1b dsimatd1 ci dhtsh [aw=mvshipsh], cluster(sic2)

log close
clear

exit

