
clear
capture log close
log using c:\Empirical_Exercise\Chapter_8\truck_reg.log,replace

use c:\Empirical_Exercise\Chapter_8\truck_7990,clear

drop if year>=86
gen lnprice=log(price)

tab year, gen(yd)

program define nltruck_1
version 7.0
	if "`1'"=="?"{
		global S_1"a2 a3 a4 a5 a6 a7 b1 b2 b3 b4 b5 b6 b7 c1"
		global a2=1
		global a3=1
		global a4=1
		global a5=1
		global a6=1
		global a7=1
		global b1=1
		global b2=1
		global b3=1
		global b4=1
		global b5=1
		global b6=1
		global b7=1
		global c1=1
		exit
	}
	replace `1'=exp($a2*yd2+$a3*yd3+$a4*yd4+$a5*yd5+$a6*yd6+$a7*yd7/*
*/+$b1*weight+$b2*wdth+$b3*hght+$b4*hp+$b5*tran+$b6*ps+$b7*four+$c1*1)
end

nl truck_1 price

gen winv=1/exp(_b[a2]*yd2+_b[a3]*yd3+_b[a4]*yd4+_b[a5]*yd5+_b[a6]*yd6+_b[a7]*yd7/*
*/+_b[b1]*weight+_b[b2]*wdth+_b[b3]*hght+_b[b4]*hp+_b[b5]*tran+_b[b6]*ps+_b[b7]*four+_b[c1]*1)

gen nprice=price*winv

program define nltruck_2
	version 7.0
	if "`1'"=="?"{
		global S_1"a2 a3 a4 a5 a6 a7 b1 b2 b3 b4 b5 b6 b7 c1"
		global a2=1
		global a3=1
		global a4=1
		global a5=1
		global a6=1
		global a7=1
		global b1=1
		global b2=1
		global b3=1
		global b4=1
		global b5=1
		global b6=1
		global b7=1
		global c1=1
		exit
	}
	replace `1'=winv*exp($a2*yd2+$a3*yd3+$a4*yd4+$a5*yd5+$a6*yd6+$a7*yd7/*
*/+$b1*weight+$b2*wdth+$b3*hght+$b4*hp+$b5*tran+$b6*ps+$b7*four+$c1*1)
end

nl truck_2 nprice

clear

program drop _all
log close
exit
