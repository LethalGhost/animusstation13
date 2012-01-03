/client/proc/posses_monkey(mob/living/carbon/monkey/M as mob in world)
	set category = "Special Verbs"
	set name = "Posses Monkey"

	if(M.ckey && M.client)
		usr <<"There is soul already!"
		if(alert("Are you sure you want it",,"Posses","Cancel")=="Cancel")
			return

	usr:client.mob = M

	spawn(10)
		del(usr)

/client/proc/set_play_body()
	set category = "Special Verbs"
	set name = "Return to body"
	if(istype(mob, /mob/dead/observer))
		mob:reenter_corpse()

/client/proc/get_ghost_body()
	set category = "Special Verbs"
	set name = "Become Ghost"
	if(!istype(mob, /mob/dead/observer))
		mob.adminghostize(1)
