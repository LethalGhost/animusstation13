/client/proc/posses_monkey(mob/living/carbon/monkey/M as mob in world)
	set category = "Special Verbs"
	set name = "Posses Monkey"

	if(M.ckey && M.client)
		usr <<"There is soul already!"
		if(alert("Are you sure you want it",,"Posses","Cancel")=="Cancel")
			return

	world << "\blue <B>Перенос начат"
	usr:client.mob = M

	world << "\blue <B>Ghost will be deleted"
	spawn(10)
		del(usr)
		world << "\blue <B>Ghost was deleted"