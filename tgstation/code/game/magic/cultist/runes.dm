var/list/sacrificed = list()
var/list/manifested = list()
var/list/holding = list()
/obj/rune
	proc
		teleport(var/key)
			var/mob/living/user = usr
			var/list/runesloc = list()
			var/index = 0
			for(var/obj/rune/R in world)
				if(R == src)
					continue
				if(R.runetype == "teleport" && R.word3 == key)
					index++
					runesloc.len = index
					runesloc[index] = R.loc
			if(index >= 5)
				user << "\red You feel pain, as rune disappears in reality shift caused by too much wear of space-time fabric"
				if (istype(user, /mob/living))
					user.take_overall_damage(5, 0)
				del(src)
			if(runesloc && index != 0)
				if(istype(src,/obj/rune))
					user.say("Sas'so c'arta forbici!")
				else
					user.whisper("Sas'so c'arta forbici!")
				user.visible_message("\red [user] disappears in a flash of red light!", \
				"\red You feel as your body gets dragged through the dimension of Nar-Sie!", \
				"\red You hear a sickening crunch and sloshing of viscera.")
				user.loc = runesloc[rand(1,index)]
				return
			if(istype(src,/obj/rune))
				return	fizzle()
			else
				call(/obj/rune/proc/fizzle)()
				return

		gate(var/key)
			var/culcount = 0
			var/runecount = 0
			var/obj/rune/IP = null
			var/mob/living/user = usr
			for(var/obj/rune/R in world)
				if(R == src)
					continue
				if(R.word1 == wordtravel && R.word2 == wordother && R.word3 == key)
					IP = R
					runecount++
			if(runecount >= 2)
				user << "\red You feel pain, as rune disappears in reality shift caused by too much wear of space-time fabric"
				if (istype(user, /mob/living))
					user.take_overall_damage(5, 0)
				del(src)
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C))
					culcount++
			if(culcount>=3)
				user.say("Sas'so c'arta forbici tarem!")
				user.visible_message("\red You feel air moving from the rune - like as it was swapped with somewhere else.", \
				"\red You feel air moving from the rune - like as it was swapped with somewhere else.", \
				"\red You smell ozone.")
				for(var/obj/O in src.loc)
					if(!O.anchored)
						O.loc = IP.loc
				for(var/mob/M in src.loc)
					M.loc = IP.loc
				return

			return fizzle()

		tome()
			if(istype(src,/obj/rune))
				usr.say("N'ath reth sh'yro eth d'raggathnor!")
			else
				usr.whisper("N'ath reth sh'yro eth d'raggathnor!")
			usr.visible_message("\red Rune disappears with a flash of red light, and in it's place now a book lies.", \
			"\red You are blinded by the flash of red light! After you're able to see again, you see that now instead of the rune there's a book.", \
			"\red You hear a pop and smell ozone.")
			if(istype(src,/obj/rune))
				new /obj/item/weapon/tome(src.loc)
			else
				new /obj/item/weapon/tome(usr.loc)
			del(src)
			return

		convert()
			for(var/mob/living/carbon/M in src.loc)
				if(iscultist(M))
					continue
				if(M.stat==2)
					continue
				usr.say("Mah'weyh pleggh at e'ntrath!")
				M.visible_message("\red [M] writhes in pain as the markings below him glow a bloody red.", \
				"\red AAAAAAHHHH!.", \
				"\red You hear an anguished scream.")
				if(is_convertable_to_cult(M.mind))
					ticker.mode.add_cultist(M.mind)
					M << "<font color=\"purple\"><b><i>Your blood pulses. Your head throbs. The world goes red. All at once you are aware of a horrible, horrible truth. The veil of reality has been ripped away and in the festering wound left behind something sinister takes root.</b></i></font>"
					M << "<font color=\"purple\"><b><i>Assist your new compatriots in their dark dealings. Their goal is yours, and yours is theirs. You serve the Dark One above all else. Bring It back.</b></i></font>"
					return 1
				else
					M << "<font color=\"purple\"><b><i>Your blood pulses. Your head throbs. The world goes red. All at once you are aware of a horrible, horrible truth. The veil of reality has been ripped away and in the festering wound left behind something sinister takes root.</b></i></font>"
					M << "<font color=\"red\"><b>And not a single fuck was given, exterminate the cult at all costs.</b></font>"
					return 0

			return fizzle()

		terror()
			var/cultist_count = 0
			for(var/mob/M in range(1,src))
				if(iscultist(M))
					M.say("Tok-lyr rqa'nap g'lt-ulotf!")
					cultist_count += 1
			if(cultist_count >= 9)
				new /obj/machinery/singularity/narsie(src.loc)
				if(ticker.mode.name == "cult")
					ticker.mode:eldergod = 0
				return
			else
				return fizzle()

		emp(var/U,var/range_red) //range_red - var which determines by which number to reduce the default emp range, U is the source loc, needed because of talisman emps which are held in hand at the moment of using and that apparently messes things up -- Urist
			if(istype(src,/obj/rune))
				usr.say("Ta'gh fara'qha fel d'amar det!")
			else
				usr.whisper("Ta'gh fara'qha fel d'amar det!")
			playsound(U, 'Welder2.ogg', 25, 1)
			var/turf/T = get_turf(U)
			if(T)
				T.hotspot_expose(700,125)
			var/rune = src
			empulse(U, (range_red - 2), range_red)
			del(rune)
			return

		drain()
			var/drain = 0
			for(var/obj/rune/R in world)
				if(R.word1==wordtravel && R.word2==wordblood && R.word3==wordself)
					for(var/mob/living/carbon/D in R.loc)
						if(D.stat!=2)
							var/bdrain = rand(1,25)
							D << "\red You feel weakened."
							D.take_overall_damage(bdrain, 0)
							drain += bdrain
			if(!drain)
				return fizzle()
			usr.say ("Yu'gular faras desdae. Havas mithum javara. Umathar uf'kal thenar!")
			usr.visible_message("\red Blood flows from the rune into [usr]!", \
			"\red The blood starts flowing from the rune and into your frail mortal body. You feel... empowered.", \
			"\red You hear a liquid flowing.")
			var/mob/living/user = usr
			if(user.bhunger)
				user.bhunger = max(user.bhunger-2*drain,0)
			if(drain>=50)
				user.visible_message("\red [user]'s eyes give off eerie red glow!", \
				"\red ...but it wasn't nearly enough. You crave, crave for more. The hunger consumes you from within.", \
				"\red You hear a heartbeat.")
				user.bhunger += drain
				src = user
				spawn()
					for (,user.bhunger>0,user.bhunger--)
						sleep(50)
						user.take_overall_damage(3, 0)
				return
			user.heal_organ_damage(drain%5, 0)
			drain-=drain%5
			for (,drain>0,drain-=5)
				sleep(2)
				user.heal_organ_damage(5, 0)
			return

		truesight()
			if(usr.loc==src.loc)
				usr.say("Rash'tla sektath mal'zua. Zasan therium vivira. Itonis al'ra matum!")
				if(usr.see_invisible!=0 && usr.see_invisible!=15)
					usr << "\red The world beyond flashes your eyes but disappears quickly, as if something is disrupting your vision."
				else
					usr << "\red The world beyond opens to your eyes."
				usr.see_invisible = 15
				usr.seer = 1
				return
			return fizzle()

		raise()
			var/mob/living/carbon/human/corpse_to_raise
			var/mob/living/carbon/human/body_to_sacrifice
			var/mob/living/carbon/human/ghost
			var/unsuitable_corpse_found = 0
			var/corpse_is_target = 0
			for(var/mob/living/carbon/human/M in src.loc)
				if (M.stat>=2)
					if (M.key)
						unsuitable_corpse_found = 1
					else if (ticker.mode.name == "cult" && M.mind == ticker.mode:sacrifice_target)
						corpse_is_target = 1
					else
						corpse_to_raise = M
						break
			if (!corpse_to_raise)
				if (unsuitable_corpse_found)
					usr << "\red The body still has some earthly ties. It must sever them, if only for them to grow again later."
				if (corpse_is_target)
					usr << "\red The Geometer of Blood wants this mortal for himself."
				return fizzle()


			var/sacrifice_is_target = 0
			find_sacrifice:
				for(var/obj/rune/R in world)
					if(R.word1==wordblood && R.word2==wordjoin && R.word3==wordhell)
						for(var/mob/living/carbon/human/N in R.loc)
							if (ticker.mode.name == "cult" && N.mind && N.mind == ticker.mode:sacrifice_target)
								sacrifice_is_target = 1
							else
								if(N.stat<2)
									body_to_sacrifice = N
									break find_sacrifice

			if (!body_to_sacrifice)
				if (sacrifice_is_target)
					usr << "\red The Geometer of blood wants that corpse for himself."
				else
					usr << "\red You need a dead corpse as source of energy to put soul in new body."
				return fizzle()

			for(var/mob/dead/observer/O in src.loc)
				if(!O.client)
					continue
				ghost = O

			if (!ghost)
				usr << "\red You do not feel an ethernal immaterial soul here."
				return fizzle()

//										rejuvenatedheal(M)
			corpse_to_raise.mind = new//Mind initialize stuff.
			corpse_to_raise.mind.current = corpse_to_raise
			corpse_to_raise.mind.original = corpse_to_raise
			corpse_to_raise.mind.key = ghost.key
			corpse_to_raise.key = ghost.key
			del(ghost)
			for(var/A in corpse_to_raise.organs)
				var/datum/organ/external/affecting = corpse_to_raise.organs[A]
				if(!istype(affecting))
					continue
				affecting.heal_damage(1000, 1000)
			corpse_to_raise.toxloss = 0
			corpse_to_raise.oxyloss = 0
			corpse_to_raise.paralysis = 0
			corpse_to_raise.stunned = 0
			corpse_to_raise.weakened = 0
			corpse_to_raise.radiation = 0
			corpse_to_raise.buckled = null
			if (corpse_to_raise.handcuffed)
				del(corpse_to_raise.handcuffed)
			corpse_to_raise.stat=0
			corpse_to_raise.updatehealth()
			corpse_to_raise.UpdateDamageIcon()


			usr.say("Pasnar val'keriam usinar. Savrae ines amutan. Yam'toth remium il'tarat!")
			corpse_to_raise.visible_message("\red [corpse_to_raise]'s eyes glow with a faint red as he stands up, slowly starting to breathe again.", \
			"\red Life... I'm alive again...", \
			"\red You hear a faint, slightly familiar whisper.")
			body_to_sacrifice.visible_message("\red [body_to_sacrifice] is torn apart, a black smoke swiftly dissipating from his remains!", \
			"\red You feel as your blood boils, tearing you apart.", \
			"\red You hear a thousand voices, all crying in pain.")
			body_to_sacrifice.gib(1)
			if (ticker.mode.name == "cult")
				ticker.mode:add_cultist(body_to_sacrifice.mind)
			else
				ticker.mode.cult+=body_to_sacrifice.mind
			corpse_to_raise << "<font color=\"purple\"><b><i>Your blood pulses. Your head throbs. The world goes red. All at once you are aware of a horrible, horrible truth. The veil of reality has been ripped away and in the festering wound left behind something sinister takes root.</b></i></font>"
			corpse_to_raise << "<font color=\"purple\"><b><i>Assist your new compatriots in their dark dealings. Their goal is yours, and yours is theirs. You serve the Dark One above all else. Bring It back.</b></i></font>"
			return

		obscure(var/rad)
			var/S=0
			for(var/obj/rune/R in orange(rad,src))
				if(R!=src)
					R:visibility=0
				S=1
			if(S)
				if(istype(src,/obj/rune))
					usr.say("Kla'atu barada nikt'o!")
					for (var/mob/V in viewers(src))
						V.show_message("\red The rune turns into gray dust, veiling the surrounding runes.", 3)
					del(src)
				else
					usr.whisper("Kla'atu barada nikt'o!")
					usr << "\red Your talisman turns into gray dust, veiling the surrounding runes."
					for (var/mob/V in orange(1,src))
						if(V!=usr)
							V.show_message("\red Dust emanates from [usr]'s hands for a moment.", 3)

				return
			if(istype(src,/obj/rune))
				return	fizzle()
			else
				call(/obj/rune/proc/fizzle)()
				return

		scry()
			if(usr.loc==src.loc)
				var/mob/living/carbon/human/L = usr
				usr.say("Fwe'sh mah erl nyag r'ya!")
				usr.visible_message("\red [usr]'s eyes glow blue as \he freezes in place, absolutely motionless.", \
				"\red The shadow that is your spirit separates itself from your body. You are now in the realm beyond. While this it's a great sight, being here strains your mind and body. Hurry.", \
				"\red You hear only complete silence for a moment.")
				usr.ghostize()
				for(L.ajourn=1,L.ajourn)
					sleep(10)
					if(L.key)
						L.ajourn=0
						return
					else
						L.take_organ_damage(1, 0)
			return fizzle()

		manifest()
			var/obj/rune/this_rune = src
			src = null
			if(usr.loc!=this_rune.loc)
				return this_rune.fizzle()
			var/mob/dead/observer/ghost
			for(var/mob/dead/observer/O in this_rune.loc)
				if (!O.client)
					continue
				ghost = O
				break
			if(!ghost)
				return this_rune.fizzle()

			usr.say("Gal'h'rfikk harfrandid mud'gib!")
			var/mob/living/carbon/human/dummy/D = new(this_rune.loc)
			usr.visible_message("\red A shape forms in the center of the rune. A shape of... a man.", \
			"\red A shape forms in the center of the rune. A shape of... a man.", \
			"\red You hear liquid flowing.")
			D.real_name = "Unknown"
			for(var/obj/item/weapon/paper/P in this_rune.loc)
				if(length(P.name)<=24)
					D.real_name = P.name
					break
			D.universal_speak = 1
			D.nodamage = 0
			D.mind = new//Mind initialize stuff.
			D.mind.current = D
			D.mind.original = D
			D.mind.key = ghost.key
			D.key = ghost.key
			manifested += D
			ghost.invisibility = 101
			if (ticker.mode.name == "cult")
				ticker.mode:add_cultist(D.mind)
			else
				ticker.mode.cult+=D.mind
			D << "<font color=\"purple\"><b><i>Your blood pulses. Your head throbs. The world goes red. All at once you are aware of a horrible, horrible truth. The veil of reality has been ripped away and in the festering wound left behind something sinister takes root.</b></i></font>"
			D << "<font color=\"purple\"><b><i>Assist your new compatriots in their dark dealings. Their goal is yours, and yours is theirs. You serve the Dark One above all else. Bring It back.</b></i></font>"
			var/mob/living/user = usr
			while(this_rune && user && user.stat==0 && user.client && user.loc==this_rune.loc)
				user.take_organ_damage(1, 0)
				sleep(30)
			if(D)
				D.visible_message("\red [D] slowly dissipates into dust and bones.", \
				"\red You feel pain, as bonds formed between your soul and this homunculus break.", \
				"\red You hear faint rustle.")
				manifested -= D
				ghost.invisibility = 10
				ghost.key = D.key
				D.dust(1)
			return

		seal()
			var/obj/item/weapon/paper/newtalisman
			var/unsuitable_newtalisman = 0
			for(var/obj/item/weapon/paper/P in src.loc)
				if(!P.info)
					newtalisman = P
					break
				else
					unsuitable_newtalisman = 1
			if (!newtalisman)
				if (unsuitable_newtalisman)
					usr << "\red The blank is tainted. It is unsuitable."
				return fizzle()

			var/obj/rune/imbued_from
			var/obj/item/weapon/paper/talisman/T
			for(var/obj/rune/R in orange(1,src))
				if(R==src)
					continue
				switch(R.runetype)
					if("teleport")
						T = new(src.loc)
						T.imbue = "[R.word3]"
						T.info = "[R.word3]"
						imbued_from = R
					if("tome")
						T = new(src.loc)
						T.imbue = "tome"
						imbued_from = R
					if("emp")
						T = new(src.loc)
						T.imbue = "emp"
						imbued_from = R
					if("obscure")
						T = new(src.loc)
						T.imbue = "obscure"
						imbued_from = R
					if("reveal")
						T = new(src.loc)
						T.imbue = "reveal"
						imbued_from = R
					if("deafen")
						T = new(src.loc)
						T.imbue = "deafen"
						imbued_from = R
					if("blind")
						T = new(src.loc)
						T.imbue = "blind"
						imbued_from = R
					if("contact")
						T = new(src.loc)
						T.imbue = "contact"
						imbued_from = R
					if("explode")
						if(R.desc)
							T = new(src.loc)
							T.imbue = "explode"
							T.info = "[R.desc]"
							T.icon_state = "paper"
							imbued_from = R
			if (imbued_from)
				for (var/mob/V in viewers(src))
					V.show_message("\red One of runes turns into dust, which then forms into an arcane image on the paper.", 3)
				usr.say("H'drak v'loso, mir'kanas verbot!")
				del(imbued_from)
				del(newtalisman)
			else
				return fizzle()

		contact()
			var/input = input(usr, "Please choose a message to tell to the other acolytes.", "Voice of Blood", "") as text|null
			if(!input)
				if (istype(src))
					return fizzle()
				else
					return
			if(istype(src,/obj/rune))
				usr.say("Uhrast ka'hfa heldsagen ver'lot!")
			else
				usr.whisper("Uhrast ka'hfa heldsagen ver'lot!")
			var/input_s = sanitize(input)
			if(istype(src,/obj/rune))
				usr.say("[input]")
			else
				usr.whisper("[input]")
			for(var/datum/mind/H in ticker.mode.cult)
				if (H.current)
					H.current << "\red \b [input_s]"
			del(src)
			return

		sacrifice()
			var/list/mob/living/carbon/human/cultsinrange = list()
			var/list/mob/living/carbon/human/victims = list()
			for(var/mob/living/carbon/human/V in src.loc)
				if(!(iscultist(V)))
					victims += V
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C))
					cultsinrange += C
					C.say("Barhah hra zar'garis!")
			for(var/mob/H in victims)
				if (ticker.mode.name == "cult")
					if(H.mind == ticker.mode:sacrifice_target)
						if(cultsinrange.len >= 3)
							sacrificed += H.mind
							H.gib(1)
							usr << "\red The Geometer of Blood accepts this sacrifice, your objective is now complete."
						else
							usr << "\red Your target's earthly bonds are too strong. You need more cultists to succeed in this ritual."
					else
						if(cultsinrange.len >= 3)
							if(H.stat !=2)
								if(prob(80))
									usr << "\red The Geometer of Blood accepts this sacrifice."
									ticker.mode:grant_runeword(usr)
								else
									usr << "\red The Geometer of blood accepts this sacrifice."
									usr << "\red However, this soul was not enough to gain His favor."
								H.gib(1)
							else
								if(prob(40))
									usr << "\red The Geometer of Blood accepts this sacrifice."
									ticker.mode:grant_runeword(usr)
								else
									usr << "\red The Geometer of Blood accepts this sacrifice."
									usr << "\red However, a mere dead body is not enough to satisfy Him."
								H.gib(1)
						else
							if(H.stat !=2)
								usr << "\red The victim is still alive, you will need more cultists chanting for the sacrifice to succeed."
							else
								if(prob(40))
									usr << "\red The Geometer of Blood accepts this sacrifice."
									ticker.mode:grant_runeword(usr)
								else
									usr << "\red The Geometer of Blood accepts this sacrifice."
									usr << "\red However, a mere dead body is not enough to satisfy Him."
								H.gib(1)
				else
					if(cultsinrange.len >= 3)
						H.gib(1)
						usr << "\red The Geometer of Blood accepts this sacrifice."
					else
						if(H.stat !=2)
							usr << "\red The victim is still alive, you will need more cultists chanting for the sacrifice to succeed."
						else
							H.gib(1)
							usr << "\red The Geometer of Blood accepts this sacrifice."
			for(var/mob/living/carbon/monkey/M in src.loc)
				if (ticker.mode.name == "cult")
					if(M.mind == ticker.mode:sacrifice_target)
						if(cultsinrange.len >= 3)
							sacrificed += M.mind
							usr << "\red The Geometer of Blood accepts this sacrifice, your objective is now complete."
						else
							usr << "\red Your target's earthly bonds are too strong. You need more cultists to succeed in this ritual."
							continue
					else
						if(prob(20))
							usr << "\red The Geometer of Blood accepts your meager sacrifice."
							ticker.mode:grant_runeword(usr)
						else
							usr << "\red The Geometer of Blood accepts this sacrifice."
							usr << "\red However, a mere monkey is not enough to satisfy Him."
				else
					usr << "\red The Geometer of Blood accepts your meager sacrifice."
				M.gib(1)

		reveal(var/obj/W as obj)
			var/go=0
			var/rad
			var/S=0
			if(istype(W,/obj/rune))
				rad = 6
				go = 1
			if (istype(W,/obj/item/weapon/paper/talisman))
				rad = 4
				go = 1
			if (istype(W,/obj/item/weapon/storage/bible))
				rad = 1
				go = 1
			if(go)
				for(var/obj/rune/R in orange(rad,src))
					if(R!=src)
						R:visibility=15
					S=1
			if(S)
				if(istype(W,/obj/item/weapon/storage/bible))
					usr << "\red Arcane markings suddenly glow from underneath a thin layer of dust!"
					return
				if(istype(W,/obj/rune))
					usr.say("Nikt'o barada kla'atu!")
					for (var/mob/V in viewers(src))
						V.show_message("\red The rune turns into red dust, reveaing the surrounding runes.", 3)
					del(src)
					return
				if(istype(W,/obj/item/weapon/paper/talisman))
					usr.whisper("Nikt'o barada kla'atu!")
					usr << "\red Your talisman turns into red dust, revealing the surrounding runes."
					for (var/mob/V in orange(1,usr.loc))
						if(V!=usr)
							V.show_message("\red Red dust emanates from [usr]'s hands for a moment.", 3)
					return
				return
			if(istype(W,/obj/rune))
				return	fizzle()
			if(istype(W,/obj/item/weapon/paper/talisman))
				call(/obj/rune/proc/fizzle)()
				return

		wall()
			usr.say("Khari'd! Eske'te tannin!")
			src.density = !src.density
			var/mob/living/user = usr
			user.take_organ_damage(2, 0)
			if(src.density)
				usr << "\red Your blood flows into the rune, and you feel that the very space over the rune thickens."
			else
				usr << "\red Your blood flows into the rune, and you feel as the rune releases its grasp on space."
			return

		freedom()
			var/mob/living/user = usr
			var/list/mob/living/carbon/cultists = new
			for(var/datum/mind/H in ticker.mode.cult)
				if (istype(H.current,/mob/living/carbon))
					cultists+=H.current
			var/list/mob/living/carbon/users = new
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C))
					users+=C
			if(users.len>=3)
				var/mob/cultist = input("Choose the one who you want to free", "Followers of Geometer") as null|anything in (cultists - users)
				if(!cultist)
					return fizzle()
				if (cultist == user) //just to be sure.
					return
				if(!(cultist.buckled || \
					cultist.handcuffed || \
					istype(cultist.wear_mask, /obj/item/clothing/mask/muzzle) || \
					(istype(cultist.loc, /obj/closet)&&cultist.loc:welded) || \
					(istype(cultist.loc, /obj/secure_closet)&&cultist.loc:locked) || \
					(istype(cultist.loc, /obj/machinery/dna_scannernew)&&cultist.loc:locked) \
				))
					user << "\red The [cultist] is already free."
					return
				cultist.buckled = null
				if (cultist.handcuffed)
					cultist.handcuffed.loc = cultist.loc
					cultist.handcuffed = null
				if (istype(cultist.wear_mask, /obj/item/clothing/mask/muzzle))
					cultist.u_equip(cultist.wear_mask)
				if(istype(cultist.loc, /obj/closet)&&cultist.loc:welded)
					cultist.loc:welded = 0
				if(istype(cultist.loc, /obj/secure_closet)&&cultist.loc:locked)
					cultist.loc:locked = 0
				if(istype(cultist.loc, /obj/machinery/dna_scannernew)&&cultist.loc:locked)
					cultist.loc:locked = 0
				for(var/mob/living/carbon/C in users)
					user.take_overall_damage(15, 0)
					C.say("Khari'd! Gual'te nikka!")
				del(src)
			return fizzle()

		summon()
			var/mob/living/user = usr
			var/list/mob/living/carbon/cultists = new
			for(var/datum/mind/H in ticker.mode.cult)
				if (istype(H.current,/mob/living/carbon))
					cultists+=H.current
			var/list/mob/living/carbon/users = new
			if(istype(src,/obj/rune))
				for(var/mob/living/carbon/C in orange(1,src))
					if(iscultist(C))
						users+=C
				if(users.len>=3)
					var/mob/cultist = input("Choose the one who you want to summon", "Followers of Geometer") as null|anything in (cultists - user)
					if(!cultist)
						return fizzle()
					if (cultist == user) //just to be sure.
						return
					if(cultist.buckled || cultist.handcuffed || (!isturf(cultist.loc) && !istype(cultist.loc, /obj/closet)))
						user << "\red You cannot summon the [cultist], for him shackles of blood are strong"
						return fizzle()
					cultist.loc = src.loc
					cultist.lying = 1
					cultist.update_clothing()
					for(var/mob/living/carbon/human/C in orange(1,src))
						if(iscultist(C))
							C.say("N'ath reth sh'yro eth d'rekkathnor!")
							C.take_overall_damage(25, 0)
					user.visible_message("\red Rune disappears with a flash of red light, and in it's place now a body lies.", \
					"\red You are blinded by the flash of red light! After you're able to see again, you see that now instead of the rune there's a body.", \
					"\red You hear a pop and smell ozone.")
					del(src)
				return fizzle()
			else

		deafen()
			if(istype(src,/obj/rune))
				var/affected = 0
				for(var/mob/living/carbon/C in range(7,src))
					if (iscultist(C))
						continue
					C.ear_deaf += 50
					C.show_message("\red The world around you suddenly becomes quiet.", 3)
					affected++
					if(prob(1))
						C.disabilities |= 4
				if(affected)
					usr.say("Sti' kaliedir!")
					usr << "\red The world becomes quiet as the deafening rune dissipates into fine dust."
					del(src)
				else
					return fizzle()
			else
				var/affected = 0
				for(var/mob/living/carbon/C in range(7,usr))
					if (iscultist(C))
						continue
					C.ear_deaf += 30
					//talismans is weaker.
					C.show_message("\red The world around you suddenly becomes quiet.", 3)
					affected++
				if(affected)
					usr.whisper("Sti' kaliedir!")
					usr << "\red Your talisman turns into gray dust, deafening everyone around."
					for (var/mob/V in orange(1,src))
						if(!(iscultist(V)))
							V.show_message("\red Dust flows from [usr]'s hands for a moment, and the world suddenly becomes quiet..", 3)
			return

		blind()
			if(istype(src,/obj/rune))
				var/affected = 0
				for(var/mob/living/carbon/C in viewers(src))
					if (iscultist(C))
						continue
					C.eye_blurry += 50
					C.eye_blind += 20
					if(prob(5))
						C.disabilities |= 1
						if(prob(10))
							C.sdisabilities |= 1
					C.show_message("\red Suddenly you see red flash that blinds you.", 3)
					affected++
				if(affected)
					usr.say("Sti' kaliesin!")
					usr << "\red The rune flashes, blinding those who not follow the Nar-Sie, and dissipates into fine dust."
					del(src)
				else
					return fizzle()
			else
				var/affected = 0
				for(var/mob/living/carbon/C in viewers(usr))
					if (iscultist(C))
						continue
					C.eye_blurry += 30
					C.eye_blind += 10
					//talismans is weaker.
					affected++
					C.show_message("\red You feel a sharp pain in your eyes, and the world disappears into darkness..", 3)
				if(affected)
					usr.whisper("Sti' kaliesin!")
					usr << "\red Your talisman turns into gray dust, blinding those who not follow the Nar-Sie."
			return

		bloodboil()
			var/culcount = 0
			for(var/mob/living/carbon/C in orange(1,src))
				if(iscultist(C))
					culcount++
			if(culcount>=3)
				for(var/mob/living/carbon/M in viewers(usr))
					if(iscultist(M))
						continue
					M.take_overall_damage(51,51)
					M << "\red Your blood boils!"
					if(prob(5))
						spawn(5)
							M.gib(1)
				for(var/obj/rune/R in view(src))
					if(prob(10))
						explosion(R.loc, -1, 0, 1, 5)
				for(var/mob/living/carbon/human/C in orange(1,src))
					if(iscultist(C))
						C.say("Dedo ol'btoh!")
						C.take_overall_damage(15, 0)
				del(src)
			else
				return fizzle()
			return

		explode()
			for(var/mob/living/carbon/human/H in src.loc)
				if(H && H.stat != 2 && H != usr)
					if(H in manifested)
						usr << "\red Bonds between this body and its soul are too weak."
						return fizzle()
					else
						prepare_explosive_runes(H)
						usr.say("Dammatu er'than kergast!")
						del(src)
						return //maximum sureness
			if(!src.desc)
				src.desc = input("What you'd like to write in Explosive Runes?", "Explosive Runes") as null|text
				if(src.desc)//you can cancel Explosive Runes writing.
					usr.say("Dammatu!")
					return
				return

		hold() //this rune will "hold" all airlocks marked by word, preventing them from changing open/closed state.
			var/hold = 0
			var/word = ""
			for(var/mob/living/carbon/human/H in src.loc)
				for(var/obj/machinery/door/airlock/A in world)
					if(!A.word in holding)
						word = A.word
						hold = 1
						holding += word
				usr.say("Kold'karen el darentu [word]!")
				while(hold && H.loc == src.loc && H.stat != 2)
					sleep(10)
					H.take_overall_damage(2, 0)
				if(word)
					hold = 0
					holding -= word
				return

/proc/prepare_explosive_runes(var/mob/M as mob)
	M.verbs += /proc/explode_inscription
//	var/fat = M.mutations & FAT
	//overlays are kinda buggy, commenting for now.
//	M.overlays += image("icon" = 'rune.dmi', "icon_state" = "expl[fat][!M.lying ? "_s" : "_l"]")//inscriptions on body

	if(istype(src, /obj/rune))
		M.stunned += 15
		M.visible_message("\red [M] falls and his blood begins to soak out of his body, forming runes on his skin.", \
			"\red You are stunned by the pain as your blood soaks out.")

/proc/explode_inscription()
	set category = "Object"
	set name = "Explode Runes"
	set desc="Human bomb, anyone?"
	if(!usr.stat)
		usr.verbs -= /proc/explode_inscription
		explosion(usr.loc,2,3,3,10)
		//explosion(usr.loc,3,7,14,20) //3,7,14,20
		if(usr)
			usr.gib()
			sleep(50)
			if(usr) //А я сказал нахуй!
				var/mob/living/carbon/human/fucker = usr
				fucker.ghostize(1)
				gibs(fucker.loc, fucker.viruses)
				del(fucker)
	return
