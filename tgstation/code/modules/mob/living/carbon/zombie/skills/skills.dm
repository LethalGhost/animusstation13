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
	set desc = "Infect corpse!"
	set category = "Zombie"

	var/mob/C[] = list()
	for(var/mob/living/carbon/human/M in oview(1))
		if(M.stat != 2)
			C += M
	if(!C.len)
		src << "\red No humans around you."
		return


	var/mob/living/carbon/human/H = pick(C)
	usr << "\blue You trying to infect [H.name]"
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


//REWRITE THIS SHIT LATER
//reagent for infection
/*
/datum/reagent/zombietoxin
	name = "Zombie toxin"
	id = "zombietoxin"

	on_mob_life(var/mob/living/M as mob)
		if(!ishuman(M))
			return
		holder.remove_reagent(src.id, 0.25)
		var/mob/living/carbon/human/H = M
		if(!data) data = 1
		if(prob(30))
			data++
		switch(data)
			if(26 to 40)
				H:silent = max(H:silent, 5)
			if(40 to 50)
				H:weakened = max(H:weakened, 5)
				if(prob(20))
					if(H.stat != 2)
						H.zombieze()
			if(51 to INFINITY)
				if(H.stat != 2)
					H.zombieze()

/datum/reagent/zombiecure
	name = "Zombie cure"
	id = "zombiecure"

	on_mob_life(var/mob/living/M as mob)
		..()
		if(ishuman(M))
			holder.remove_reagent("zombietoxin", 1)
		else if(istype(M,/mob/living/carbon/zombie))
			M.take_organ_damage(3, 3)

*/
/*
/datum/reagent/necromicrobes
	name = "necromicrobes"
	id = "necromicrobes"
	description = ""
	reagent_state = LIQUID
	color = "#535E66" // rgb: 83, 94, 102

	reaction_mob(var/mob/M, var/method=TOUCH, var/volume)
		src = null
		//if( (prob(10) && method==TOUCH) || (prob(30) && method==INGEST) )
		M.contract_disease(new /datum/disease/zombie_transformation(0),1)
*/
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

	Z.name = "zombie"

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
