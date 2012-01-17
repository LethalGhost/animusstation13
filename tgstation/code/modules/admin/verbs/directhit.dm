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
//		if("projectile")
//			Thing = new /obj/effect/meteor/big(src.holder.pos_start)
//		if("special")
//			Thing = new /obj/effect/meteor/big(src.holder.pos_start)
	spawn(0)
		walk_towards(Thing, Target,1)
	while(Thing)
		if(!Target)
			spawn(5)
				if(Thing)
					del(Thing)
		if(!istype(Target, /mob/dead/observer))
			if(istype(Target, /turf))
				if(Thing.loc == Target)
					spawn(5)
						if(Thing)
							del(Thing)
			else
				if(Thing.loc == Target:loc)
					spawn(5)
						if(Thing)
							del(Thing)
		sleep(10)