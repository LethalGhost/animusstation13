/obj/admins
	var/turf/pos_start = null

/client/proc/PickPos(var/turf/T in world)
	set name = "Pick Position"
	set desc = "For direct hit"
	set category = "Fun"
	if(!T)
		return
	if(!src.authenticated || !src.holder)
		src << "Only administrators may use this command."
		return

	src.holder.pos_start = T

/client/proc/DirectHit()
	set name = "Direct Hit"
	set desc = "Trow something in player"
	set category = "Fun"

	if(!src.authenticated || !src.holder)
		src << "Only administrators may use this command."
		return

	if(!src.holder.pos_start)
		src << "Set start pos first."
		return

	if(!src.holder.marked_datum && !istype(src.holder.marked_datum, /area))
		src << "Set target first."
		return

	var/list/possible_things = list(/*"meteor big",*/"meteor medium","meteor small","rod"/*,"projectile","special"*/,"cancel")
	var/obj/Thing = null
	var/Target = src.holder.marked_datum

	var/V = input("Choose object to fly.", "Direct Hit") in possible_things
	switch(V)
		if("cancel")
			return
		if("Meteor Big")
			Thing = new /obj/effect/meteor/big(src.holder.pos_start)
		if("meteor medium")
			Thing = new /obj/effect/meteor(src.holder.pos_start)
		if("meteor small")
			Thing = new /obj/effect/meteor/small(src.holder.pos_start)
		if("rod")
			Thing = new /obj/effect/immovablerod(src.holder.pos_start)
			Thing:pass_chance = 100
//		if("projectile")
//			Thing = new /obj/effect/meteor/big(src.holder.pos_start)
//		if("special")
//			Thing = new /obj/effect/meteor/big(src.holder.pos_start)
	spawn(0)
		walk_towards(Thing, Target,1)
//	var/mission_accomplished = 0
	while(Thing)// && !mission_accomplished)
		if(!Target)
//			mission_accomplished = 1
			break
		if(!istype(Target, /mob/dead/observer))
			if(istype(Target, /turf))
				if(Thing.loc == Target)
//					mission_accomplished = 1
					break
			else
				if(Thing.loc == Target:loc)
//					mission_accomplished = 1
					break

		sleep(10)
	spawn(50)
		if(Thing)
			del(Thing)
	if(Thing)
		walk(Thing,Thing.dir,1)