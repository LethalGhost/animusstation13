
/obj/proc_holder/animus_implant
//	var/category = "Implants"
	name = "Master verb"
	var/clicked = 1
	var/part_body = "chest"
	var/mob/living/carbon/human/owner_implant = null
	var/use_food = 0
	var/use_food_on_action = 0

	proc/process_implant()
		//world << "Hey i am process"
		if(owner_implant.nutrition > use_food)
			owner_implant.nutrition -= use_food
			return 1
		return 0
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
		for(var/mob/O in viewers(owner_implant, null))
			O.show_message("\red Something inside [owner_implant] destroy him!", 1)
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
		for(var/mob/O in viewers(owner_implant, null))
			O.show_message("\red Something inside [owner_implant] makes a noise", 1)
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

/obj/proc_holder/animus_implant/secret_slot
	use_food = 0.5
	use_food_on_action = 0.5
	name = "Put item"
	var/obj/item/weapon/hide_item
	process_implant()
		if(!..() && hide_item)
			action()
	action()
		if(!..()) return
		if(!hide_item)
			hide_item = owner_implant.get_active_hand()
			if(!hide_item) return
			if(hide_item.w_class > 2)
				hide_item = null
				owner_implant << "\red It's too big!"
				return
			hide_item.loc = src
			if (owner_implant.hand)
				owner_implant.l_hand = null
			else
				owner_implant.r_hand = null
			for(var/mob/O in viewers(owner_implant, null))
				O.show_message("\red [owner_implant] put [hide_item] into secret slot", 1)
			if (owner_implant.client)
				owner_implant.client.screen -= hide_item
				if(hide_item)
					hide_item.layer = initial(hide_item.layer)
			name = "Take item"
		else
			for(var/mob/O in viewers(owner_implant, null))
				O.show_message("\red [owner_implant] take [hide_item] from secret slot", 1)
			owner_implant.drop_from_slot(owner_implant.get_active_hand())
			owner_implant.put_in_hand(hide_item)
			hide_item = null
			name = "Put item"
		return

/obj/item/weapon/animus_implant/secret_slot
	loc_i = new /obj/proc_holder/animus_implant/secret_slot()

/obj/proc_holder/animus_implant/claws
	use_food = 0.1
	use_food_on_action = 10
	name = "Attack"
	var/obj/item/weapon/this_item
	var/early = 0
	New()
		..()
		this_item = new /obj/item/weapon/kitchenknife()
	action()
		if(early || !..()) return
		for(var/mob/O in viewers(owner_implant, null))
			O.show_message("\red [owner_implant] make circle attack!", 1)
		for(var/mob/living/O in oview(owner_implant, 1))
			this_item.attack(O, owner_implant)
		early = 1
		spawn(100)
			early = 0

/obj/item/weapon/animus_implant/claws
	loc_i = new /obj/proc_holder/animus_implant/claws()

/datum/implant_system
	var/list/obj/proc_holder/animus_implant/implants = list()
	proc/process()
		for(var/O in implants)
			O:process_implant()
		return