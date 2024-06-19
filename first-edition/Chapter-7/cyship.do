clear
capture log close

log using c:\Empirical_Exercise\Chapter_7\cyship.log,replace

insheet using c:\Empirical_Exercise\Chapter_7\cyship.csv
drop if time<=16
regress iprice dummy1 dummy2 dummy3 time timesq lag0 lag1 lag2 /*
     */ tariff usprice gprice income

*i=0
lincom lag0

*i=1
lincom lag0+lag1+lag2

*i=2
lincom lag0+2*lag1+4*lag2

*i=3
lincom lag0+3*lag1+9*lag2

*i=4
lincom lag0+4*lag1+16*lag2

*summation of betai's
lincom 5*lag0+10*lag1+30*lag2

*Impose the homogeneity and symmetry constraints
regress y dummy1 dummy2 dummy3 time timesq z0 z1 z2 x1 x2

*summation of betai's
lincom 5*z0+10*z1+30*z2

log close
exit
