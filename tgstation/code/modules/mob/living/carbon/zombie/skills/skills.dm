/mob/living/carbon/zombie/proc/howling()
	set name = "Howling"
	set desc = "Use this to call other zombies"
	set category = "Zombie"

	var/areaname = src.loc.loc.name
	for(var/mob/living/carbon/zombie/Z in world)
		Z << "\red <b>[src.name]</b> is howling in the <b>[areaname]!</b>"
	src.verbs -= /mob/living/carbon/zombie/proc/howling
	spawn(300)
		src.verbs += /mob/living/carbon/zombie/proc/howling


/mob/living/carbon/zombie/proc/infect()
	set name = "Infect"
	set desc = "Infect human!"
	set category = "Zombie"

	var/mob/C[] = list()
	for(var/mob/living/carbon/human/M in oview(1))
		if(M.stat != 2)
			C += M
	if(!C.len)
		src << "\red No living humans around you."
		return


	var/mob/living/carbon/human/H = pick(C)
	usr << "\blue You trying to infect [H.name]"
	H << "\red [usr.name] bites you!"
	if(prob(30))
		H.contract_disease(new /datum/disease/zombie_transformation(0),1)
		sleep(10)
		usr << "\blue You infect [H.name]"
	else
		sleep(10)
		usr << "\red Failed."


	src.verbs -= /mob/living/carbon/zombie/proc/infect
	spawn(900)
		src.verbs += /mob/living/carbon/zombie/proc/infect

//transformation
/mob/living/carbon/human/proc/zombieze()
	if (monkeyizing)
		return
	for(var/obj/item/W in src)
		drop_from_slot(W)
	update_clothing()
	monkeyizing = 1
	canmove = 0

	var/mob/living/carbon/zombie/Z = new /mob/living/carbon/zombie( loc )

	if (client)
		client.mob = Z
	if(mind)
		mind.transfer_to(Z)
	Z << "\red <B>You are now a zombie.</B>"
	Z << "\red YOUR OBJECTIVES:"
	Z << "\red 1. Kill all humans"
	Z << "\red 2. Eat their brains and corpses"
	Z << "\red 3. Infect them all"
	Z << "<br>Instructions:"
	Z << "You can destroy walls and tables with claws."
	Z << "You can kill humans with claws."
	Z << "You can infect humans around you"
	Z << "You can howl to call other zombies in your location"

	spawn(0)//To prevent the proc from returning null.
		del(src)
	return Z
