//To simplify, all diseases have 4 stages, with effects starting at stage 2
//Stage 1 = Rest,Minor disease
//Stage 2 = Minimal effect
//Stage 3 = Medium effect
//Stage 4 = Death/Really Really really bad effect

/*
/obj/virus
	// a virus instance that is placed on the map, moves, and infects
	invisibility = 100

	icon = 'laptop.dmi'
	icon_state = "laptop_0"

	var/datum/disease2/D

	New()
		..()
		step_rand(src)
		step_rand(src)
		anchored = 1
		spawn(300) del(src)
*/
/mob/living/carbon/proc/get_infection_chance()
	var/score = 0
	var/cloth_armor = 0
	var/mob/living/carbon/M = src
	var/obj/item/clothing/cloth = null
	if(istype(M, /mob/living/carbon/human))
		if(M:gloves)
			cloth = M:gloves
			cloth_armor = cloth.armor["bio"]
			//world << "Защита перчаток = [cloth_armor]"
			score += cloth_armor
		if(M:wear_suit)
			cloth = M:wear_suit
			cloth_armor = cloth.armor["bio"]
			//world << "Защита костюма = [cloth_armor]"
			score += cloth_armor
		if(M:head)
			cloth = M:head
			cloth_armor = cloth.armor["bio"]
			//world << "Защита шлема = [cloth_armor]"
			score += cloth_armor
		if(M:shoes)
			//world << "Обувь есть"
			score += 100
	if(M.wear_mask)
		if(M.internal)
			//world << "Воздух из баллона"
			score += 100
		else
			cloth = M:wear_mask
			cloth_armor = cloth.armor["bio"]
			//world << "Защита маски = [cloth_armor]"
			score += cloth_armor
	score /= 5
	if(score < 0)					//For some reason
		score = 0
	if(score > 100 || prob(score))
		//world << "Одежда не пропустила вирус при защите [score]"
		return 0
	//world << "Одежда пропустила вирус при защите [score]"
	return 1


/proc/infect_virus2(var/mob/living/carbon/M, var/datum/disease2/disease/disease, var/forced = 0)
	//world << "Попытка заразить [M.name] вирусом [disease.uniqueID]"
	if(M.virus2)
		//world << "[M.name] уже заражён вирусом"
		return
/*	//immunity
	for(var/iii = 1, iii <= M.immunevirus2.len, iii++)
		if(disease.issame(M.immunevirus2[iii]))
			return
*/
/*	for(var/res in M.resistances)
		if(res == disease.uniqueID))
			return*/
	if(M.resistances2.Find(disease.uniqueID))
		//world << "У [M.name] Найдены антитела против вируса"
		return
	if(forced || prob(disease.infectionchance))
		//world << "У [M.name] Найдены антитела против вируса"
		if(M.virus2)
			return
		else
			// certain clothes can prevent an infection
			var/infch = M.get_infection_chance()
			if(!forced && !infch)
				return

			M.virus2 = disease.getcopy()
			M.virus2.minormutate()
			//world << "[M.name] успешно заражён вирусом [disease.uniqueID]"


/datum/disease2/resistance
	var/list/datum/disease2/effect/resistances = list()

	proc/resistsdisease(var/datum/disease2/disease/virus2)
		var/list/res2 = list()
		for(var/datum/disease2/effect/e in resistances)
			res2 += e.type
		for(var/datum/disease2/effectholder/holder in virus2)
			if(!(holder.effect.type in res2))
				return 0
			else
				res2 -= holder.effect.type
		if(res2.len > 0)
			return 0
		else
			return 1

	New(var/datum/disease2/disease/virus2)
		for(var/datum/disease2/effectholder/h in virus2.effects)
			resistances += h.effect.type


/proc/infect_mob_random(var/mob/living/carbon/M)
	if(!M.virus2)
		M.virus2 = new /datum/disease2/disease
		M.virus2.makerandom()
		M.virus2.infectionchance = 10

/proc/infect_mob_special(var/mob/living/carbon/M, var/virusname = "random")
	if(!M.virus2)
		switch(virusname)
			if("gbs")
				M.virus2 = new /datum/disease2/disease
				M.virus2.makegibber()
			else
				M.virus2 = new /datum/disease2/disease
				M.virus2.makerandom()
				M.virus2.infectionchance = 10
/*
/proc/infect_mob_zombie(var/mob/living/carbon/M)
	if(!M.virus2)
		M.virus2 = new /datum/disease2/disease
		M.virus2.makezombie()
*/
/datum/disease2/disease
	var/infectionchance = 10
	var/speed = 1
	var/spreadtype = "Blood" // Can also be "Airborne"
	var/stage = 1
	var/stageprob = 10
	var/dead = 0
	var/clicks = 0

	var/uniqueID = 0
	var/list/datum/disease2/effectholder/effects = list()

	proc/makespecial(var/type = "random")
		switch(type)
			if("gbs")
				src.makegibber()
			else
				src.makerandom()

//VIRUSTYPES
//ADD YOUR OWN VIRUS TO KILL ALL HUMANS
/*
	proc/makezombie()
		var/datum/disease2/effectholder/holder = new /datum/disease2/effectholder
		holder.stage = 1
		holder.chance = 10
		holder.effect = new/datum/disease2/effect/greater/gunck()
		effects += holder

		holder = new /datum/disease2/effectholder
		holder.stage = 2
		holder.chance = 10
		holder.effect = new/datum/disease2/effect/lesser/hungry()
		effects += holder

		holder = new /datum/disease2/effectholder
		holder.stage = 3
		holder.chance = 10
		holder.effect = new/datum/disease2/effect/lesser/groan()
		effects += holder

		holder = new /datum/disease2/effectholder
		holder.stage = 4
		holder.chance = 10
		holder.effect = new/datum/disease2/effect/zombie()
		effects += holder

		uniqueID = 1220 // all zombie diseases have the same ID
		infectionchance = 0
		spreadtype = "Airborne"
*/
	proc/makegibber()
		var/datum/disease2/effectholder/holder = new /datum/disease2/effectholder
		holder.stage = 1
		holder.chance = 1
		holder.effect = new /datum/disease2/effect/invisible()
		holder.effect.stage = 1									//Here and below, it is not necessary, but with this I feel calmer
		effects += holder

		holder = new /datum/disease2/effectholder
		holder.stage = 2
		holder.chance = 1
		holder.effect = new /datum/disease2/effect/invisible()
		holder.effect.stage = 2
		effects += holder

		holder = new /datum/disease2/effectholder
		holder.stage = 3
		holder.chance = 25
		holder.effect = new /datum/disease2/effect/cough()
		holder.effect.stage = 3
		effects += holder

		holder = new /datum/disease2/effectholder
		holder.stage = 4
		holder.chance = 25
		holder.effect = new /datum/disease2/effect/gibbingtons()
		effects += holder

		uniqueID = 24
		infectionchance = 10
		spreadtype = "Airborne"

	proc/makerandom()
		var/datum/disease2/effectholder/holder = new /datum/disease2/effectholder
		holder.stage = 1
		holder.getrandomeffect()
		effects += holder
		holder = new /datum/disease2/effectholder
		holder.stage = 2
		holder.getrandomeffect()
		effects += holder
		holder = new /datum/disease2/effectholder
		holder.stage = 3
		holder.getrandomeffect()
		effects += holder
		holder = new /datum/disease2/effectholder
		holder.stage = 4
		holder.getrandomeffect()
		effects += holder
		uniqueID = rand(0,9999)
		infectionchance = rand(10,95)
		spreadtype = "Airborne"

//END OF VIRUS DEFINITIONS

	proc/minormutate()
		var/datum/disease2/effectholder/holder = pick(effects)
		holder.minormutate()
		infectionchance = min(100,infectionchance + rand(0,10))
		if(prob(2))
			uniqueID = rand(0,9999)

	proc/issame(var/datum/disease2/disease/disease)
		var/list/types = list()
		var/list/types2 = list()
		for(var/datum/disease2/effectholder/d in effects)
			types += d.effect.type
		var/equal = 1

		for(var/datum/disease2/effectholder/d in disease.effects)
			types2 += d.effect.type

		for(var/type in types)
			if(!(type in types2))
				equal = 0
		return equal

	proc/activate(var/mob/living/carbon/mob)
		if(dead)
			mob.virus2 = null
			return
		if(mob.stat == 2)
			return
		if(mob.radiation > 50)
			if(prob(1))
				majormutate()
		if(mob.reagents.has_reagent("spaceacillin"))
			mob.reagents.remove_reagent("spaceacillin",0.025)
			return
		if(clicks > stage*150 && prob(10-stage + (clicks/50)) && stage != 4)
/*			if(stage == 4)
				var/datum/disease2/resistance/res = new /datum/disease2/resistance(src)
				mob.immunevirus2 += src.getcopy()
				mob.resistances2 += res
				mob.virus2 = null
				del src*/
			stage++
			clicks = 0
		for(var/datum/disease2/effectholder/e in effects)
			e.runeffect(mob,stage)
		clicks+=speed

	proc/cure_added(var/datum/disease2/resistance/res)
		if(res.resistsdisease(src))
			dead = 1

	proc/majormutate()
		if(prob(50))
			uniqueID = rand(0,9999)
		var/datum/disease2/effectholder/holder = pick(effects)
		holder.majormutate()


	proc/getcopy()
//		world << "getting copy"
		var/datum/disease2/disease/disease = new /datum/disease2/disease
		disease.infectionchance = infectionchance
		disease.spreadtype = spreadtype
		disease.stageprob = stageprob
		disease.uniqueID = uniqueID
		for(var/datum/disease2/effectholder/holder in effects)
	//		world << "adding effects"
			var/datum/disease2/effectholder/newholder = new /datum/disease2/effectholder
			newholder.effect = new holder.effect.type
			newholder.chance = holder.chance
			newholder.cure = holder.cure
			newholder.multiplier = holder.multiplier
			newholder.happensonce = holder.happensonce
			newholder.stage = holder.stage
			disease.effects += newholder
	//		world << "[newholder.effect.name]"
	//	world << "[disease]"
		return disease

/datum/disease2/effect
	var/name = "Blanking effect"
	var/stage = 4
	var/maxm = 1
	var/maxc = 85
	proc/activate(var/mob/living/carbon/mob,var/multiplier)
/*
/datum/disease2/effect/zombie
	name = "Tombstone Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			if(!H.zombie)
				H.zombify()
				del H.virus2
*/
/datum/disease2/effect/gibbingtons
	name = "Gibbingtons Syndrome"
	stage = 4
	maxc = 100
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.gib()

/datum/disease2/effect/radian
	name = "Radian's syndrome"
	stage = 4
	maxm = 6
	maxc = 40
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.radiation += (2*multiplier)

/datum/disease2/effect/toxins
	name = "Hyperacid Syndrome"
	stage = 3
	maxm = 8
	maxc = 5
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.toxloss += (2*multiplier)

/datum/disease2/effect/scream
	name = "Random screaming syndrome"
	stage = 2
	maxc = 5
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*scream")

/datum/disease2/effect/drowsness
	name = "Automated sleeping syndrome"
	stage = 2
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.drowsyness += 10

/datum/disease2/effect/shakey
	name = "World Shaking syndrome"
	stage = 3
	maxm = 3
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		shake_camera(mob,5*multiplier)

/datum/disease2/effect/deaf
	name = "Hard of hearing syndrome"
	stage = 4
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.ear_deaf += 20

/datum/disease2/effect/invisible
	name = "Waiting Syndrome"
	stage = 1
	maxc = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		return
/*
/datum/disease2/effect/telepathic
	name = "Telepathy Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.mutations |= 512
*/
/datum/disease2/effect/noface
	name = "Identity Loss syndrome"
	stage = 4
	maxc = 5
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(mob.real_name != "Unknown")
			mob.real_name = "Unknown"

/datum/disease2/effect/monkey
	name = "Monkism syndrome"
	stage = 4
	maxc = 85
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob,/mob/living/carbon/human))
			var/mob/living/carbon/human/h = mob
			h.monkeyize()

/datum/disease2/effect/sneeze
	name = "Coldingtons Effect"
	stage = 1
	maxc = 5
	activate(var/mob/living/carbon/mob,var/multiplier)
		if (mob.bodytemperature > 250)//310 is the normal bodytemp. 310.055
			mob.bodytemperature = max(250, mob.bodytemperature-10)
		mob.say("*sneeze")

/datum/disease2/effect/gunck
	name = "Flemmingtons"
	stage = 1
	maxc = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob << "\red Mucous runs down the back of your throat."

/datum/disease2/effect/killertoxins
	name = "Toxification syndrome"
	stage = 4
	maxc = 60
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.toxloss += 15
/*
/datum/disease2/effect/hallucinations
	name = "Hallucinational Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.hallucination += 25
*/
/datum/disease2/effect/sleepy
	name = "Resting syndrome"
	stage = 2
	maxc = 6
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*collapse")

/datum/disease2/effect/mind
	name = "Lazy mind syndrome"
	stage = 3
	maxc = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(mob.brainloss < 50)
			mob.brainloss = 50
			mob << "\red You feel stupid."

/datum/disease2/effect/suicide
	name = "Suicidal syndrome"
	stage = 4
	maxc = 90
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(ishuman(mob) && !mob.suiciding)
			mob.suiciding = 1
			//instead of killing them instantly, just put them at -175 health and let 'em gasp for a while
			viewers(mob) << "\red <b>[mob.name] is holding \his breath. It looks like \he's trying to commit suicide.</b>"
			mob.oxyloss = max(175 - mob.toxloss - mob.fireloss - mob.bruteloss, mob.oxyloss)
			mob.updatehealth()
			spawn(200) //in case they get revived by cryo chamber or something stupid like that, let them suicide again in 20 seconds
				mob.suiciding = 0

/*
/datum/disease2/effect/lesser/mind
	name = "Lazy mind syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.brainloss = 20
*/
/datum/disease2/effect/drowsy
	name = "Bedroom Syndrome"
	stage = 2
	maxc = 35
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.drowsyness = 5
/*
/datum/disease2/effect/lesser/deaf
	name = "Hard of hearing syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.ear_deaf = 5

/datum/disease2/effect/lesser/gunck
	name = "Flemmingtons"
	stage = 1
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob << "\red Mucous runs down the back of your throat."

/datum/disease2/effect/radian
	name = "Radian's syndrome"
	stage = 4
	maxm = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.radiation += 1

/datum/disease2/effect/sneeze
	name = "Coldingtons Effect"
	stage = 1
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*sneeze")
*/
/datum/disease2/effect/cough
	name = "Anima Syndrome"
	stage = 2
	maxc = 15
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*cough")
/*
/datum/disease2/effect/lesser/hallucinations
	name = "Hallucinational Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.hallucination += 5

/datum/disease2/effect/arm
	name = "Disarming Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		var/datum/organ/external/org = mob.organs["r_arm"]
		org.take_damage(3,0,0,0)
		mob << "\red You feel a sting in your right arm."
*/
/datum/disease2/effect/hungry
	name = "Appetiser Effect"
	stage = 2
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.nutrition = max(0, mob.nutrition - 15)
/*
/datum/disease2/effect/lesser/groan
	name = "Groaning Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*groan")

/datum/disease2/effect/lesser/scream
	name = "Loudness Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*scream")
*/
/datum/disease2/effect/drool
	name = "Saliva Effect"
	stage = 1
	maxc = 7
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*drool")

/datum/disease2/effect/fridge
	name = "Refridgerator Syndrome"
	stage = 2
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		if (mob.bodytemperature > 170)//310 is the normal bodytemp. 310.055
			mob.bodytemperature = max(200, mob.bodytemperature-10)
		mob.say("*shiver")

/datum/disease2/effect/infernal
	name = "Infernal Fever Syndrome"
	stage = 4
	maxc = 25
	activate(var/mob/living/carbon/mob,var/multiplier)
		if (mob.bodytemperature < 10000)//310 is the normal bodytemp. 310.055
			if(mob.bodytemperature < 360)
				mob.bodytemperature = min(3000, mob.bodytemperature+20)
				if(prob(10))
					mob << "\blue You feel a growing warmth inside..."
			else if(mob.bodytemperature < 400)
				mob.bodytemperature = min(3000, mob.bodytemperature+40)
				if(prob(10))
					mob << "\red You should find something to drop heat."
			else if(mob.bodytemperature < 500)
				mob.bodytemperature = min(3000, mob.bodytemperature+70)
				mob.take_overall_damage(0,2)
				if(prob(10))
					mob << "\red You feel pain."
					mob.say("*scream")
			else
				mob.bodytemperature = min(10000, mob.bodytemperature+100)
				mob << "\red You burns from the inside and fall down in pain."
				mob.say("*scream")
				mob.say("*collapse")
				mob.take_overall_damage(0,40)
		else
			mob.say("*scream")

/datum/disease2/effect/twitch
	name = "Twitcher"
	stage = 1
	maxc = 5
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*twitch")
/*
/datum/disease2/effect/lesser/deathgasp
	name = "Zombie Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*deathgasp")

/datum/disease2/effect/lesser/giggle
	name = "Uncontrolled Laughter Effect"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*giggle")


/datum/disease2/effect/lesser
	chance_maxm = 10
*/
/datum/disease2/effectholder
	var/name = "Holder"
	var/datum/disease2/effect/effect
	var/chance = 0 //Chance in percentage each tick
	var/cure = "" //Type of cure it requires
	var/happensonce = 0
	var/multiplier = 1 //The chance the effects are WORSE
	var/stage = 0

	proc/runeffect(var/mob/living/carbon/human/mob,var/stage)
		if(happensonce > -1 && effect.stage <= stage && prob(chance))
			effect.activate(mob)
			if(happensonce == 1)
				happensonce = -1

	proc/getrandomeffect()
		var/list/datum/disease2/effect/list = list()
		for(var/e in (typesof(/datum/disease2/effect) - /datum/disease2/effect))
		//	world << "Making [e]"
			var/datum/disease2/effect/f = new e
			if(f.stage == src.stage)
				list += f
		effect = pick(list)
		chance = rand(1, effect.maxc)

	proc/minormutate()
		switch(pick(1,2,3,4,5))
			if(1)
				chance = rand(0, effect.maxc)
			if(2)
				multiplier = rand(1, effect.maxm)

	proc/majormutate()
		getrandomeffect()

/proc/dprob(var/p)
	return(prob(sqrt(p)) && prob(sqrt(p)))