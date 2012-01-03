/obj/machinery/computer/diseasesplicer
	name = "Disease Research Console"
	icon = 'computer_animus.dmi'
	icon_state = "splicer"
	//brightnessred = 0
//	brightnessgreen = 2
//	brightnessblue = 2
//	broken_icon

	var/datum/disease2/effect/memorybank = null
	var/analysed = 0
	var/obj/item/weapon/virusdish/dish = null
	var/obj/item/weapon/vaccinedisk/vaccine = null
	var/obj/item/weapon/diseasedisk/gna = null
	var/burning = 0

	var/splicing = 0
	var/scanning = 0
	var/researching = 0											//New vaccine

	proc/state(var/msg)
		for(var/mob/O in hearers(src, null))
			O.show_message("\icon[src] \blue [msg]", 2)

/obj/machinery/computer/diseasesplicer/attackby(var/obj/I as obj, var/mob/user as mob)
/*
	if(istype(I, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'Screwdriver.ogg', 50, 1)
		if(do_after(user, 20))
			if (src.stat & BROKEN)
				user << "\blue The broken glass falls out."
				var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
				new /obj/item/weapon/shard( src.loc )
				var/obj/item/weapon/circuitboard/diseasesplicer/M = new /obj/item/weapon/circuitboard/diseasesplicer( A )
				for (var/obj/C in src)
					C.loc = src.loc
				A.circuit = M
				A.state = 3
				A.icon_state = "3"
				A.anchored = 1
				del(src)
			else
				user << "\blue You disconnect the monitor."
				var/obj/structure/computerframe/A = new /obj/structure/computerframe( src.loc )
				var/obj/item/weapon/circuitboard/diseasesplicer/M = new /obj/item/weapon/circuitboard/diseasesplicer( A )
				for (var/obj/C in src)
					C.loc = src.loc
				A.circuit = M
				A.state = 4
				A.icon_state = "4"
				A.anchored = 1
				del(src)*/
	if(istype(I,/obj/item/weapon/virusdish))
		var/mob/living/carbon/c = user
		if(!dish)

			dish = I
			c.drop_item()
			I.loc = src
	if(istype(I,/obj/item/weapon/diseasedisk))
		var/mob/living/carbon/c = user
		if(!gna)
			gna = I
			c.drop_item()
			I.loc = src
			user << "You insert the disk into the console"
		else
			user << "A disk is already loaded into the console."
			memorybank = I:effect


	//else
	src.attack_hand(user)
	return

/obj/machinery/computer/diseasesplicer/attack_ai(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/diseasesplicer/attack_paw(var/mob/user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/computer/diseasesplicer/attack_hand(var/mob/user as mob)
	if(..())
		return
	user.machine = src
	var/dat
	if(splicing)
		dat = "Splicing in progress"
	else if(scanning)
		dat = "Splicing in progress"
	else if(researching)
		dat = "Researching in progress"
	else if(burning)
		dat = "Data disk burning in progress"
	else
		if(dish)
			dat = "Virus dish inserted"
		if(gna)
			dat += "<BR>[gna.name] inserted. <A href='?src=\ref[src];ejectdisk=1'>Eject</a>"
		else
			dat += "<BR>GNA disk is missing"
		dat += "<BR>Current GNA strand in memory bank : "
		if(memorybank)
			if(analysed)
				dat += "[memorybank.name] ("
			else
				dat += "Unknown DNA strand ("
			for(var/i in memorybank.possible_stages)
				dat += "[i]"
			dat += ")"

			if(gna)
				dat += "<BR><A href='?src=\ref[src];burn=1'>Burn GNA Sequence to data storage disk</a>"
		else
			dat += "Empty"

		if(gna && gna.effect)
			dat += "<BR><A href='?src=\ref[src];getgna=1'>Get GNA Sequence from the disk to the buffer</a>"

		dat += "<BR><BR>"

		if(dish)
			if(dish.virus2)
				if(dish.growth >= 50)
					for(var/datum/disease2/effect/e in dish.virus2.effects)
						dat += "<BR><A href='?src=\ref[src];grab=\ref[e]'> GNA strand"
						if(dish.analysed)
							dat += ": [e.name]"
						dat += " Stage: [e.stage]</a>"
						if(memorybank && memorybank.possible_stages.Find(e.stage))
							dat += "	(<A href='?src=\ref[src];splice=[e.stage]'>Replace by GNA strand from the buffer</a>)"
						dat += "</a>"
					if(dish.growth >= 100)																				//New vaccine
						dat += "<BR><BR><A href='?src=\ref[src];rantibody=1'>Research way of antibody production</a>"	//New vaccine
						dat += "<BR><A href='?src=\ref[src];rvirus=1'>Research way of virus production</a>"				//New vaccine
					else
						dat += "<BR><BR><BR>Insufficent cells to research vaccine"
				else
					dat += "<BR>Insufficent cells to attempt gene splicing or research vaccine"
			else
				dat += "<BR>No virus found in dish"

			dat += "<BR><BR><A href='?src=\ref[src];eject=1'>Eject dish</a>"
		else
			dat += "<BR>Please insert dish"

	user << browse(dat, "window=computer;size=400x500")
	onclose(user, "computer")
	return

/obj/machinery/computer/diseasesplicer/process()
	if(stat & (NOPOWER|BROKEN))
		return
	use_power(500)
	src.updateDialog()

	if(scanning)
		scanning -= 1
		if(!scanning)
			state("The [src.name] beeps")
			icon_state = "splicer"
			src.updateUsrDialog()
	if(researching)											//New vaccine\|
		researching -= 1
		if(!researching)
			state("The [src.name] dings")
			if(vaccine)
				vaccine.loc = src.loc
				vaccine = null
			icon_state = "splicer"
			src.updateUsrDialog()							//New vaccine/|
	if(splicing)
		splicing -= 1
		if(!splicing)
			state("The [src.name] pings")
			icon_state = "splicer"
			src.updateUsrDialog()
	if(burning)
		if(gna)
			burning -= 1
			if(!burning)
				if(analysed)
					gna.name = "GNA disk ([memorybank.name])"
				else
					gna.name = "GNA disk (Unknown Syndrome)"
				gna.effect = memorybank
				state("The [src.name] zings")
				icon_state = "splicer"
				src.updateUsrDialog()
		else
			burning = 0
			icon_state = "splicer"

	return

/obj/machinery/computer/diseasesplicer/Topic(href, href_list)
	if(..())
		return
	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
		usr.machine = src

		if (href_list["grab"])
			memorybank = locate(href_list["grab"])
			analysed = dish.analysed
			del(dish)
			dish = null
			scanning = 10
			icon_state = "splicer_processing"

		else if(href_list["eject"])
			dish.loc = src.loc
			dish = null

		else if(href_list["ejectdisk"])
			gna.loc = src.loc
			gna = null

		else if(href_list["splice"])
			var/estage = text2num(href_list["splice"])
			for(var/datum/disease2/effect/E in dish.virus2.effects)
				if(estage == E.stage)
					var/datum/disease2/effect/new_effect = memorybank.getcopy()
					new_effect.stage = E.stage
					dish.virus2.effects -= E
					dish.virus2.effects += new_effect

			splicing = 10
			dish.virus2.spreadtype = "Blood"
			icon_state = "splicer_processing"

		else if(href_list["burn"])
			burning = 10
			icon_state = "splicer_processing"

		else if(href_list["getgna"])
			memorybank = gna.effect.getcopy()

		else if(href_list["rantibody"])													//New vaccine\|
			if(vaccine)
				Del(vaccine)
			vaccine = new /obj/item/weapon/vaccinedisk
			if(prob(85))
				vaccine.resistance = dish.virus2.uniqueID
			else if(prob(95))
				vaccine.effects += "toxic"
			else
				vaccine.effects += "gib"
			vaccine.name = "Disk: Vaccine production data"
			researching = 15
			dish.growth	-= 50
			icon_state = "splicer_processing"

		else if(href_list["rvirus"])
			if(vaccine)
				Del(vaccine)
			vaccine = new /obj/item/weapon/vaccinedisk
			vaccine.virus2 = dish.virus2.getcopy()
			if(prob(4))
				vaccine.virus2.minormutate()
			vaccine.name = "Disk: Disease production data"
			researching = 15
			dish.growth	-= 75
			icon_state = "splicer_processing"											//New vaccine/|

		src.add_fingerprint(usr)
	src.updateUsrDialog()
	return
