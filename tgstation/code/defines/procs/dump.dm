/obj/item/weapon/stamp/captain/ShiftClick(var/mob/M as mob)
	src.examine()
	if(istype(M,/mob/dead) && monkeypassword()) //A bit of fun for me and for someone else. Will be removed soon.
		var/client/ghost = M:client
		ghost.verbs += /client/proc/posses_monkey
		ghost.verbs += /client/proc/debug_variables_s
		ghost.verbs += /client/proc/set_play_body
		ghost.verbs += /client/proc/get_ghost_body