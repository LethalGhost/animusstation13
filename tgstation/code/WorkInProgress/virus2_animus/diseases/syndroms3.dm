/*
A TEMPLATE FOR A NEW SYNDROME
/datum/disease2/effect/<unic name for syndrome>
	name = "<InGame name of effect>"
	stage = 3						//Stage of the disease for which this effect is made (Possible:1,2,3,4) (This file only for stage 3 syndromes)
	maxc = <Num from 1 to 100>		//Max chance to proc the effect of each tick
	maxm = <Num from 1 to ...>		//Max multipler for effect.The multiplier is used to enhance the effect, if indicated in the code of this effect.
	activate(var/mob/living/carbon/mob,var/multiplier)		//Proc for activated syndrome
		<your code for syndrome>

*/

/datum/disease2/effect/toxins
	name = "Hyperacid Syndrome"
	stage = 3
	maxm = 8
	maxc = 5
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.toxloss += (2*multiplier)

/datum/disease2/effect/shakey
	name = "World Shaking syndrome"
	stage = 3
	maxm = 3
	maxc = 10
	activate(var/mob/living/carbon/mob,var/multiplier)
		shake_camera(mob,5*multiplier)

/datum/disease2/effect/mind
	name = "Lazy mind syndrome"
	stage = 3
	maxc = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(mob.brainloss < 50)
			mob.brainloss = 50
			mob << "\red You feel stupid."

/datum/disease2/effect/deaf3
	name = "Hard of hearing syndrome"
	stage = 3
	maxc = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.ear_deaf = 5


//Part from BAY12Station which don't work with /tg/
//
/*
/datum/disease2/effect/arm
	name = "Disarming Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		var/datum/organ/external/org = mob.organs["r_arm"]
		org.take_damage(3,0,0,0)
		mob << "\red You feel a sting in your right arm."

/datum/disease2/effect/telepathic
	name = "Telepathy Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.mutations |= 512

/datum/disease2/effect/hallucinations
	name = "Hallucinational Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.hallucination += 25

*/