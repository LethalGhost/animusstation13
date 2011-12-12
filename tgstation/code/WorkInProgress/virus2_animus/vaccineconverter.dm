/obj/machinery/disease2/vaccinefabricator/
	name = "Vaccine Converter"
	density = 1
	anchored = 1
	icon = 'chemical.dmi'
	icon_state = "mixer0b"
	var/obj/item/weapon/vaccinedisk/Dd = null
	var/converting = 0
	var/beaker = null

	proc/have_vaccine()
		var/datum/reagents/R = beaker:reagents
		if(R.total_volume == 0)
			return 0
		for(var/datum/reagent/vaccine2/V in R.reagent_list)
			if(V)
				var/Vol = V.volume
				return Vol
		return 0

	ex_act(severity)
		switch(severity)
			if(1.0)
				del(src)
				return
			if(2.0)
				if (prob(50))
					del(src)
					return

	blob_act()
		if (prob(25))
			del(src)

	meteorhit()
		del(src)
		return

	attackby(var/obj/item/weapon/reagent_containers/glass/B as obj, var/mob/user as mob)
		if(istype(B, /obj/item/weapon/reagent_containers/glass))
			if(src.beaker)
				user << "A container is already loaded into the machine."
				return

			src.beaker =  B
			user.drop_item()
			B.loc = src
			user << "You add the beaker to the machine!"
			src.updateUsrDialog()
			icon_state = "mixer1b"
		else if(istype(B, /obj/item/weapon/vaccinedisk))
			if(src.Dd)
				user << "A disk is already loaded into the machine."
				return

			src.Dd =  B
			user.drop_item()
			B.loc = src
			user << "You insert disk into the machine!"
			src.updateUsrDialog()
		else if(istype(B, /obj/item/weapon/diseasedisk))
			user << "You are trying to insert the wrong disk."
			return

	Topic(href, href_list)
		if(stat & BROKEN) return
		if(usr.stat || usr.restrained()) return
		if(!in_range(src, usr)) return

		usr.machine = src

		if (href_list["close"])
			usr.machine = null
			return

		else if (href_list["convert"])
			if(!beaker)
				return
			var/datum/reagents/R = beaker:reagents
			var/datum/reagent/vaccine2/Vaccine
			for(var/datum/reagent/vaccine2/V in R.reagent_list)
				if(V)
					Vaccine = V
					break

			if(Dd.virus2)
				if(!Vaccine.data["virus2"])
					Vaccine.data["virus2"] = Dd.virus2.getcopy()
					converting = 5 * Vaccine.volume

			if(Dd.effects)
				if(!Vaccine.data["effects"])
					Vaccine.data["effects"] = list()
					Vaccine.data["effects"] = Dd.effects
					converting += 1 * Vaccine.volume

			Vaccine.data["resist"] = Dd.resistance
			converting += 3 * Vaccine.volume
			icon_state = "mixer2b"

			src.updateUsrDialog()
			return

		else if (href_list["eject_cont"])
			beaker:loc = src.loc
			beaker = null
			icon_state = "mixer0b"
			src.updateUsrDialog()

		else if (href_list["eject_disk"])
			Dd:loc = src.loc
			Dd = null
			src.updateUsrDialog()
			return

	attack_hand(mob/user as mob)
		if(stat & BROKEN)
			return
		user.machine = src
		var/dat
		if(!Dd)
			dat = "Please insert vaccine disk into the fabricator.<BR>"
		else
			dat = "[Dd.name] : <A href='?src=\ref[src];eject_disk=1'>Eject disk</A><BR><BR>"
		if(!beaker)
			dat += "Please insert container with vaccine basis into the fabricator.<BR>"
			dat += "<A href='?src=\ref[src];close=1'>Close</A>"
		else if(converting)
			dat = "Converting... [converting] seconds left"
		else
			dat += "<A href='?src=\ref[src];eject_cont=1'>Eject container</A><BR>"
			var/vaccine_vol = src.have_vaccine()
			if(!vaccine_vol)
				dat += "Container have no vaccine basis."
			else
				var/datum/reagents/R = beaker:reagents
				dat += "Container contains [vaccine_vol] units of vaccine<BR>"
				for(var/datum/reagent/vaccine2/Vac in R.reagent_list)
					if(Vac)
						if (Vac.data["effects"] || Vac.data["resist"] || Vac.data["virus2"])
							dat += "Unfortunately it is already converted and can not be used here.<BR>"
						else if(Dd)
							dat += "It is clean and can be converted : <A href='?src=\ref[src];convert=[Vac]'>Convert</a><BR>"
						else
							dat += "It is clean. Machine need disk to convert it.<BR>"
						break
				dat += "<A href='?src=\ref[src];close=1'>Close</A>"
		user << browse("<TITLE>Pathogenic Isolator</TITLE>Isolator menu:<BR><BR>[dat]", "window=isolator;size=575x400")
		onclose(user, "isolator")
		return




	process()
		if(converting > 0)   //For some reason
			converting -= 1
			if(converting == 0)
				state("The [src.name] pings")
				icon_state = "mixer1b"

	proc/state(var/msg)
		for(var/mob/O in hearers(src, null))
			O.show_message("\icon[src] \blue [msg]", 2)


/obj/item/weapon/vaccinedisk
	name = "Blank disk"
	desc = "Ordinary data disc. This one used by virologist to store vaccine information."		//You can make better description? Make it.
	icon = 'cloning.dmi'
	icon_state = "datadisk2"
	var/resistance = 0
	var/list/effects = list()
	var/datum/disease2/disease/virus2 = null
