clear
capture log close
log using c:\Empirical_Exercise\Chapter_9\share_reg.log,replace

use c:\Empirical_Exercise\Chapter_9\china_fdi,clear

set matsize 100

reg fiech3 state3 premsta3 tar_cm3 newprem fdi2_cm3 appcons3 pd1-pd30 yd1-yd18  if fiech3>0, r 



reg fiech3 state3 premsta3 tar_cm3 newprem fdi2_cm3 appcons3 pd1-pd30 yd1-yd18 /*
     */ (elecpro elecgdp elecpop elecurb elecrur elecwag elecwags elecwagu cmpr3 /*
     */	cmprgdp  cmprpop cmprelec indewag indewags indewagu gdp pop urbaninc rurinc /*
     */  pd1-pd30 yd1-yd18)  if fiech3>0, r 


reg fiech3 state3 premsta3 tar_cm3 newprem fdi2_cm3 appcons3 pd1-pd30 yd1-yd18 /*
     */ (elecpro elecgdp elecpop elecurb elecrur elecwag elecwags elecwagu cmpr3 /*
     */	cmprgdp  cmprpop cmprelec indewag indewags indewagu gdp pop urbaninc rurinc /*
     */  pd1-pd30 yd1-yd18) [w=gdp]  if fiech3>0, r 


matrix cv=get(VCE)

matrix cv1 = cv[1..3,1..3]

matrix list cv1

reg fiech3 state3 premsta3 tar_cm3 newprem fdi2_cm3 appcons3 pd1-pd30 yd1-yd18 /*
     */ (elecpro elecgdp elecpop elecurb elecrur elecwag elecwags elecwagu cmpr3 /*
     */	cmprgdp  cmprpop cmprelec indewag indewags indewagu gdp pop urbaninc rurinc /*
     */  pd1-pd30 yd1-yd18) [w=gdp]  if fiech3>0 & year>=1988, r 


matrix cv=get(VCE)

matrix cv1 = cv[1..3,1..3]

matrix list cv1

reg fiech3 state3 premsta3 tar_cm3 newprem fdi2_cm3 appcons3 pd1-pd30 yd1-yd18 /*
     */ (elecpro elecgdp elecpop elecurb elecrur elecwag elecwags elecwagu cmpr3 /*
     */	cmprgdp  cmprpop cmprelec indewag indewags indewagu gdp pop urbaninc rurinc /*
     */  pd1-pd30 yd1-yd18) [w=gdp]  if fiech3>0 & year>=1990, r 


matrix cv=get(VCE)

matrix cv1 = cv[1..3,1..3]

matrix list cv1

log close

