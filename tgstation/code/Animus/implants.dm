
/obj/proc_holder/animus_implant
//	var/category = "Implants"
	name = "Master verb"

	var/mob/living/carbon/human/owner_implant = null
	var/use_food = 0
	var/use_food_on_action = 0

	proc/process_implant()
		//world << "Hey i am process"
		owner_implant.nutrition -= use_food
		return

	proc/action()
		//world << "Hey i am action"
		if(owner_implant.nutrition > use_food_on_action)
			owner_implant.nutrition -= use_food_on_action
			return 1
		return 0

	proc/add_implant(var/mob/living/carbon/human/newmaster)
		owner_implant = newmaster
		owner_implant.isys.implants += src
		return

	proc/remove_implant()
		owner_implant.isys.implants -= src
		owner_implant = null
		del(src)
		return

	Click()
		..()
		//world << "hey i am click"
		action()
/obj/item/weapon/animus_implant
	icon = 'items.dmi'
	icon_state = "implanter0"
	item_state = "syringe_0"
	var/obj/proc_holder/animus_implant/loc_i = null
	attack(mob/living/carbon/human/M as mob, mob/living/carbon/human/user as mob)
		if(istype(M))
			src.loc = M
			loc_i.add_implant(M)
			user << "Implant added"
			del(src)
		..()

/obj/proc_holder/animus_implant/food_eat
	use_food = 0
	use_food_on_action = 100
	name = "Delete food"

/obj/item/weapon/animus_implant/food_eat
	loc_i = new /obj/proc_holder/animus_implant/food_eat()

/obj/proc_holder/animus_implant/gib
	use_food = 0
	use_food_on_action = 0
	name = "Gibself"
	action()
		owner_implant.gib()

/obj/item/weapon/animus_implant/gib
	loc_i = new /obj/proc_holder/animus_implant/gib()

/obj/proc_holder/animus_implant/blood_clean
	use_food = 0.01
	use_food_on_action = 100
	name = "Clean blood"
	action()
		var/datum/reagents/holder = owner_implant.reagents
		if(!..())
			owner_implant << "Low energy"
			return
		if(holder.has_reagent("toxin"))
			holder.remove_reagent("toxin", 10)
		if(holder.has_reagent("stoxin"))
			holder.remove_reagent("stoxin", 10)
		if(holder.has_reagent("plasma"))
			holder.remove_reagent("plasma", 10)
		if(holder.has_reagent("acid"))
			holder.remove_reagent("acid", 10)
		if(holder.has_reagent("amatoxin"))
			holder.remove_reagent("amatoxin", 10)
		if(holder.has_reagent("chloralhydrate"))
			holder.remove_reagent("chloralhydrate", 10)

/obj/item/weapon/animus_implant/blood_clean
	loc_i = new /obj/proc_holder/animus_implant/blood_clean()

/datum/implant_system
	var/list/obj/proc_holder/animus_implant/implants = list()
	proc/process()
		for(var/O in implants)
			O:process_implant()
		return