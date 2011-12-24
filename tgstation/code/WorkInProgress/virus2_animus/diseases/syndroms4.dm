/*
A TEMPLATE FOR A NEW SYNDROME
/datum/disease2/effect/<unic name for syndrome>
	name = "<InGame name of effect>"
	stage = 4						//Stage of the disease for which this effect is made (Possible:1,2,3,4) (This file only for stage 4 syndromes)
	maxc = <Num from 1 to 100>		//Max chance to proc the effect of each tick
	maxm = <Num from 1 to ...>		//Max multipler for effect.The multiplier is used to enhance the effect, if indicated in the code of this effect.
	activate(var/mob/living/carbon/mob,var/multiplier)		//Proc for activated syndrome
		<your code for syndrome>

*/

/datum/disease2/effect/gibbingtons
	name = "Gibbingtons Syndrome"
	stage = 4
	possible_stages = list(4,5)
	maxc = 20

	activate(var/mob/living/carbon/mob,var/multiplier)
		if(prob(50))
			mob << "\red Your body feels as if it's trying to rip itself open..."
		if(prob(50))
			spawn(20) mob.gib()

/datum/disease2/effect/radian
	name = "Radian's syndrome"
	stage = 4
	possible_stages = list(4,5)
	maxm = 6
	maxc = 20

	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.radiation += (2*multiplier)

/datum/disease2/effect/deaf4
	name = "Hard of hearing syndrome"
	stage = 4
	possible_stages = list(4,5)
	maxc = 5

	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.ear_deaf += 20

/datum/disease2/effect/noface
	name = "Identity Loss syndrome"
	stage = 4
	possible_stages = list(4,5)
	maxc = 5

	activate(var/mob/living/carbon/mob,var/multiplier)
		if(mob.real_name != "Unknown")
			mob.real_name = "Unknown"

/datum/disease2/effect/monkey
	name = "Monkism syndrome"
	stage = 4
	possible_stages = list(4,5)
	maxc = 85

	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob,/mob/living/carbon/human))
			var/mob/living/carbon/human/h = mob
			h.monkeyize()

/datum/disease2/effect/killertoxins
	name = "Toxification syndrome"
	stage = 4
	possible_stages = list(4,5)
	maxc = 60

	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.toxloss += 15

/datum/disease2/effect/suicide
	name = "Suicidal syndrome"
	stage = 4
	possible_stages = list(4,5)
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

/datum/disease2/effect/infernal
	name = "Infernal Fever Syndrome"
	stage = 4
	possible_stages = list(4,5)
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

/datum/disease2/effect/brainrot4
	name = "Lazy Mind Syndrome"
	stage = 4
	possible_stages = list(4,5)
	maxc = 50

	activate(var/mob/living/carbon/mob,var/multiplier)
		if(prob(2))
			mob.emote("stare")
		if(prob(2))
			mob.emote("drool")
		if(prob(4) && mob.brainloss<=98)
			mob.brainloss +=3
			mob.updatehealth()
			if(prob(10))
				mob << "\red Strange buzzing fills your head, removing all thoughts."
		if(prob(4))
			mob << "\red You lose consciousness..."
			for(var/mob/O in viewers(mob, null))
				O.show_message("[mob] suddenly collapses", 1)
			mob.paralysis = rand(5,10)
			if(prob(10))
				mob.emote("snore")
		if(prob(4))
			mob.stuttering += 3

/datum/disease2/effect/rotflesh		//Invented by catratcat.Noticeably reworked by mik
	name = "Syndrome of Rotting Flesh"
	stage = 4
	possible_stages = list(4,5)
	maxc = 10
	act_when_dead = 1

	activate(var/mob/living/carbon/mob,var/multiplier)
		if(mob.real_name != "Unknown")
			mob << "\red The flesh on your face is rotting, and it turns into an unintelligible mess."
			mob.real_name = "Unknown"
		mob.nutrition = max(0, mob.nutrition - 15)
		if(mob.nutrition < 300 && prob(10))
			mob << "\red One of the festering on your body bursts and releases a cloud of smelly gas."
			new /obj/effect/effect/mustard_gas(get_turf(mob))
		else if(mob.nutrition < 200 && prob(20))
			mob.say("*scream")
			mob << "\red One of the major festering in your body burst and let out a few cockroaches."
			new /obj/effect/decal/cleanable/blood/splatter(get_turf(mob))
			new /obj/effect/critter/roach/agressive(get_turf(mob))
			new /obj/effect/critter/roach/agressive(get_turf(mob))
			new /obj/effect/critter/roach/agressive(get_turf(mob))

/datum/disease2/effect/pierrot
	name = "Pierrot Throat"
	stage = 4
	possible_stages = list(2,3,4)
	maxc = 10

	activate(var/mob/living/carbon/mob,var/multiplier)
		if(mob.virus2.say_tag != "pierrot")
			mob.virus2.say_tag = "pierrot"
		if(prob(10 * stage))
			mob.say("KOKOKO!")
		else if(prob(15 * stage))
			mob.say("KBOX! KBOX")
		else if(prob(20 * stage))
			mob.say("KYDAX!")

//Part from BAY12Station which don't work with /tg/
//
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