/*
A TEMPLATE FOR A NEW SYNDROME
/datum/disease2/effect/<unic name for syndrome>
	name = "<InGame name of effect>"
	stage = 1						//Stage of the disease for which this effect is made (Possible:1,2,3,4) (This file only for stage 1 syndromes)
	maxc = <Num from 1 to 100>		//Max chance to proc the effect of each tick
	maxm = <Num from 1 to ...>		//Max multipler for effect.The multiplier is used to enhance the effect, if indicated in the code of this effect.
	activate(var/mob/living/carbon/mob,var/multiplier)		//Proc for activated syndrome
		<your code for syndrome>

*/

/datum/disease2/effect/invisible
	name = "Waiting Syndrome"
	stage = 1
	possible_stages = list(1,2,3)
	maxc = 2

	activate(var/mob/living/carbon/mob,var/multiplier)
		return

/datum/disease2/effect/sneeze
	name = "Coldingtons Effect"
	stage = 1
	possible_stages = list(1,2)
	maxc = 5

	activate(var/mob/living/carbon/mob,var/multiplier)
		if (mob.bodytemperature > 250)//310 is the normal bodytemp. 310.055
			mob.bodytemperature = max(250, mob.bodytemperature-10)
		mob.say("*sneeze")

/datum/disease2/effect/gunck
	name = "Flemmingtons"
	stage = 1
	possible_stages = list(1,2)
	maxc = 2

	activate(var/mob/living/carbon/mob,var/multiplier)
		mob << "\red Mucous runs down the back of your throat."

/datum/disease2/effect/drool
	name = "Saliva Effect"
	stage = 1
	possible_stages = list(1,2)
	maxc = 4

	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*drool")

/datum/disease2/effect/twitch
	name = "Twitcher"
	stage = 1
	possible_stages = list(1,2)
	maxc = 5

	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*twitch")

/datum/disease2/effect/giggle
	name = "Uncontrolled Laughter Effect"
	stage = 1
	possible_stages = list(1,2)
	maxc = 6

	activate(var/mob/living/carbon/mob,var/multiplier)
		if(prob(50))
			mob.say("*giggle")
		else if(prob(50))
			mob << "\red You feel a little silly."

/datum/disease2/effect/asneeze		//by catratcat
	name = "Advanced Coldingtons Effect"
	stage = 1
	possible_stages = list(1,2)
	maxc = 4

	activate(var/mob/living/carbon/mob,var/multiplier)
		if(mob.bodytemperature > 200)
			mob.bodytemperature = max(200, mob.bodytemperature-rand(1,20))
		if(prob(10))
			if(prob(50))
				mob.say("*shiver")
			else
				mob.say("*sneeze")

//Part from BAY12Station which don't work with /tg/
//
/*

*/