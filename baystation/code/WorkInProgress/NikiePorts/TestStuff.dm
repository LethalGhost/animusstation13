/*mob/verb/intoxication_test(var/T as text)
	set name = "Intoxication test"
	set category = "Debug"
	set hidden = 1

	world << Intoxicated(T)

	return*/

proc/istypes(value, type_1, type_2, type_3, type_4, type_5)
	if(istype(value, type_1) || istype(value, type_1) || istype(value, type_1) || istype(value, type_1) || istype(value, type_1))
		return 1
	else
		return 0
// let it be