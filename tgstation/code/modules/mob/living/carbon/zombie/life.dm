#define HUMAN_MAX_OXYLOSS 12 //Defines how much oxyloss humans can get per tick. No air applies this value.

/mob/living/carbon/zombie
	var
		//oxygen_alert = 0
		//toxins_alert = 0
		//fire_alert = 0

		temperature_alert = 0


/mob/living/carbon/zombie/Life()
	set invisibility = 0
	set background = 1

	if (monkeyizing)
		return

	if(!loc)			// Fixing a null error that occurs when the mob isn't found in the world -- TLE
		return

	var/datum/gas_mixture/environment = loc.return_air()

	blinded = null

	//zombie proc
	zombie_proc()

	//Update Mind
	update_mind()

	//Disease Check
	handle_virus_updates()

	//Handle temperature/pressure differences between body and environment
	handle_environment(environment)

	//Mutations and radiation
	handle_mutations_and_radiation()

	//Chemicals in the body
	handle_chemicals_in_body()

	//stuff in the stomach
	handle_stomach()

	//Status updates, death etc.
	handle_regular_status_updates()

	// Update clothing
	update_clothing()

	if(client)
		handle_regular_hud_updates()

	//Being buckled to a chair or bed
	check_if_buckled()

	// Yup.
	update_canmove()

	clamp_values()

	// Grabbing
	//for(var/obj/item/weapon/grab/G in src)
	//	G.process()

	..() //for organs

/*
=================================================================
*/

/mob/living/carbon/zombie
	proc
		zombie_proc()
			//morph
			if(prob(70))
				morph_process++
			if(morph_process >= 100)
				morph_to(morph_stage+1)
				morph_process = 0

		//not "life" proc, but.
		morph_to(var/m_to)
			if(morph_stage >= 2) //MAX
				return
			morph_stage = m_to
			switch(m_to)
				if(2)
					//drop all except jumpsuit
					for(var/obj/item/W in src)
						if(W == w_uniform)
							continue
						drop_from_slot(W)
					//real_name = "zombie ([rand(1,1000)])"
					real_name = "Unknown"
					name = real_name
					src << "\blue You morphed. Now you can destroy walls."

		clamp_values()

			stunned = max(min(stunned, 20),0)
			paralysis = max(min(paralysis, 20), 0)
			weakened = max(min(weakened, 20), 0)
			sleeping = max(min(sleeping, 20), 0)
			bruteloss = max(bruteloss, 0)
			toxloss = max(toxloss, 0)
			//oxyloss = max(oxyloss, 0)
			fireloss = max(fireloss, 0)

			//temporary hack
			nutrition = 399
			oxyloss = 0

		update_mind()
			if(!mind && client)
				mind = new
				mind.current = src
				mind.assigned_role = job
				if(!mind.assigned_role)
					mind.assigned_role = "Assistant"
				mind.key = key

		handle_mutations_and_radiation()

			if (radiation)
				if (radiation > 100)
					radiation = 100
					weakened = 10
					src << "\red You feel weak."
					emote("collapse")

				if (radiation < 0)
					radiation = 0

				switch(radiation)
					if(1 to 49)
						radiation--
						if(prob(25))
							toxloss++
							updatehealth()

					if(50 to 74)
						radiation -= 2
						toxloss++
						if(prob(5))
							radiation -= 5
							weakened = 3
							src << "\red You feel weak."
							emote("collapse")
						updatehealth()

					if(75 to 100)
						radiation -= 3
						toxloss += 3
						if(prob(1))
							src << "\red You mutate!"
							randmutb(src)
							domutcheck(src,null)
							emote("gasp")
						updatehealth()

		update_canmove()
			if(paralysis || stunned || weakened || buckled) canmove = 0
			else canmove = 1

		handle_environment(datum/gas_mixture/environment)
			if(!environment)
				return
			var/environment_heat_capacity = environment.heat_capacity()
			var/loc_temp = T0C
			if(istype(loc, /turf/space))
				environment_heat_capacity = loc:heat_capacity
				loc_temp = 2.7
			else if(istype(loc, /obj/machinery/atmospherics/unary/cryo_cell))
				loc_temp = loc:air_contents.temperature
			else
				loc_temp = environment.temperature

			var/thermal_protection = get_thermal_protection()

			//world << "Loc temp: [loc_temp] - Body temp: [bodytemperature] - Fireloss: [fireloss] - Thermal protection: [get_thermal_protection()] - Fire protection: [thermal_protection + add_fire_protection(loc_temp)]"

			if(stat != 2 && abs(bodytemperature - 310.15) < 50)
				bodytemperature += adjust_body_temperature(bodytemperature, 310.15, thermal_protection)
			if(loc_temp < 310.15) // a cold place -> add in cold protection
				bodytemperature += adjust_body_temperature(bodytemperature, loc_temp, 1/thermal_protection)
			else // a hot place -> add in heat protection
				thermal_protection += add_fire_protection(loc_temp)
				bodytemperature += adjust_body_temperature(bodytemperature, loc_temp, 1/thermal_protection)

			// lets give them a fair bit of leeway so they don't just start dying
			//as that may be realistic but it's no fun
			if((bodytemperature > (T0C + 50)) || (bodytemperature < (T0C + 10)) && (!istype(loc, /obj/machinery/atmospherics/unary/cryo_cell))) // Last bit is just disgusting, i know
				if(environment.temperature > (T0C + 50) || (environment.temperature < (T0C + 10)))
					var/transfer_coefficient

					transfer_coefficient = 1
					if(head && (head.body_parts_covered & HEAD) && (environment.temperature < head.protective_temperature))
						transfer_coefficient *= head.heat_transfer_coefficient
					if(wear_mask && (wear_mask.body_parts_covered & HEAD) && (environment.temperature < wear_mask.protective_temperature))
						transfer_coefficient *= wear_mask.heat_transfer_coefficient
					if(wear_suit && (wear_suit.body_parts_covered & HEAD) && (environment.temperature < wear_suit.protective_temperature))
						transfer_coefficient *= wear_suit.heat_transfer_coefficient

					handle_temperature_damage(HEAD, environment.temperature, environment_heat_capacity*transfer_coefficient)

					transfer_coefficient = 1
					if(wear_suit && (wear_suit.body_parts_covered & UPPER_TORSO) && (environment.temperature < wear_suit.protective_temperature))
						transfer_coefficient *= wear_suit.heat_transfer_coefficient
					if(w_uniform && (w_uniform.body_parts_covered & UPPER_TORSO) && (environment.temperature < w_uniform.protective_temperature))
						transfer_coefficient *= w_uniform.heat_transfer_coefficient

					handle_temperature_damage(UPPER_TORSO, environment.temperature, environment_heat_capacity*transfer_coefficient)

					transfer_coefficient = 1
					if(wear_suit && (wear_suit.body_parts_covered & LOWER_TORSO) && (environment.temperature < wear_suit.protective_temperature))
						transfer_coefficient *= wear_suit.heat_transfer_coefficient
					if(w_uniform && (w_uniform.body_parts_covered & LOWER_TORSO) && (environment.temperature < w_uniform.protective_temperature))
						transfer_coefficient *= w_uniform.heat_transfer_coefficient

					handle_temperature_damage(LOWER_TORSO, environment.temperature, environment_heat_capacity*transfer_coefficient)

					transfer_coefficient = 1
					if(wear_suit && (wear_suit.body_parts_covered & LEGS) && (environment.temperature < wear_suit.protective_temperature))
						transfer_coefficient *= wear_suit.heat_transfer_coefficient
					if(w_uniform && (w_uniform.body_parts_covered & LEGS) && (environment.temperature < w_uniform.protective_temperature))
						transfer_coefficient *= w_uniform.heat_transfer_coefficient

					handle_temperature_damage(LEGS, environment.temperature, environment_heat_capacity*transfer_coefficient)

					transfer_coefficient = 1
					if(wear_suit && (wear_suit.body_parts_covered & ARMS) && (environment.temperature < wear_suit.protective_temperature))
						transfer_coefficient *= wear_suit.heat_transfer_coefficient
					if(w_uniform && (w_uniform.body_parts_covered & ARMS) && (environment.temperature < w_uniform.protective_temperature))
						transfer_coefficient *= w_uniform.heat_transfer_coefficient

					handle_temperature_damage(ARMS, environment.temperature, environment_heat_capacity*transfer_coefficient)

					transfer_coefficient = 1
					if(wear_suit && (wear_suit.body_parts_covered & HANDS) && (environment.temperature < wear_suit.protective_temperature))
						transfer_coefficient *= wear_suit.heat_transfer_coefficient
					if(gloves && (gloves.body_parts_covered & HANDS) && (environment.temperature < gloves.protective_temperature))
						transfer_coefficient *= gloves.heat_transfer_coefficient

					handle_temperature_damage(HANDS, environment.temperature, environment_heat_capacity*transfer_coefficient)

					transfer_coefficient = 1
					if(wear_suit && (wear_suit.body_parts_covered & FEET) && (environment.temperature < wear_suit.protective_temperature))
						transfer_coefficient *= wear_suit.heat_transfer_coefficient
					if(shoes && (shoes.body_parts_covered & FEET) && (environment.temperature < shoes.protective_temperature))
						transfer_coefficient *= shoes.heat_transfer_coefficient

					handle_temperature_damage(FEET, environment.temperature, environment_heat_capacity*transfer_coefficient)

			/*if(stat==2) //Why only change body temp when they're dead? That makes no sense!!!!!!
				bodytemperature += 0.8*(environment.temperature - bodytemperature)*environment_heat_capacity/(environment_heat_capacity + 270000)
			*/

			//Account for massive pressure differences
			return //TODO: DEFERRED

		adjust_body_temperature(current, loc_temp, boost)
			var/temperature = current
			var/difference = abs(current-loc_temp)	//get difference
			var/increments// = difference/10			//find how many increments apart they are
			if(difference > 50)
				increments = difference/5
			else
				increments = difference/10
			var/change = increments*boost	// Get the amount to change by (x per increment)
			var/temp_change
			if(current < loc_temp)
				temperature = min(loc_temp, temperature+change)
			else if(current > loc_temp)
				temperature = max(loc_temp, temperature-change)
			temp_change = (temperature - current)
			return temp_change

		get_thermal_protection()
			var/thermal_protection = 1.0
			//Handle normal clothing
			if(head && (head.body_parts_covered & HEAD))
				thermal_protection += 0.5
			if(wear_suit && (wear_suit.body_parts_covered & UPPER_TORSO))
				thermal_protection += 0.5
			if(w_uniform && (w_uniform.body_parts_covered & UPPER_TORSO))
				thermal_protection += 0.5
			if(wear_suit && (wear_suit.body_parts_covered & LEGS))
				thermal_protection += 0.2
			if(wear_suit && (wear_suit.body_parts_covered & ARMS))
				thermal_protection += 0.2
			if(wear_suit && (wear_suit.body_parts_covered & HANDS))
				thermal_protection += 0.2
			if(shoes && (shoes.body_parts_covered & FEET))
				thermal_protection += 0.2
			if(wear_suit && (wear_suit.flags & SUITSPACE))
				thermal_protection += 3
			if(w_uniform && (w_uniform.flags & SUITSPACE))
				thermal_protection += 3
			if(head && (head.flags & HEADSPACE))
				thermal_protection += 1
			if(mutations & COLD_RESISTANCE)
				thermal_protection += 5

			return thermal_protection

		add_fire_protection(var/temp)
			var/fire_prot = 0
			if(head)
				if(head.protective_temperature > temp)
					fire_prot += (head.protective_temperature/10)
			if(wear_mask)
				if(wear_mask.protective_temperature > temp)
					fire_prot += (wear_mask.protective_temperature/10)
			if(glasses)
				if(glasses.protective_temperature > temp)
					fire_prot += (glasses.protective_temperature/10)
			if(ears)
				if(ears.protective_temperature > temp)
					fire_prot += (ears.protective_temperature/10)
			if(wear_suit)
				if(wear_suit.protective_temperature > temp)
					fire_prot += (wear_suit.protective_temperature/10)
			if(w_uniform)
				if(w_uniform.protective_temperature > temp)
					fire_prot += (w_uniform.protective_temperature/10)
			if(gloves)
				if(gloves.protective_temperature > temp)
					fire_prot += (gloves.protective_temperature/10)
			if(shoes)
				if(shoes.protective_temperature > temp)
					fire_prot += (shoes.protective_temperature/10)

			return fire_prot

		handle_temperature_damage(body_part, exposed_temperature, exposed_intensity)
			if(nodamage)
				return
			var/discomfort = min(abs(exposed_temperature - bodytemperature)*(exposed_intensity)/2000000, 1.0)

			switch(body_part)
				if(HEAD)
					TakeDamage("head", 0, 2.5*discomfort)
				if(UPPER_TORSO)
					TakeDamage("chest", 0, 2.5*discomfort)
				if(LOWER_TORSO)
					TakeDamage("groin", 0, 2.0*discomfort)
				if(LEGS)
					TakeDamage("l_leg", 0, 0.6*discomfort)
					TakeDamage("r_leg", 0, 0.6*discomfort)
				if(ARMS)
					TakeDamage("l_arm", 0, 0.4*discomfort)
					TakeDamage("r_arm", 0, 0.4*discomfort)
				if(FEET)
					TakeDamage("l_foot", 0, 0.25*discomfort)
					TakeDamage("r_foot", 0, 0.25*discomfort)
				if(HANDS)
					TakeDamage("l_hand", 0, 0.25*discomfort)
					TakeDamage("r_hand", 0, 0.25*discomfort)

		handle_chemicals_in_body()
			if(reagents) reagents.metabolize(src)

			// nutrition decrease
			if (nutrition > 0 && stat != 2)
				nutrition = max (0, nutrition - HUNGER_FACTOR)

			if (nutrition > 450)
				if(overeatduration < 600) //capped so people don't take forever to unfat
					overeatduration++
			else
				if(overeatduration > 1)
					overeatduration -= 2 //doubled the unfat rate

			if (drowsyness)
				drowsyness--
				eye_blurry = max(2, eye_blurry)
				if (prob(5))
					sleeping = 1
					paralysis = 5

			confused = max(0, confused - 1)
			// decrement dizziness counter, clamped to 0
			if(resting)
				dizziness = max(0, dizziness - 15)
				jitteriness = max(0, jitteriness - 15)
			else
				dizziness = max(0, dizziness - 3)
				jitteriness = max(0, jitteriness - 3)

			updatehealth()

			return //TODO: DEFERRED

		handle_regular_status_updates()

			//health = 100 - (oxyloss + toxloss + fireloss + bruteloss + cloneloss)
			health = 200 - (toxloss + fireloss + bruteloss)

			if(resting)
				weakened = max(weakened, 5)

			if(health < 0 || brain_op_stage == 4.0)
				death()

			if (stat != 2) //Alive.
				if (silent)
					silent--

				if (paralysis || stunned || weakened) //Stunned etc.
					if (stunned > 0)
						stunned--
						stat = 0
					if (weakened > 0)
						weakened--
						lying = 1
						stat = 0
					if (paralysis > 0)
						paralysis--
						blinded = 1
						lying = 1
						stat = 1
					var/h = hand
					hand = 0
					drop_item()
					hand = 1
					drop_item()
					hand = h

				else	//Not stunned.
					lying = 0
					stat = 0

			else //Dead.
				lying = 1
				blinded = 1
				stat = 2
				silent = 0

			if (eye_blind)
				eye_blind--
				blinded = 1

			if (ear_deaf > 0) ear_deaf--
			if (ear_damage < 25)
				ear_damage -= 0.05
				ear_damage = max(ear_damage, 0)

			density = !( lying )

			if ((sdisabilities & 1 || istype(glasses, /obj/item/clothing/glasses/blindfold)))
				blinded = 1
			if ((sdisabilities & 4 || istype(ears, /obj/item/clothing/ears/earmuffs)))
				ear_deaf = 1

			return 1

		handle_regular_hud_updates()

			if(client)
				for(var/image/hud in client.images)
					if(copytext(hud.icon_state,1,4) == "hud") //ugly, but icon comparison is worse, I believe
						del(hud)

			if (stat == 2 || mutations & XRAY)
				sight |= SEE_TURFS
				sight |= SEE_MOBS
				sight |= SEE_OBJS
				see_in_dark = 8
				if(!druggy)
					see_invisible = 2

			/*else if (istype(glasses, /obj/item/clothing/glasses/meson))
				sight |= SEE_TURFS
				if(!druggy)
					see_invisible = 0
			else if (istype(glasses, /obj/item/clothing/glasses/night))
				see_in_dark = 5
				if(!druggy)
					see_invisible = 0
			else if (istype(glasses, /obj/item/clothing/glasses/thermal))
				sight |= SEE_MOBS
				if(!druggy)
					see_invisible = 2
			else if (istype(glasses, /obj/item/clothing/glasses/material))
				sight |= SEE_OBJS
				if (!druggy)
					see_invisible = 0*/

			else if (stat != 2)
				sight &= ~SEE_TURFS
				sight &= ~SEE_OBJS
				sight |= SEE_MOBS //thermal vision --balagi
				see_in_dark = 5 //night vision

			else if (istype(glasses, /obj/item/clothing/glasses/sunglasses))
				see_in_dark = 1
			else if (istype(head, /obj/item/clothing/head/helmet/welding))
				if(!head:up && tinted_weldhelh)
					see_in_dark = 1

			//zombie_hud
			if(client)
				var/icon/tempHud = 'hud.dmi'
				for(var/mob/living/carbon/human/patient in view(src))
					for(var/datum/disease/D in patient.viruses)
						if(istype(D, /datum/disease/zombie_transformation))
							client.images += image(tempHud,patient,"hudill")
							break

			if (sleep) sleep.icon_state = text("sleep[]", sleeping)
			if (rest) rest.icon_state = text("rest[]", resting)

			if (healths)
				if (stat != 2)
					switch(health)
						if(200 to INFINITY)
							healths.icon_state = "health0"
						if(160 to 200)
							healths.icon_state = "health1"
						if(120 to 160)
							healths.icon_state = "health2"
						if(80 to 120)
							healths.icon_state = "health3"
						if(40 to 80)
							healths.icon_state = "health4"
						if(0 to 40)
							healths.icon_state = "health5"
						else
							healths.icon_state = "health6"
				else
					healths.icon_state = "health7"

			if (nutrition_icon)
				switch(nutrition)
					if(450 to INFINITY)
						nutrition_icon.icon_state = "nutrition0"
					if(350 to 450)
						nutrition_icon.icon_state = "nutrition1"
					if(250 to 350)
						nutrition_icon.icon_state = "nutrition2"
					if(150 to 250)
						nutrition_icon.icon_state = "nutrition3"
					else
						nutrition_icon.icon_state = "nutrition4"

			if(pullin)	pullin.icon_state = "pull[pulling ? 1 : 0]"

			if(resting || lying || sleeping)	rest.icon_state = "rest[(resting || lying || sleeping) ? 1 : 0]"

			//NOTE: the alerts dont reset when youre out of danger. dont blame me,
			//blame the person who coded them. Temporary fix added.

			switch(bodytemperature) //310.055 optimal body temp

				if(370 to INFINITY)
					bodytemp.icon_state = "temp4"
				if(350 to 370)
					bodytemp.icon_state = "temp3"
				if(335 to 350)
					bodytemp.icon_state = "temp2"
				if(320 to 335)
					bodytemp.icon_state = "temp1"
				if(300 to 320)
					bodytemp.icon_state = "temp0"
				if(295 to 300)
					bodytemp.icon_state = "temp-1"
				if(280 to 295)
					bodytemp.icon_state = "temp-2"
				if(260 to 280)
					bodytemp.icon_state = "temp-3"
				else
					bodytemp.icon_state = "temp-4"

			client.screen -= hud_used.blurry
			client.screen -= hud_used.druggy
			client.screen -= hud_used.vimpaired
			client.screen -= hud_used.darkMask

			if ((blind && stat != 2))
				if ((blinded))
					blind.layer = 18
				else
					blind.layer = 0

					if (disabilities & 1 && !istype(glasses, /obj/item/clothing/glasses/regular) )
						client.screen += hud_used.vimpaired

					if (eye_blurry)
						client.screen += hud_used.blurry

					if (druggy)
						client.screen += hud_used.druggy

					if (istype(head, /obj/item/clothing/head/helmet/welding))
						if(!head:up && tinted_weldhelh)
							client.screen += hud_used.darkMask

			if (stat != 2)
				if (machine)
					if (!( machine.check_eye(src) ))
						reset_view(null)
				else
					if(!client.adminobs)
						reset_view(null)

			client.screen += hud_used.darkMask //zombie mask

			return 1

		handle_virus_updates()
			if(bodytemperature > 406)
				for(var/datum/disease/D in viruses)
					D.cure()


			if(!virus2)
				for(var/mob/living/carbon/M in oviewers(4,src))
					if(M.virus2)
						infect_virus2(src,M.virus2)
				for(var/obj/decal/cleanable/blood/B in view(4, src))
					if(B.virus2)
						infect_virus2(src,B.virus2)
			else
				virus2.activate(src)



			return


		check_if_buckled()
			if (buckled)
				lying = istype(buckled, /obj/stool/bed) || istype(buckled, /obj/machinery/conveyor)
				if(lying)
					drop_item()
				density = 1
			else
				density = !lying

		handle_stomach()
			spawn(0)
				for(var/mob/M in stomach_contents)
					if(M.loc != src)
						stomach_contents.Remove(M)
						continue
					if(istype(M, /mob/living/carbon) && stat != 2)
						if(M.stat == 2)
							M.death(1)
							stomach_contents.Remove(M)
							del(M)
							continue
						if(air_master.current_cycle%3==1)
							if(!M.nodamage)
								M.bruteloss += 5
							nutrition += 10