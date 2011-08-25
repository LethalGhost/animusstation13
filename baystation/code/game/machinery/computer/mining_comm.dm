/obj/machinery/computer/mining
	name = "Archaeologist Communications Console"
	desc = "Have no fear, Communications are here!"
	icon_state = "mining"
	req_access = list(access_mining_station)
	var/state = STATE_DEFAULT
	var/authenticated = 0
	brightnessred = 2
	brightnessgreen = 0
	brightnessblue = 0
	var/const
		STATE_DEFAULT = 1

/obj/machinery/computer/mining/process()
	..()
	src.updateDialog()

/obj/machinery/computer/mining/attack_ai(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/mining/attack_paw(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/mining/attack_hand(var/mob/user as mob)
	if(..())
		return

	user.machine = src
	var/dat = "<head><title>Archaeologist Communications Console</title></head><body>"

	switch(src.state)
		if(STATE_DEFAULT)
			if (src.authenticated)
				dat += "<BR>\[ <A HREF='?src=\ref[src];operation=logout'>Log Out</A> \]"

				if(MiningControl.departed)
					dat += "<BR>Archaeologist Shuttle is in flight..."
				else if(MiningControl.location == 1)
					dat += "<BR>\[ <A HREF='?src=\ref[src];operation=call-mining'>Send Archaeologist Shuttle</A> \]"
				else
					dat += "<BR>\[ <A HREF='?src=\ref[src];operation=recall-mining'>Recall Archaeologist Shuttle</A> \]"

			else
				dat += "<BR>\[ <A HREF='?src=\ref[src];operation=login'>Log In</A> \]"
			dat += "<BR>\[ <A HREF='?src=\ref[src];operation=messagelist'>Message List</A> \]"

	dat += "<BR>\[ [(src.state != STATE_DEFAULT) ? "<A HREF='?src=\ref[src];operation=main'>Main Menu</A> | " : ""]<A HREF='?src=\ref[user];mach_close=communications'>Close</A> \]"
	user << browse(dat, "window=communications;size=400x500")
	onclose(user, "communications")

/obj/machinery/computer/mining/Topic(href, href_list)
	if(..())
		return
	usr.machine = src

	if(!href_list["operation"])
		return
	switch(href_list["operation"])
		// main interface
		if("main")
			src.state = STATE_DEFAULT
		if("login")
			var/mob/M = usr
			var/obj/item/weapon/card/id/I = M.equipped()
			if (istype(I, /obj/item/device/pda))
				var/obj/item/device/pda/pda = I
				I = pda.id
			if (I && istype(I))
				if(src.check_access(I))
					authenticated = 1
		if("logout")
			authenticated = 0
		if("call-mining")
			MiningControl.start()
			radioalert("Archaeologist Notice", "Archaeologist Shuttle launching in thirty seconds.")
		if("recall-mining")
			MiningControl.recall()
			radioalert("Archaeologist Notice", "Archaeologist Shuttle returning in thirty seconds.")
	src.updateUsrDialog()