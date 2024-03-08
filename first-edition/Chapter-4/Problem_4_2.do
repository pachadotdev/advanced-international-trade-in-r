set mem 300m

log using c:\Empirical_Exercise\Chapter_4\log_4_2.log,replace

use c:\Empirical_Exercise\Chapter_4\data_Chp4,clear
drop if year==1972|year==1987
drop if sic72==2067|sic72==2794|sic72==3483

egen wagebill=sum(pay), by(year)
gen share=pay/wagebill

sort sic72 year
by sic72: gen lagshare=share[_n-1]
gen ashare=(share+lagshare)/2

by sic72: gen lagnwsh=nwsh[_n-1]
gen chanwsh=(nwsh-lagnwsh)*100/11

gen wchanwsh=chanwsh*ashare
gen wdlky=dlky*ashare
gen wdly=dly*ashare
gen wdsimat1a=dsimat1a*ashare
gen wdsimat1b=dsimat1a*ashare
gen diffout=dsimat1a-dsimat1b
gen wdiffout=(dsimat1a-dsimat1b)*ashare
gen wcosh_exp=dofsh*ashare
gen htsh_exp=dhtsh-dofsh
gen whtsh_exp=(dhtsh-dofsh)*ashare
gen wcosh_exa=dofsh1*ashare
gen htsh_exa=dhtsh1-dofsh1
gen whtsh_exa=(dhtsh1-dofsh1)*ashare
gen wcosh=ci*ashare
gen whtsh=dhtsh*ashare

* Check with the first column of Table 4.4 *

tabstat wchanwsh wdlky wdly wdsimat1a wcosh_exp whtsh_exp wcosh_exa whtsh_exa wcosh whtsh, stats(sum)

* Reproduce the rest of the columns in Table 4.4 *

regress chanwsh dlky dly dsimat1a dofsh htsh_exp [aw=ashare], cluster (sic2)

regress chanwsh dlky dly dsimat1a dofsh1 htsh_exa [aw=ashare], cluster (sic2)

regress chanwsh dlky dly dsimat1a ci dhtsh [aw=ashare], cluster (sic2)

* To instead distinguish narrow and other outsourcing, we can reproduce column (1) of table III in Feenstra and Hanson, 1999 *

tabstat wchanwsh wdlky wdly wdsimat1b wdiffout wcosh_exp whtsh_exp wcosh_exa whtsh_exa wcosh whtsh, stats(sum)

* Reproduce the rest of the columns in Table III *

regress chanwsh dlky dly dsimat1b diffout dofsh htsh_exp [aw=ashare], cluster (sic2)

regress chanwsh dlky dly dsimat1b diffout dofsh1 htsh_exa [aw=ashare], cluster (sic2)

regress chanwsh dlky dly dsimat1b diffout ci dhtsh [aw=ashare], cluster (sic2)

log close

clear
exit

