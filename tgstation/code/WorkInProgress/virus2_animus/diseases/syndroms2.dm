/*
A TEMPLATE FOR A NEW SYNDROME
/datum/disease2/effect/<unic name for syndrome>
	name = "<InGame name of effect>"
	stage = 2						//Stage of the disease for which this effect is made (Possible:1,2,3,4) (This file only for stage 2 syndromes)
	maxc = <Num from 1 to 100>		//Max chance to proc the effect of each tick
	maxm = <Num from 1 to ...>		//Max multipler for effect.The multiplier is used to enhance the effect, if indicated in the code of this effect.
	activate(var/mob/living/carbon/mob,var/multiplier)		//Proc for activated syndrome
		<your code for syndrome>

*/

/datum/disease2/effect/scream
	name = "Random screaming syndrome"
	stage = 2
	maxc = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*scream")

/datum/disease2/effect/drowsness
	name = "Automated sleeping syndrome"
	stage = 2
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.drowsyness += 10

/datum/disease2/effect/sleepy
	name = "Resting syndrome"
	stage = 2
	maxc = 6
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*collapse")

/datum/disease2/effect/drowsy
	name = "Bedroom Syndrome"
	stage = 2
	maxc = 20
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.drowsyness = 5

/datum/disease2/effect/cough
	name = "Anima Syndrome"
	stage = 2
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*cough")

/datum/disease2/effect/hungry
	name = "Appetiser Effect"
	stage = 2
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.nutrition = max(0, mob.nutrition - 15)

/datum/disease2/effect/fridge
	name = "Refridgerator Syndrome"
	stage = 2
	maxc = 30
	activate(var/mob/living/carbon/mob,var/multiplier)
		if (mob.bodytemperature > 170)//310 is the normal bodytemp. 310.055
			mob.bodytemperature = max(200, mob.bodytemperature-10)
		if(prob(15))
			mob.say("*shiver")


//Part from BAY12Station which don't work with /tg/
//
/*
/datum/disease2/effect/lesser/deathgasp
	name = "Zombie Syndrome"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*deathgasp")

*/