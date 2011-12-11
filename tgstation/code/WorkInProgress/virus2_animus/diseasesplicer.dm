/obj/machinery/computer/diseasesplicer
	name = "Disease Research Console"
	icon = 'computer.dmi'
	icon_state = "splicer"
	//brightnessred = 0
//	brightnessgreen = 2
//	brightnessblue = 2
//	broken_icon

	var/datum/disease2/effectholder/memorybank = null
	var/analysed = 0
	var/obj/item/weapon/virusdish/dish = null
	var/obj/item/weapon/vaccinedisk/vaccine = null
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
		user << "You upload the contents of the disk into the buffer"
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

		dat += "<BR>Current DNA strand : "
		if(memorybank)
			dat += "<A href='?src=\ref[src];splice=1'>"
			if(analysed)
				dat += "[memorybank.effect.name] ([5-memorybank.effect.stage])"
			else
				dat += "Unknown DNA strand ([5-memorybank.effect.stage])"
			dat += "</a>"

			dat += "<BR><A href='?src=\ref[src];disk=1'>Burn DNA Sequence to data storage disk</a>"
		else
			dat += "Empty"

		dat += "<BR><BR>"

		if(dish)
			if(dish.virus2)
				if(dish.growth >= 50)
					for(var/datum/disease2/effectholder/e in dish.virus2.effects)
						dat += "<BR><A href='?src=\ref[src];grab=\ref[e]'> DNA strand"
						if(dish.analysed)
							dat += ": [e.effect.name]"
						dat += " (5-[e.effect.stage])</a>"
					if(dish.growth >= 100)																				//New vaccine
						dat += "<BR><BR><A href='?src=\ref[src];rantibody=1'>Research way of antibody production</a>"	//New vaccine
						dat += "<BR><A href='?src=\ref[src];rvirus=1'>Research way of virus production</a>"				//New vaccine
				else
					dat += "<BR>Insufficent cells to attempt gene splicing"
			else
				dat += "<BR>No virus found in dish"

			dat += "<BR><BR><A href='?src=\ref[src];eject=1'>Eject disk</a>"
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
		burning -= 1
		if(!burning)
			var/obj/item/weapon/diseasedisk/d = new /obj/item/weapon/diseasedisk(src.loc)
			if(analysed)
				d.name = "[memorybank.effect.name] GNA disk (Stage: [5-memorybank.effect.stage])"
			else
				d.name = "Unknown GNA disk (Stage: [5-memorybank.effect.stage])"
			d.effect = memorybank
			state("The [src.name] zings")
			icon_state = "splicer"
			src.updateUsrDialog()


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

		else if(href_list["splice"])
			for(var/datum/disease2/effectholder/e in dish.virus2.effects)
				if(e.stage == memorybank.stage)
					e.effect = memorybank.effect
			splicing = 10
			dish.virus2.spreadtype = "Blood"
			icon_state = "splicer_processing"

		else if(href_list["disk"])
			burning = 10
			icon_state = "splicer_processing"

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


/obj/item/weapon/diseasedisk
	name = "Blank GNA disk"
	icon = 'cloning.dmi'
	icon_state = "datadisk2"
	var/datum/disease2/effectholder/effect = null
	var/stage = 1

/obj/item/weapon/diseasedisk/premade/New()
	name = "Blank GNA disk (stage: [5-stage])"
	effect = new /datum/disease2/effectholder
	effect.effect = new /datum/disease2/effect/invisible
	effect.stage = stage
