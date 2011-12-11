/*
Premaded diseases
*/
/datum/disease2/disease

//IF YOU MADE NEW VIRUS, DON'T FORGET TO PLACE IT HERE
//THIS PROC USED BY ADMIN-ACTIVATED "Virual Outbreak" EVENT
	proc/makespecial(var/type = "random")
		switch(type)
			if("gbs")
				src.makegibber()
			else
				src.makerandom()

//GBS
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
		holder.chance = 10
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

//Part from BAY12Station which don't work with /tg/
//
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