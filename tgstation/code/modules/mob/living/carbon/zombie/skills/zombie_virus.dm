/datum/disease/zombie_transformation
	name = "Zombie transformation"
	max_stages = 5
	spread = "Syringe"
	spread_type = SPECIAL
	cure = "Spaceacillin"
	cure_id = list("spaceacillin")
	cure_chance = 5
	agent = "necromicrobes"
	affected_species = list("Human")

/datum/disease/zombie_transformation/stage_act()
	..()
	switch(stage)
		/*if(2)
			if (prob(2))
				src.cure(0)
				world << "[affected_mob] cured!"*/
		if(3)
			if (prob(4))
				affected_mob << "\red You feel a stabbing pain in your head."
				affected_mob.paralysis += 2
		if(4)
			if (prob(20))
				affected_mob.say(pick("Brains...", "I love brains..."))
		if(5)
			affected_mob.weakened = max(affected_mob:weakened, 10)
			if(prob(20))
				src.cure(0)
				affected_mob:zombieze()