/obj/item/weapon/paper/talisman/proc/supply(var/key)
	if (!src.uses)
		del(src)
		return

	var/dat = "<B>There are [src.uses] runes drawn in blood on the parchment.</B><BR>"
	dat += "Please choose the chant to be imbued into the fabric of reality.<BR>"
	dat += "<HR>"
	dat += "<A href='?src=\ref[src];rune=tome'>N'ath reth sh'yro eth d'raggathnor!</A> - Allows you to summon a new arcane tome.<BR>"
	dat += "<A href='?src=\ref[src];rune=teleport'>Sas'so c'arta forbici!</A> - Allows you to move to a rune with the same last word.<BR>"
	dat += "<A href='?src=\ref[src];rune=emp'>Ta'gh fara'qha fel d'amar det!</A> - Allows you to destroy technology in a short range.<BR>"
	dat += "<A href='?src=\ref[src];rune=obscure'>Kla'atu barada nikt'o!</A> - Allows you to conceal the runes you placed on the floor.<BR>"
	dat += "<A href='?src=\ref[src];rune=contact'>Uhrast ka'hfa heldsagen ver'lot!</A> - Allows you to coordinate with others of your cult.<BR>"
	usr << browse(dat, "window=id_com;size=350x400")
	return

/obj/item/weapon/paper/talisman/Topic(href, href_list)
	if (!src)
		return

	if (usr.stat || usr.restrained() || !in_range(src, usr))
		return

	if (href_list["rune"])
		switch(href_list["rune"])
			if("tome")
				var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
				T.imbue = "tome"
			if("teleport")
				var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
				T.imbue = "[pick("ire", "ego", "nahlizet", "certum", "veri", "jatkaa", "balaq", "mgar", "karazet", "geeri")]"
				T.info = "[T.imbue]"
			if("emp")
				var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
				T.imbue = "emp"
			if("obscure")
				var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
				T.imbue = "obscure"
			if("contact")
				var/obj/item/weapon/paper/talisman/T = new /obj/item/weapon/paper/talisman(get_turf(usr))
				T.imbue = "contact"
		src.uses--
		supply()
	return