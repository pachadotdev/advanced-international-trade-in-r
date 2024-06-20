capture log close
log using c:\Empirical_Exercise\Chapter_8\system_7985.log,replace

use c:\Empirical_Exercise\Chapter_8\truck_7990,clear
gen ve=2
rename wdth wdth_t
rename hght hght_t
rename weight wght_t
rename hp hp_t
rename four four_t
rename tran tran_t
rename ps ps_t
rename ac ac_t
drop if year>=86

save c:\Empirical_Exercise\Chapter_8\truck_temp,replace

use c:\Empirical_Exercise\Chapter_8\car_7990,clear
drop if year>=86
gen ve=1
rename wdth wdth_c
rename hght hght_c
rename wght wght_c
rename hp hp_c
rename four four_c
rename tran tran_c
rename ps ps_c
rename ac ac_c

append using c:\Empirical_Exercise\Chapter_8\truck_temp

replace wdth_c=0 if wdth_c==.
replace hght_c=0 if hght_c==.
replace wght_c=0 if wght_c==.
replace hp_c=0 if hp_c==.
replace four_c=0 if four_c==.
replace tran_c=0 if tran_c==.
replace ps_c=0 if ps_c==.
replace ac_c=0 if ac_c==.
replace wdth_t=0 if wdth_t==.
replace hght_t=0 if hght_t==.
replace wght_t=0 if wght_t==.
replace hp_t=0 if hp_t==.
replace four_t=0 if four_t==.
replace tran_t=0 if tran_t==.
replace ps_t=0 if ps_t==.
replace ac_t=0 if ac_t==.

tab year, gen(yd)

gen cyd2=yd2
gen tyd2=yd2
replace cyd2=0 if type=="JT"
replace tyd2=0 if type~="JT"

gen cyd3=yd3
gen tyd3=yd3
replace cyd3=0 if type=="JT"
replace tyd3=0 if type~="JT"

gen cyd4=yd4
gen tyd4=yd4
replace cyd4=0 if type=="JT"
replace tyd4=0 if type~="JT"

gen cyd5=yd5
gen tyd5=yd5
replace cyd5=0 if type=="JT"
replace tyd5=0 if type~="JT"

gen cyd6=yd6
gen tyd6=yd6
replace cyd6=0 if type=="JT"
replace tyd6=0 if type~="JT"

gen cyd7=yd7
gen tyd7=yd7
replace cyd7=0 if type=="JT"
replace tyd7=0 if type~="JT"

program define nlct_1
version 7.0
if "`1'"=="?"{
global S_1 "a3 a4 a5 a6 a7 b2 b3 b4 b5 b6 b7 c1 c2 c3 c4 c5 c6 c7 c8 c9 d1 d2 d3 d4 d5 d6 d7 d8"
global a3=1
global a4=1
global a5=1
global a6=1
global a7=1
global b2=.1
global b3=.1
global b4=.1
global b5=.1
global b6=.1
global b7=.1
global c1=.1
global c2=.1
global c3=.1
global c4=.1
global c5=.1
global c6=.1
global c7=.1
global c8=.1
global c9=.1
global d1=.1
global d2=.1
global d3=.1
global d4=.1
global d5=.1
global d6=.1
global d7=.1
global d8=.1
exit
}

replace `1'=$a3*cyd3+$a4*cyd4+$a5*cyd5+$a6*cyd6+$a7*cyd7/*
*/+exp($b2*cyd2+$b3*cyd3+$b4*cyd4+$b5*cyd5+$b6*cyd6+$b7*cyd7/*
*/+$c1*wght_c+$c2*wdth_c+$c3*hght_c+$c4*hp_c+$c5*tran_c+$c6*ps_c+$c7*ac_c/*
*/+$c8)+exp($b2*tyd2+($b3+.16)*tyd3+($b4+.16)*tyd4+($b5+.16)*tyd5+($b6+.16)*tyd6+$c9*tyd7/*
*/+$d1*wght_t+$d2*wdth_t+$d3*hght_t+$d4*hp_t+$d5*tran_t+$d6*ps_t+$d7*four_t+$d8)

end

nl ct_1 price

gen winv=1/exp(_b[b2]*cyd2+_b[b3]*cyd3+_b[b4]*cyd4+_b[b5]*cyd5+_b[b6]*cyd6+_b[b7]*cyd7/*
*/+_b[c1]*wght_c+_b[c2]*wdth_c+_b[c3]*hght_c+_b[c4]*hp_c+_b[c5]*tran_c+_b[c6]*ps_c/*
*/+_b[c7]*ac_c+_b[c8])

replace winv=1/exp((_b[b2]+0.16)*tyd2+(_b[b3]+.16)*tyd3+(_b[b4]+.16)*tyd4/*
*/+(_b[b5]+.16)*tyd5+(_b[b6]+.16)*tyd6+_b[c9]*tyd7/*
*/+_b[d1]*wght_t+_b[d2]*wdth_t+_b[d3]*hght_t+_b[d4]*hp_t/*
*/+_b[d5]*tran_t+_b[d6]*ps_t+_b[d7]*four_t+_b[d8]) if ve==2

gen nprice=price*winv


program define nlct_2
version 7.0
if "`1'"=="?"{
global S_1 "a3 a4 a5 a6 a7 b2 b3 b4 b5 b6 b7 c1 c2 c3 c4 c5 c6 c7 c8 c9 d1 d2 d3 d4 d5 d6 d7 d8"
global a3=1
global a4=1
global a5=1
global a6=1
global a7=1
global b2=.1
global b3=.1
global b4=.1
global b5=.1
global b6=.1
global b7=.1
global c1=.1
global c2=.1
global c3=.1
global c4=.1
global c5=.1
global c6=.1
global c7=.1
global c8=.1
global c9=.1
global d1=.1
global d2=.1
global d3=.1
global d4=.1
global d5=.1
global d6=.1
global d7=.1
global d8=.1
exit
}
replace `1'=winv*($a3*cyd3+$a4*cyd4+$a5*cyd5+$a6*cyd6+$a7*cyd7)/*
*/+winv*exp($b2*cyd2+$b3*cyd3+$b4*cyd4+$b5*cyd5+$b6*cyd6+$b7*cyd7/*
*/+$c1*wght_c+$c2*wdth_c+$c3*hght_c+$c4*hp_c+$c5*tran_c+$c6*ps_c+$c7*ac_c/*
*/+$c8)+winv*exp($b2*tyd2+($b3+.16)*tyd3+($b4+.16)*tyd4+($b5+.16)*tyd5+($b6+.16)*tyd6+$c9*tyd7/*
*/+$d1*wght_t+$d2*wdth_t+$d3*hght_t+$d4*hp_t+$d5*tran_t+$d6*ps_t+$d7*four_t+$d8)

end

nl ct_2 nprice

program drop _all
log close
exit
