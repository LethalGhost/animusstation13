//To simplify, all diseases have 2-5 stages, with effects starting at stage 2
//Stage 1 = Rest,Minor disease
//Stage 2 = Minimal effect or 1
//Stage 3 = Medium effect or 2
//Stage 4 = Death/Really Really really bad effect or 3
//Stage 5 = Death/Really Really really bad effect


/obj/virus
	// a virus instance that is placed on the map, moves, and infects
	invisibility = 100

	var/datum/disease2/disease/disease

	New()
		..()
		step_rand(src)
		step_rand(src)
		step_rand(src)
		anchored = 1
		spawn(300) del(src)


/mob/living/carbon/proc/get_infection_chance()
	var/score = 0
	var/cloth_armor = 0
	var/mob/living/carbon/M = src
	var/obj/item/clothing/cloth = null
	if(istype(M, /mob/living/carbon/human))
		if(M:gloves)
//			cloth = M:gloves
//			cloth_armor = cloth.armor["bio"]
			//world << "Защита перчаток = [cloth_armor]"
			score += 100
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

	if(M.resistances2.Find(disease.uniqueID))
		//world << "У [M.name] Найдены антитела против вируса"
		return
	if(forced || prob(disease.infectionchance))
		//world << "У [M.name] нет антител против вируса"
		if(M.virus2)
			return
		else
			// certain clothes can prevent an infection
			var/infch = M.get_infection_chance()
			if(!forced && !infch)
				//world << "Одежда [M.name] защитила его от заражения"
				return

			M.virus2 = disease.getcopy()
			M.virus2.minormutate()
			//world << "[M.name] успешно заражён вирусом [disease.uniqueID]"

proc/choose_random_virus(var/stage = 0)
	var/list/datum/disease2/effect/list = list()
	var/datum/disease2/effect/effect = null
	for(var/e in (typesof(/datum/disease2/effect) - /datum/disease2/effect))
	//	world << "Making [e]"
		var/datum/disease2/effect/f = new e
		if((stage == 0) || f.possible_stages.Find(stage))
			list += f
	effect = pick(list)
	return effect

proc/getrandomeffect(var/stage)
	var/datum/disease2/effect/effect = choose_random_virus(stage)
	effect.stage = stage
	effect.multiplier = rand(1,effect.maxm)
	effect.chance = rand(1,effect.maxc)
	return effect

/datum/disease2/disease
	var/infectionchance = 1
	var/maxstage = 4
	var/speed = 1
	var/spreadtype = "Blood" // Can also be "Airborne"
	var/say_tag = ""
	var/stage = 1
	var/stageprob = 10
	var/dead = 0
	var/clicks = 0
	var/uniqueID = 0
	var/list/datum/disease2/effect/effects = list()


	proc/makerandom()
		var/max_stage = rand(2,5)
		maxstage = max_stage
//		world << "maxstage = [maxstage];"

		var/i=1
		for(i=1, i<=max_stage, i++)
//			world << "i = [i];"
			effects += getrandomeffect(i)

		uniqueID = rand(0,9999)
//		world << "ID = [uniqueID];"
		infectionchance = rand(1,5)
		spreadtype = "Airborne"


	proc/minormutate()
		var/datum/disease2/effect/effect = pick(effects)
		effect.minormutate()
		infectionchance = min(100,infectionchance + rand(0,4))
		if(prob(1))
			uniqueID = rand(0,9999)


	proc/majormutate()
		if(prob(10))
			uniqueID = rand(0,9999)
		if(prob(20))
			var/i = rand(1,maxstage)

			for(var/datum/disease2/effect/d in effects)
				if(d.stage == i)
					effects -= d
					break

			effects += getrandomeffect(i)


	proc/activate(var/mob/living/carbon/mob)
		if(dead)
			mob.virus2 = null
			if(!mob.resistances2.Find(src.uniqueID))
				mob.resistances2 += src.uniqueID
			return
//		if(mob.stat == 2)	//replaced by act_when_dead
//			return
		if(mob.radiation > 50 && mob.stat != 2)
			if(prob(2))
				majormutate()
		if(mob.reagents.has_reagent("spaceacillin"))
			return
		if(clicks > (100 + (stage * 50)) && prob(10-stage + (clicks/50)) && stage != maxstage)
			stage++
			clicks = 0
		for(var/datum/disease2/effect/e in effects)
			if(e.stage == stage)
				if(prob(e.chance) && (e.happensonce > -1) && ((mob.stat != 2) || e.act_when_dead))
					e.activate(mob,e.multiplier)
					if(e.happensonce == 1)
						e.happensonce = -1
				if(mob.reagents.has_reagent(e.cure))
					clicks -= 16
					if(clicks <= 0)
						if(stage <= 1)
							src.dead = 1
						else
							stage -= 1
						clicks = 0
				if(mob.reagents.has_reagent(e.booster))
					clicks += 15
				break
		clicks+=speed

	proc/getcopy()
		var/datum/disease2/disease/disease = new /datum/disease2/disease
		disease.infectionchance = infectionchance
		disease.spreadtype = spreadtype
		disease.stageprob = stageprob
		disease.uniqueID = uniqueID
		disease.maxstage = maxstage
		disease.speed = speed
		for(var/datum/disease2/effect/effect in effects)
			disease.effects += effect.getcopy()
		return disease

/datum/disease2/effect
	var/name = "Blanking effect"
	var/cure = ""		//Cure which effective when this effect is active
	var/booster = ""	//Booster, which help disease to get highter stages
	var/stage = 1	//Stage of disease at which this effect is activated
	var/list/possible_stages = list(1,2)	//steges, aviable for this effect
	var/maxm = 1	//max multiplier
	var/multiplier = 1	//determines the ferocity of some effects
	var/maxc = 10	//max chance
	var/chance = 7	//chance of activation
	var/act_when_dead = 0 //if 1 then active even if carrier is dead
	var/happensonce = 0 //1 - happens only once, -1 - already happend, 0 - happens infinitely

	proc/activate(var/mob/living/carbon/mob,var/multiplier)

	proc/minormutate()
		switch(pick(1,2,3,4,5))
			if(1)
				chance = rand(0, maxc)
			if(2)
				multiplier = rand(1, maxm)

	proc/getcopy()
		var/datum/disease2/effect/new_effect = null
		new_effect = new src.type
		new_effect.chance = src.chance
		new_effect.multiplier = src.multiplier
		new_effect.stage = src.stage
		return new_effect

/proc/dprob(var/p)
	return(prob(sqrt(p)) && prob(sqrt(p)))