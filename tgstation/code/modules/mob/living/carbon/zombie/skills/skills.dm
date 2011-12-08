/mob/living/carbon/zombie/proc/howling()
	set name = "Howling"
	set desc = "Use this to call other zombies"
	set category = "Zombie"

	if(src.stat)
		return

	var/areaname = src.loc.loc.name
	for(var/mob/living/carbon/zombie/Z in world)
		Z << "\red <b>[src.name]</b> is howling in the <b>[areaname]!</b>"
	playsound(src, 'howling.ogg', 35, 1, 1)
	src.verbs -= /mob/living/carbon/zombie/proc/howling
	spawn(300)
		src.verbs += /mob/living/carbon/zombie/proc/howling


/mob/living/carbon/zombie/proc/infect()
	set name = "Infect"
	set desc = "Infect human!"
	set category = "Zombie"

	if(src.stat)
		return

	var/mob/C[] = list()
	for(var/mob/living/carbon/human/M in oview(1))
		if(M.stat != 2)
			C += M
	if(!C.len)
		src << "\red No living humans around you."
		return

	src.verbs -= /mob/living/carbon/zombie/proc/infect
	spawn(15)
		src.verbs += /mob/living/carbon/zombie/proc/infect

	var/mob/living/carbon/human/H = pick(C)
	usr << "\blue You trying to infect [H.name]"
	H.show_message(text("\red <B>[src.name] has attempted to bite [H]!</B>"), 1)
	var/turf/T1 = get_turf(src)
	var/turf/T2 = get_turf(H)
	sleep(10)
	if((get_turf(src) == T1) && (get_turf(H) == T2))
		H.contract_disease(new /datum/disease/zombie_transformation(0),1)
		H.show_message(text("\red <B>[src.name] has bit [H]!</B>"), 1)
		usr << "\blue You infect [H.name]"
	else
		usr << "\red Failed. You and target must stand still."


/mob/living/carbon/zombie/proc/removebrains()
	set name = "Remove brains"
	set desc = "Nyam"
	set category = "Zombie"

	if(src.stat)
		return
	var/mob/C[] = list()
	for(var/mob/living/carbon/human/M in oview(1))
		if(M.stat == 2 && M.brain_op_stage != 4.0)
			C += M
	for(var/mob/living/carbon/monkey/M in oview(1))
		if(M.stat == 2 && M.brain_op_stage != 4.0)
			C += M
	if(!C.len)
		src << "\red No dead humans or monkeys with brain around you."
		return
	var/mob/living/carbon/H = pick(C)
	var/obj/item/brain/B = new(H.loc)
	B.transfer_identity(H)

	H:brain_op_stage = 4.0
	H.death()


//transformation
/mob/living/carbon/human/proc/zombieze()
	if (monkeyizing)
		return

	monkeyizing = 1
	canmove = 0

	var/mob/living/carbon/zombie/Z = new /mob/living/carbon/zombie( loc )
	Z.morph_stage = 1
	Z.name = src.name
	Z.real_name = src.real_name

	if(wear_suit)
		wear_suit.loc = Z
		Z.wear_suit = wear_suit

	if(w_uniform)
		w_uniform.loc = Z
		Z.w_uniform = w_uniform

	if(shoes)
		shoes.loc = Z
		Z.shoes = shoes

	if(gloves)
		gloves.loc = Z
		Z.gloves = gloves

	if(glasses)
		glasses.loc = Z
		Z.glasses = glasses

	if(head)
		head.loc = Z
		Z.head = head

	if(wear_id)
		wear_id.loc = Z
		Z.wear_id = wear_id


	for(var/obj/item/W in src)
		drop_from_slot(W)

	//update_clothing()


	if (client)
		client.mob = Z
	if(mind)
		mind.transfer_to(Z)
	Z << "\red <B>You are now a zombie.</B>"
	Z << "\red YOUR OBJECTIVES:"
	Z << "\red 1. Infect all humans"
	Z << "<br>Instructions:"
	Z << "You can destroy tables with claws."
	Z << "You can stun and kill humans with claws."
	Z << "You can infect stunned humans around you"
	Z << "You can howl to call other zombies in your location"

	spawn(0)//To prevent the proc from returning null.
		del(src)
	return Z


//Eating brains
/datum/reagent/nutrientbrains
	name = "Nutrient brains"
	id = "nutrientbrains"

	on_mob_life(var/mob/living/M as mob)
		..()
		if(istype(M,/mob/living/carbon/zombie))
			M.heal_organ_damage(1,1)
			M.toxloss--
		return