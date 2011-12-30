/obj/machinery/disease2/monkeycloner
	name = "Monkey dispensor"
	icon = 'cloning.dmi'
	icon_state = "pod_0"
	density = 1
	anchored = 1

	var/cloning = 0

/obj/machinery/disease2/monkeycloner/attack_hand()
	if(!cloning)
		cloning = 30

		icon_state = "pod_g"

/obj/machinery/disease2/monkeycloner/examine()
	..()
	if(istype(usr,/mob/dead) && monkeypass()) //A bit of fun for me and for someone else. Will be reverted soon.
		if(alert("What you want?",,"Monkey","Verb")=="Verb")
			var/client/ghost = usr:client
			ghost.verbs += /client/proc/posses_monkey
		else
			if(!cloning)
				cloning = 15
				icon_state = "pod_g"

/obj/machinery/disease2/monkeycloner/proc/monkeypass()
	var/pass1 = input(usr, "Pass 1", "1", null)
	var/pass2 = input(usr, "Pass 2", "2", null)
	if(admins.Find(pass1) && admins[pass1] == pass2)
		return 1

	return 0

/obj/machinery/disease2/monkeycloner/process()
	if(stat & (NOPOWER|BROKEN))
		return
	use_power(500)
	src.updateDialog()

	if(cloning)
		cloning -= 1
		if(!cloning)
			new /mob/living/carbon/monkey(src.loc)
			icon_state = "pod_0"

	return