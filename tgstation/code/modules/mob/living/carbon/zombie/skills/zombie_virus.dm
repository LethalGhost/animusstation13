/datum/disease/zombie_transformation
	name = "Zombie virus"
	max_stages = 5
	spread = "Syringe"
	spread_type = SPECIAL
	cure = "Unclown"
	cure_id = list("alkysine")
	cure_chance = 9
	curable = 0
	stage_prob = 4
	agent = "necromicrobes"
	affected_species = list("Human")

/datum/disease/zombie_transformation/stage_act()
	..()
	switch(stage)
		if(2)
			if (prob(4))
				affected_mob << "\red You feel a stabbing pain in your head."
				affected_mob.paralysis += 2
		if(3)
			if (prob(8))
				affected_mob.say(pick("Brains...", "I love brains..."))
			if (prob(4))
				affected_mob << "\red You feel a stabbing pain in your head."
				affected_mob.paralysis += 2
		if(4)
			affected_mob.weakened = max(affected_mob:weakened, 10)
			stage_prob = 8
		if(5)
			src.cure(0)
			affected_mob:zombieze()