
clear
capture log close
log using c:\Empirical_Exercise\Chapter_8\car_reg.log,replace

use c:\Empirical_Exercise\Chapter_8\car_7990,clear
drop if year>=86

tab year, gen(yd)

program define nlcar
version 7.0
if "`1'"=="?"{
global S_1 "a3 a4 a5 a6 a7 b2 b3 b4 b5 b6 b7 c1 c2 c3 c4 c5 c6 c7 c8"
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
exit
}
replace `1'=$a3*yd3+$a4*yd4+$a5*yd5+$a6*yd6+$a7*yd7/*
*/+exp($b2*yd2+$b3*yd3+$b4*yd4+$b5*yd5+$b6*yd6+$b7*yd7/*
*/+$c1*wght+$c2*wdth+$c3*hght+$c4*hp+$c5*tran+$c6*ps+$c7*ac+$c8)

end

nl car price


gen winv=1/exp(_b[b2]*yd2+_b[b3]*yd3+_b[b4]*yd4+_b[b5]*yd5+_b[b6]*yd6+_b[b7]*yd7/*
*/+_b[c1]*wght+_b[c2]*wdth+_b[c3]*hght+_b[c4]*hp+_b[c5]*tran+_b[c6]*ps+_b[c7]*ac+_b[c8])

gen nprice=price*winv
gen nyd3=yd3*winv
gen nyd4=yd4*winv
gen nyd5=yd5*winv
gen nyd6=yd6*winv
gen nyd7=yd7*winv

program define nlncar
	version 7.0
	if "`1'"=="?"{
		global S_1 "a3 a4 a5 a6 a7 b2 b3 b4 b5 b6 b7 c1 c2 c3 c4 c5 c6 c7 c8"
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
		exit
	}
	replace `1'=$a3*nyd3+$a4*nyd4+$a5*nyd5+$a6*nyd6+$a7*nyd7/*
*/+winv*exp($b2*yd2+$b3*yd3+$b4*yd4+$b5*yd5+$b6*yd6+$b7*yd7/*
*/+$c1*wght+$c2*wdth+$c3*hght+$c4*hp+$c5*tran+$c6*ps+$c7*ac+$c8)

end

nl ncar nprice
clear
program drop _all
log close
exit

