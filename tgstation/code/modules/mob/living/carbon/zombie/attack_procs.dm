//temporary here

//MOBS
/mob/living/carbon/human/attack_zombie(mob/M as mob)
	if (!ticker)
		M << "You cannot attack people before the game has started."
		return

	if (istype(loc, /turf) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return

	if (w_uniform)
		w_uniform.add_fingerprint(M)

	//stun
	if (prob(20))
		if (weakened < 15)
			weakened = rand(10, 15)
		for(var/mob/O in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[] has tackled down []!</B>", M, src), 1)
		return

	var/damage = rand(15, 30) // How much damage aliens do to humans? Increasing -- TLE
							  // I've decreased the chance of humans being protected by uniforms. Now aliens can actually damage them.
	var/datum/organ/external/affecting = organs["chest"]
	var/t = M.zone_sel.selecting
	if ((t in list( "eyes", "mouth" )))
		t = "head"
	var/def_zone = ran_zone(t)
	if (organs[def_zone])
		affecting = organs[def_zone]
	if ((istype(affecting, /datum/organ/external) && prob(95)))
		//playsound(loc, 'slice.ogg', 25, 1, -1)
		for(var/mob/O in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[] has slashed at []!</B>", M, src), 1)
		if (def_zone == "head")
			if ((((head && head.body_parts_covered & HEAD) || (wear_mask && wear_mask.body_parts_covered & HEAD)) && prob(5)))
				if (prob(20))
					affecting.take_damage(damage, 0)
				else
					show_message("\red You have been protected from a hit to the head.")
				return
			if (damage >= 25)
				if (weakened < 10)
					weakened = rand(10, 15)
				for(var/mob/O in viewers(M, null))
					if ((O.client && !( O.blinded )))
						O.show_message(text("\red <B>[] has wounded []!</B>", M, src), 1, "\red You hear someone fall.", 2)
			affecting.take_damage(damage)
		else
			if (def_zone == "chest")
				if ((((wear_suit && wear_suit.body_parts_covered & UPPER_TORSO) || (w_uniform && w_uniform.body_parts_covered & LOWER_TORSO)) && prob(10)))
					show_message("\blue You have been protected from a hit to the chest.")
					return
				if (damage >= 25)
					if (prob(50))
						if (weakened < 5)
							weakened = 5
						//playsound(loc, 'slashmiss.ogg', 50, 1, -1)
						for(var/mob/O in viewers(src, null))
							if ((O.client && !( O.blinded )))
								O.show_message(text("\red <B>[] has tackled down []!</B>", M, src), 1, "\red You hear someone fall.", 2)
					else
						if (stunned < 5)
							stunned = 5
						for(var/mob/O in viewers(src, null))
							if ((O.client && !( O.blinded )))
								O.show_message(text("\red <B>[] has stunned []!</B>", M, src), 1)
					if(stat != 2)	stat = 1
				affecting.take_damage(damage)
			else
				if (def_zone == "groin")
					if ((((wear_suit && wear_suit.body_parts_covered & LOWER_TORSO) || (w_uniform && w_uniform.body_parts_covered & LOWER_TORSO)) && prob(1)))
						show_message("\blue You have been protected from a hit to the lower chest.")
						return
					if (damage >= 25)
						if (prob(50))
							if (weakened < 3)
								weakened = 3
							for(var/mob/O in viewers(src, null))
								if ((O.client && !( O.blinded )))
									O.show_message(text("\red <B>[] has tackled down []!</B>", M, src), 1, "\red You hear someone fall.", 2)
						else
							if (stunned < 3)
								stunned = 3
							for(var/mob/O in viewers(src, null))
								if ((O.client && !( O.blinded )))
									O.show_message(text("\red <B>[] has stunned []!</B>", M, src), 1)
						if(stat != 2)	stat = 1
					affecting.take_damage(damage)
				else
					affecting.take_damage(damage)
		UpdateDamageIcon()
		updatehealth()
	else
		//playsound(loc, 'slashmiss.ogg', 50, 1, -1)
		for(var/mob/O in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[M] has lunged at [src] but missed!</B>"), 1)


/mob/living/carbon/alien/attack_zombie(mob/M as mob)
	if (!ticker)
		M << "You cannot attack people before the game has started."
		return
	if (istype(loc, /turf) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return
	..()
	playsound(loc, 'bite.ogg', 50, 1, -1)
	var/damage = rand(15, 30)
	for(var/mob/O in viewers(src, null))
		if ((O.client && !( O.blinded )))
			O.show_message(text("\red <B>[M.name] has bit []!</B>", src), 1)
	bruteloss += damage
	updatehealth()
	return

/mob/living/carbon/monkey/attack_zombie(mob/M as mob)
	if (!ticker)
		M << "You cannot attack people before the game has started."
		return
	if (istype(loc, /turf) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return

//	playsound(loc, 'slice.ogg', 25, 1, -1)
	var/damage = rand(15, 30)
	if (damage >= 25)
		damage = rand(20, 40)
		if (paralysis < 15)
			paralysis = rand(10, 15)
		for(var/mob/O in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[] has wounded [name]!</B>", M), 1)
	else
		for(var/mob/O in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[] has slashed [name]!</B>", M), 1)
	bruteloss += damage
	updatehealth()
	return

/mob/living/silicon/robot/attack_zombie(mob/living/carbon/zombie/M as mob)
	if (!ticker)
		M << "You cannot attack people before the game has started."
		return

	if (istype(loc, /turf) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return

	var/damage = rand(10, 20)
	if (prob(90))

		playsound(loc, 'slash.ogg', 25, 1, -1)
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\red <B>[] has slashed at []!</B>", M, src), 1)
		if(prob(8))
			flick("noise", flash)
		bruteloss += damage
		updatehealth()
	else
		playsound(loc, 'slashmiss.ogg', 25, 1, -1)
		for(var/mob/O in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[] took a swipe at []!</B>", M, src), 1)

	return

//BRAINS
/obj/item/brain/attack_zombie(mob/user as mob)
	user << "\blue You eat [src]"
	user.reagents.add_reagent("nutrientbrains", 15)
	del(src)



//OBJS&TURFS
/obj/window/attack_zombie(mob/user as mob)
	user << text("\red You smash against the window.")
	for(var/mob/O in oviewers())
		if ((O.client && !( O.blinded )))
			O << text("\red [] smashes against the window.", user)
	playsound(src.loc, 'Glasshit.ogg', 100, 1)
	src.health -= 15
	if(src.health <= 0)
		usr << text("\red You smash through the window.")
		for(var/mob/O in oviewers())
			if ((O.client && !( O.blinded )))
				O << text("\red [] smashes through the window!", user)
		src.health = 0
		new /obj/item/weapon/shard(src.loc)
		if(reinf)
			new /obj/item/stack/rods(src.loc)
		src.density = 0
		del(src)
		return
	return

/obj/grille/attack_zombie(var/mob/user)
	playsound(src.loc, 'grillehit.ogg', 80, 1)
	user.visible_message("[user.name] mangles the [src.name].", \
						"You mangle the [src.name].", \
						"You hear a noise")
	if(!shock(usr, 70))
		src.health -= 5
		healthcheck()
		return


/turf/simulated/wall/attack_zombie(mob/living/carbon/zombie/user as mob)
	if(user.morph_stage <= 1)
		return
	user << "\blue You hit the wall."
	playsound(src.loc, 'grillehit.ogg', 80, 1) // grille sound - replace later (or not?)
	//playsound(src.loc, "sparks", 50, 1)
	if(prob(20))
		dismantle_wall(1)
		for(var/mob/O in viewers(user, 5))
			O.show_message(text("\blue The wall was destroyed by []!", user), 1, text("\red You hear metal clank."), 2)
		return


/turf/simulated/wall/r_wall/attack_zombie(mob/user as mob)
	user << "\red This wall is so thick."
	return

/obj/table/attack_zombie(mob/user as mob)
	user << "\blue You hit the table."
	if(prob(60))
		for(var/mob/O in viewers(user, 5))
			O.show_message(text("\blue The table was destroyed by []!", user), 1, text("\red You hear metal being sliced and sparks flying."), 2)
		new /obj/item/weapon/table_parts( src.loc )
		del(src)
	return

/obj/rack/attack_zombie(mob/user as mob)
	user << "\blue You destroy the rack."
	new /obj/item/weapon/rack_parts( src.loc )
	del(src)
	return

/obj/closet/attack_zombie(mob/user as mob)
	src.add_fingerprint(user)

	if (!src.toggle())
		usr << "\blue It won't budge!"
		if(prob(20))
			src.welded = 0
			if(src.toggle())
				usr << "\blue You open the closet."

/obj/machinery/power/apc/attack_zombie()
	//add here kill_apc code
	return

/obj/machinery/light/attack_zombie(mob/user as mob)
	//if(status != LIGHT_BROKEN && status != LIGHT_EMPTY)
	if(status != 2 && status != 1) //defines from code\modules\power\lighting.dm
		user << "You hit the light, and it smashes!"
		for(var/mob/M in viewers(src))
			if(M == user)
				continue
			M.show_message("[user.name] smashed the light!", 3, "You hear a tinkle of breaking glass", 2)
		if (prob(12))
			electrocute_mob(user, get_area(src), src, 0.3)
		broken()


/obj/machinery/door/attack_zombie(mob/living/carbon/zombie/user as mob)
	switch(user.morph_stage)
		if(1)
			return attack_hand(user)
/*		if(2)
			//open if no_power like with crowbar
*/