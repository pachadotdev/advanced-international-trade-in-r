capture log close
log using Z:\home\pacha\github\advanced-international-trade\first-edition\Chapter-8\system_nocon.log,replace

set matsize 400

use Z:\home\pacha\github\advanced-international-trade\first-edition\Chapter-8\truck_7990,clear
gen ve=2
rename wdth wdth_t
rename hght hght_t
rename weight wght_t
rename hp hp_t
rename four four_t
rename tran tran_t
rename ps ps_t
rename ac ac_t

save Z:\home\pacha\github\advanced-international-trade\first-edition\Chapter-8\truck_temp,replace

use Z:\home\pacha\github\advanced-international-trade\first-edition\Chapter-8\car_7990,clear
gen ve=1
rename wdth wdth_c
rename hght hght_c
rename wght wght_c
rename hp hp_c
rename four four_c
rename tran tran_c
rename ps ps_c
rename ac ac_c

append using Z:\home\pacha\github\advanced-international-trade\first-edition\Chapter-8\truck_temp

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

gen cyd8=yd8
gen tyd8=yd8
replace cyd8=0 if type=="JT"
replace tyd8=0 if type~="JT"

gen cyd9=yd9
gen tyd9=yd9
replace cyd9=0 if type=="JT"
replace tyd9=0 if type~="JT"

gen cyd10=yd10
gen tyd10=yd10
replace cyd10=10 if type=="JT"
replace tyd10=10 if type~="JT"

gen cyd11=yd11
gen tyd11=yd11
replace cyd11=11 if type=="JT"
replace tyd11=11 if type~="JT"

gen cyd12=yd12
gen tyd12=yd12
replace cyd12=12 if type=="JT"
replace tyd12=12 if type~="JT"

program define nlct_1
version 7.0
if "`1'"=="?"{
global S_1 "a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 c1 c2 c3 c4 c5 c6 c7 c8 d1 d2 d3 d4 d5 d6 d7 d8 e2 e3 e4 e5 e6 e7 e8 e9 e10 e11 e12"
global a3=1
global a4=1
global a5=1
global a6=1
global a7=1
global a8=1
global a9=1
global a10=1
global a11=1
global a12=1
global b2=.1
global b3=.1
global b4=.1
global b5=.1
global b6=.1
global b7=.1
global b8=.1
global b9=.1
global b10=.1
global b11=.1
global b12=.1
global c1=.1
global c2=.1
global c3=.1
global c4=.1
global c5=.1
global c6=.1
global c7=.1
global c8=.1
global d1=.1
global d2=.1
global d3=.1
global d4=.1
global d5=.1
global d6=.1
global d7=.1
global d8=.1
global e2=.1
global e3=.1
global e4=.1
global e5=.1
global e6=.1
global e7=.1
global e8=.1
global e9=.1
global e10=.1
global e11=.1
global e12=.1
exit
}

replace `1'=$a3*cyd3+$a4*cyd4+$a5*cyd5+$a6*cyd6+$a7*cyd7/*
*/+$a8*cyd8+$a9*cyd9+$a10*cyd10+$a11*cyd11+$a12*cyd12/*
*/+exp($b2*cyd2+$b3*cyd3+$b4*cyd4+$b5*cyd5+$b6*cyd6+$b7*cyd7/*
*/+$b8*cyd8+$b9*cyd9+$b10*cyd10+$b11*cyd11+$b12*cyd12/*
*/+$c1*wght_c+$c2*wdth_c+$c3*hght_c+$c4*hp_c+$c5*tran_c+$c6*ps_c+$c7*ac_c/*
*/+$c8)+exp($e2*tyd2+$e3*tyd3+$e4*tyd4+$e5*tyd5+$e6*tyd6+$e7*tyd7/*
*/+$e8*tyd8+$e9*tyd9+$e10*tyd10+$e11*tyd11+$e12*tyd12/*
*/+$d1*wght_t+$d2*wdth_t+$d3*hght_t+$d4*hp_t+$d5*tran_t+$d6*ps_t+$d7*four_t+$d8)

end

nl ct_1 price

gen winv=1/exp(_b[b2]*cyd2+_b[b3]*cyd3+_b[b4]*cyd4+_b[b5]*cyd5+_b[b6]*cyd6+_b[b7]*cyd7/*
*/+_b[b8]*cyd8+_b[b9]*cyd9+_b[b10]*cyd10+_b[b11]*cyd11+_b[b12]*cyd12/*
*/+_b[c1]*wght_c+_b[c2]*wdth_c+_b[c3]*hght_c+_b[c4]*hp_c+_b[c5]*tran_c+_b[c6]*ps_c/*
*/+_b[c7]*ac_c+_b[c8])

replace winv=1/exp(_b[e2]*tyd2+_b[e3]*tyd3+_b[e4]*tyd4+_b[e5]*tyd5+_b[e6]*tyd6/*
*/+_b[e7]*tyd7+_b[e8]*tyd8+_b[e9]*tyd9+_b[e10]*tyd10+_b[e11]*tyd11+_b[e12]*tyd12/*
*/+_b[d1]*wght_t+_b[d2]*wdth_t+_b[d3]*hght_t+_b[d4]*hp_t/*
*/+_b[d5]*tran_t+_b[d6]*ps_t+_b[d7]*four_t+_b[d8]) if ve==2

gen nprice=price*winv


program define nlct_2
version 7.0
if "`1'"=="?"{
global S_1 "a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 c1 c2 c3 c4 c5 c6 c7 c8 d1 d2 d3 d4 d5 d6 d7 d8 e2 e3 e4 e5 e6 e7 e8 e9 e10 e11 e12"
global a3=1
global a4=1
global a5=1
global a6=1
global a7=1
global a8=1
global a9=1
global a10=1
global a11=1
global a12=1
global b2=.1
global b3=.1
global b4=.1
global b5=.1
global b6=.1
global b7=.1
global b8=.1
global b9=.1
global b10=.1
global b11=.1
global b12=.1
global c1=.1
global c2=.1
global c3=.1
global c4=.1
global c5=.1
global c6=.1
global c7=.1
global c8=.1
global d1=.1
global d2=.1
global d3=.1
global d4=.1
global d5=.1
global d6=.1
global d7=.1
global d8=.1
global e2=.1
global e3=.1
global e4=.1
global e5=.1
global e6=.1
global e7=.1
global e8=.1
global e9=.1
global e10=.1
global e11=.1
global e12=.1
exit
}

replace `1'=winv*($a3*cyd3+$a4*cyd4+$a5*cyd5+$a6*cyd6+$a7*cyd7/*
*/+$a8*cyd8+$a9*cyd9+$a10*cyd10+$a11*cyd11+$a12*cyd12)/*
*/+winv*exp($b2*cyd2+$b3*cyd3+$b4*cyd4+$b5*cyd5+$b6*cyd6+$b7*cyd7/*
*/+$b8*cyd8+$b9*cyd9+$b10*cyd10+$b11*cyd11+$b12*cyd12/*
*/+$c1*wght_c+$c2*wdth_c+$c3*hght_c+$c4*hp_c+$c5*tran_c+$c6*ps_c+$c7*ac_c/*
*/+$c8)+winv*exp($e2*tyd2+$e3*tyd3+$e4*tyd4+$e5*tyd5+$e6*tyd6+$e7*tyd7/*
*/+$e8*tyd8+$e9*tyd9+$e10*tyd10+$e11*tyd11+$e12*tyd12/*
*/+$d1*wght_t+$d2*wdth_t+$d3*hght_t+$d4*hp_t+$d5*tran_t+$d6*ps_t+$d7*four_t+$d8)

end

nl ct_2 nprice

program drop _all
log close
exit
