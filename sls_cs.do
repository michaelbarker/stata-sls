discard
program drop _all
set more off

program define slsdata
	drop _all
	set obs 100 

	gen x1 = rnormal()
	gen x2 = rnormal(0,0.5)
	gen x3 = rnormal(0,2)
	gen y = exp(x1 + x2 + x3) + rnormal(0,8)
end

set seed 4904934
slsdata

rcof "sls y x1 x2 x3 , tr(1)"		== 122
rcof "sls y x1 x2 x3 , tr(1 120)" 	== 125
rcof "sls y x1 x2 x3 , tr(99 1)" 	== 124
sls y x1 x2 x3 , tr(2,98)

predict double xb , xb
predict tx , tr 
predict double ey , ey

predict double score , sc 
predict double resid , r
predict double derivi , deydi
predict double db2-db3, deydb
predict double deydb*, deydb

sls y x1 x2 x3 , pilot 

sls y x1 x2 x3 , init( trace_coefs("on"), search_random("on") , conv_maxiter(50) )



* Example for Help file
clear
sysuse auto 
sls mpg weight length displacement 
predict mpghat, ey
predict Index , xb
twoway (scatter mpg Index) (line mpghat I , sort) , xtitle("Index") ytitle("MPG") legend(label(1 "Actual") label(2 "Predicted")) 

* Example2 for Help file
clear
sysuse auto 
sls mpg weight length displacement, init( trace_coefs("on"), eq_coefs(1, (20,5)) , search("off") , conv_maxiter(50) )




