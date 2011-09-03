// Bodybags! Such an optimistic things!
/obj/item/bodybag
	name = "bodybag"
	icon = 'bodybags.dmi'
	//icon_state = "bodybag"
	density = 1
	flags = FPRINT

	var
		var/icon_norm = null
		var/icon_fold = null
		var/icon_full = null
		var/folded = 0
		var/zipped = 0
		var/closed = 1
		var/tagged = 0 // 0 - no tag, 1 - dead tag, 2 - clone tag
		var/tag_clone = "tag_clone"
		var/tag_dead = "tag_dead"
		var/tag_full = "tag_full"
		var/empty = 1

	black
		name = "Bodybag"
		desc = "Standard black bodybag"
		icon_norm = "bodybag_black"
		icon_fold = "bodybag_black_fold"
		icon_full = "bodybag_black_full"

	red
		name = "Security Bodybag"
		desc = "Bodybag used by station security"
		icon_norm = "bodybag_red"
		icon_fold = "bodybag_red_fold"

	blue
		name = "Blue Bodybag"
		desc = "It has no manufacturer markings"
		icon_norm = "bodybag_blue"
		icon_fold = "bodybag_blue_fold"

	green
		name = "CentComm Bodybag"
		desc = "Bodybag used by CentComm operatives"
		icon_norm = "bodybag_green"
		icon_fold = "bodybag_green_fold"

	New()
		..()
		/*src.verbs += /obj/item/bodybag/verb/fold
		src.verbs += /obj/item/bodybag/verb/zip*/
		src.verbs += /obj/item/bodybag/verb/zipping
		icon_state = src.icon_norm

	attack_hand(mob/user as mob)
		if (zipped)
			user.show_message("It's zipped!")
			return
		if (closed)
			open()
		else
			close()

	open() // zipped one cannot be opened, jedi
		if (usr.stat != 0)
			return

		if(src.zipped)
			usr << "It's zipped! Unzip first."
			return

		for(var/mob/O in hearers(src, null))
			playsound(src.loc, 'bodybag_open.ogg', 40, 1, -3)

		for(var/mob/corpse in src) // bodies out
			corpse.loc = get_turf(src)
		for(var/obj/stuff in src) // other stuff too
			stuff.loc = get_turf(src)

		src.closed = 0
		if(!src.contents)
			src.empty = 1
		update_tags()

	close()
		if (usr.stat != 0)
			return

		for(var/mob/O in hearers(src, null))
			playsound(src.loc, 'bodybag_close.ogg', 50, 1, -3)

		for(var/mob/living/carbon/human/corpse in get_turf(src)) // everybody's dead, yes
			if (corpse.lying)
				if (src.contents)
					usr << "Only one body can fit inside!"
					return
				else
					corpse.loc = src

		src.closed = 1

		if(!src.contents)
			src.empty = 1
			icon_state = src.icon_full

		update_tags()

		/*src.verbs -= /obj/item/bodybag/verb/unzip
		src.verbs += /obj/item/bodybag/verb/zip*/

	change_tag()
		set category = "Object"
		set name = "Flip the tag"
		set src in oview(1)

		if (!tagged)
			tagged = 1 // clone tag
			usr << "You flip the tag to &quot;Clone&quot;."
		if (tagged == 1)
			tagged = 2 // dead tag
			usr << "You flip the tag to &quot;Dead&quot;."
		if (tagged == 2)
			tagged = 0
			usr << "You flip the tag to empty side."

		update_tags()
		return

	update_tags()
		src.overlays = null
		if(!empty)
			src.overlays += tag_full
		if(tagged == 1)
			src.overlays += tag_clone
		if(tagged == 2)
			src.overlays += tag_dead
		return

	examine()
		set src in view()

		..()
		if ((in_range(src, usr) || src.loc == usr))
			if(!tagged) usr.show_message("It has no tag.")
			if(tagged == 1) usr.show_message("It has a &quot;Clone&quot; tag.")
			if(tagged == 2) usr.show_message("It has a &quot;Dead&quot; tag.")

			if(empty) usr.show_message("There is no body in a bag")
			if(!empty) usr.show_message("There is a body in a bag")
		return

	verb
		zipping()
			set src in oview(1)
			set category = "Object"
			set name = "Zip/unzip a bodybag"
			if (usr.stat != 0)
				return
			if (src.folded)
				usr << "It's folded!"
				return
			if(src.zipped)
				usr << "You unzip a bodybag."
				playsound(src.loc, 'bodybag_unzip.ogg', 40, 1, -3)
				src.zipped = 0
			else
				usr << "You zip a bodybag."
				playsound(src.loc, 'bodybag_zip.ogg', 40, 1, -3)
				src.zipped = 1

/*/obj/item/bodybag/verb/zip()
	set category = "Object"
	set name = "Zip a bodybag"
	set src in oview(1)
	if (usr.stat != 0)
		return
	if (src.folded)
		usr << "It's folded"
		return
	src.verbs -= /obj/item/bodybag/verb/zip
	src.verbs += /obj/item/bodybag/verb/unzip
	playsound(src.loc, 'bodybag_zip.ogg', 40, 1, -3)
	src.zipped = 1*/

		folding()
			set category = "Object"
			set name = "Fold/unfold a bodybag"
			set src in oview()

			if (usr.stat != 0)
				return

			if(folded)
				/*src.verbs -= /obj/item/bodybag/verb/unfold
				src.verbs += /obj/item/bodybag/verb/fold*/
				//playsound(src.loc, 'bodybag_unfold.ogg', 40, 1, -3)
				src.folded = 0
				src.density = 1
				icon_state = src.icon_norm
				return

			if(!folded)
				if (src.zipped)
					usr << "It's zipped"
					return
				/*src.verbs -= /obj/item/bodybag/verb/fold
				src.verbs += /obj/item/bodybag/verb/unfold*/
				if (!src.empty)
					usr << "There is a body inside, you can't fold it."
					return
				//playsound(src.loc, 'bodybag_fold.ogg', 15, 1, -3)
				src.folded = 1
				src.density = 0
				icon_state = src.icon_fold
				return
// wip