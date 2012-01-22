/obj/effect/critter/creature
	name = "creature"
	desc = "A sanity-destroying otherthing."
	icon = 'otherthing.dmi'
	icon_state = "otherthing"
	health = 80
	max_health = 80
	aggressive = 1
	defensive = 1
	wanderer = 1
	opensdoors = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	atksame = 1
	firevuln = 1
	brutevuln = 1
	melee_damage_lower = 25
	melee_damage_upper = 50
	angertext = "runs"
	attacktext = "chomps"
	attack_sound = 'bite.ogg'


/obj/effect/critter/roach
	name = "cockroach"
	desc = "An unpleasant insect that lives in filthy places."
	icon_state = "roach"
	health = 5
	max_health = 5
	aggressive = 0
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 0
	attacktext = "bites"

	Die()
		..()
		new /obj/effect/decal/cleanable/xenoblood/xsplatter(get_turf(src))
		del(src)

/obj/effect/critter/roach/agressive
	name = "mutated cockroach"
	desc = "An unpleasant insect that lives in filthy places. This one looks aggressive."
	icon_state = "roach"
	health = 8
	max_health = 8
	aggressive = 1
	defensive = 1
	wanderer = 1
	firevuln = 2
	melee_damage_lower = 1
	melee_damage_upper = 5
	attacktext = "bites"

/obj/effect/critter/killertomato
	name = "killer tomato"
	desc = "Oh shit, you're really fucked now."
	icon_state = "killertomato"
	health = 15
	max_health = 15
	aggressive = 1
	defensive = 0
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	firevuln = 2
	brutevuln = 2


	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new /obj/item/weapon/reagent_containers/food/snacks/tomatomeat(src)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new /obj/item/weapon/reagent_containers/food/snacks/tomatomeat(src)
				new /obj/item/weapon/reagent_containers/food/snacks/tomatomeat(src)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0



/obj/effect/critter/spore
	name = "plasma spore"
	desc = "A barely intelligent colony of organisms. Very volatile."
	icon_state = "spore"
	density = 1
	health = 1
	max_health = 1
	aggressive = 0
	defensive = 0
	wanderer = 1
	atkcarbon = 0
	atksilicon = 0
	firevuln = 2
	brutevuln = 2


	Die()
		src.visible_message("<b>[src]</b> ruptures and explodes!")
		src.alive = 0
		var/turf/T = get_turf(src.loc)
		if(T)
			T.hotspot_expose(700,125)
			explosion(T, -1, -1, 2, 3)
		del src


	ex_act(severity)
		src.Die()


/obj/effect/critter/blob
	name = "blob"
	desc = "Some blob thing."
	icon_state = "blob"
	pass_flags = PASSBLOB
	health = 20
	max_health = 20
	aggressive = 1
	defensive = 0
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	firevuln = 2
	brutevuln = 0.5
	melee_damage_lower = 2
	melee_damage_upper = 8
	angertext = "charges"
	attacktext = "hits"
	attack_sound = 'genhit1.ogg'

	Die()
		..()
		del(src)



/obj/effect/critter/spesscarp
	name = "Spess Carp"
	desc = "A ferocious, fang-bearing creature that resembles a fish."
	icon_state = "spesscarp"
	health = 25
	max_health = 25
	aggressive = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	firevuln = 2
	brutevuln = 1
	melee_damage_lower = 5
	melee_damage_upper = 15
	angertext = "lunges"
	attacktext = "bites"
	attack_sound = 'bite.ogg'
	attack_speed = 10
	var/stunchance = 10 // chance to tackle things down



	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0

	AfterAttack(var/mob/living/target)
		if(prob(stunchance))
			if(target.weakened <= 0)
				target.Weaken(rand(10, 15))
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <B>[src]</B> knocks down [target]!", 1)
				playsound(loc, 'pierce.ogg', 25, 1, -1)



/obj/effect/critter/spesscarp/elite
	desc = "Oh shit, you're really fucked now. It has an evil gleam in its eye."
	health = 50
	max_health = 50
	melee_damage_lower = 20
	melee_damage_upper = 35
	stunchance = 15
	attack_speed = 7
//	opensdoors = 1 would give all access dono if want



/obj/effect/critter/walkingmushroom
	name = "Walking Mushroom"
	desc = "A...huge...mushroom...with legs!?"
	icon_state = "walkingmushroom"
	health = 15
	max_health = 15
	aggressive = 0
	defensive = 0
	wanderer = 1
	atkcarbon = 0
	atksilicon = 0
	firevuln = 2
	brutevuln = 1


	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new /obj/item/weapon/reagent_containers/food/snacks/hugemushroomslice(src.loc)
				new /obj/item/weapon/reagent_containers/food/snacks/hugemushroomslice(src.loc)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new /obj/item/weapon/reagent_containers/food/snacks/hugemushroomslice(src.loc)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0



/obj/effect/critter/lizard
	name = "Lizard"
	desc = "A cute tiny lizard."
	icon_state = "lizard"
	health = 5
	max_health = 5
	aggressive = 0
	defensive = 1
	wanderer = 1
	opensdoors = 0
	atkcarbon = 1
	atksilicon = 1
	attacktext = "bites"



// We can maybe make these controllable via some console or something
/obj/effect/critter/manhack
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon_state = "viscerator"
	pass_flags = PASSTABLE
	health = 15
	max_health = 15
	aggressive = 1
	opensdoors = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkmech = 1
	firevuln = 0 // immune to fire
	brutevuln = 1
	ventcrawl = 1
	friend = null  //its may make for robotist, example, or syndies
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "cuts"
	attack_sound = 'bladeslice.ogg'
	chasestate = "viscerator_attack"
	deathtext = "is smashed into pieces!"

	Die()
		..()
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <b>[src]</b> is smashed into pieces!", 1)
		del(src)

		//catratcat
/obj/effect/critter/danghost
	name = "Dangerous Ghost"
	desc = "A ferocious, horrible creature that was a man or him soul."
	icon_state = "danghost"
	health = 200
	max_health = 200
	aggressive = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 0
	atkcritter = 0
	atkmech = 0
	firevuln = 0
	brutevuln = 1
	opensdoors = 1
	ventcrawl = 1
	friend = null //for evil necromanth, maybe
	melee_damage_lower = 10
	melee_damage_upper = 20
	angertext = "rushes"
	attacktext = "absorbs"
	attack_sound = 'bite.ogg'
	attack_speed = 5
	var/stunchance = 10 // chance to tackle things down

/obj/effect/critter/swarm
	name = "Swarm"
	desc = "Pack of horrible bugs"
	icon_state = "swarm"
	health = 50 //so many bugs
	max_health = 50
	aggressive = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	ventcrawl = 1
	firevuln = 5  //Oh, burns
	brutevuln = 1
	friend = null //for evil supernatural, maybe
	melee_damage_lower = 5
	melee_damage_upper = 15
	angertext = "rushes"
	attacktext = "bites"
	attack_sound = 'bite.ogg'
	attack_speed = 1
	var/stunchance = 10 // chance to tackle things down

/obj/effect/critter/undead
	name = "undead"
	desc = "Dead man"
	icon_state = "undead"
	health = 200
	max_health = 200
	aggressive = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	firevuln = 1
	brutevuln = 1
	friend = null //for evil necromanth, maybe
	melee_damage_lower = 5
	melee_damage_upper = 15
	angertext = "charges"
	attacktext = "bites"
	attack_sound = 'bite.ogg'
	attack_speed = 1
	var/stunchance = 5 // chance to tackle things down