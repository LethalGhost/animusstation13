/client/proc/posses_monkey(mob/living/carbon/monkey/M as mob in world)
	set category = "Special Verbs"
	set name = "Posses Monkey"

	if(M.ckey && M.client)
		usr <<"There is soul already!"
		if(alert("Are you sure you want it",,"Posses","Cancel")=="Cancel")
			return

	M.key = usr.key
	if(M.mind)
		M.mind.key = usr.key
	M.ckey = usr.ckey

	spawn() del(usr)