/var/list/donators = list()
/var/list/donators_special = list()

/proc/load_donators()
	var/text = file2text("config/donators.txt")

	if (!text)
		diary << "No donators.txt file found"
		return
	diary << "Reading donators.txt"

	var/list/CL = dd_text2list(text, "\n")

	for (var/t in CL)
		if (!t)
			continue
		if (length(t) == 0)
			continue
		if (copytext(t, 1, 2) == "#")
			continue

		var/special = 0
		if (copytext(t, 1, 2) == "$")
			t = copytext(t, 2)
			special = 1

		var/pos = findtext(t, " ")
		var/byondkey = null
		var/value = null

		if (pos)
			byondkey = lowertext(copytext(t, 1, pos))
			value = copytext(t, pos + 1)
			if(!special)
				donators[byondkey] = text2num(value)
			else
				donators_special[byondkey] = value

/client/var/datum/donators/donator = null

/client/verb/cmd_donator_panel()
	set name = "Donator panel"
	set category = "OOC"

	if(!ticker || ticker.current_state < 3)
		alert("Please wait until game setting up!")
		return

	if(!donator)
		var/exists = 0
		for(var/datum/donators/D)
			if(D.ownerkey == ckey)
				exists = 1
				donator = D
				break
		if(!exists)
			donator = new /datum/donators()
			donator.owner = src
			donator.ownerkey = ckey
			if(donators[ckey])
				donator.maxmoney = donators[ckey]
				donator.money = donator.maxmoney

	donator.donatorpanel()


/var/list/donators_datums = list() //need for protect from garbage collector

/datum/donators
	var/client/owner = null
	var/ownerkey
	var/money = 0
	var/maxmoney = 0
	var/allowed_num_items = 3
	var/special_used = 0

	New()
		..()
		donators_datums += src

/datum/donators/proc/donatorpanel()
	var/dat = "<title>Donator panel</title>"
	dat += "Your money: [money]/[maxmoney]<br>"
	dat += "Allowed number of items: [allowed_num_items]/3<br><br>"
	dat += "<b>Select items:</b> <br>"

	//here items list

	dat += "Premium Havanian Cigar: <A href='?src=\ref[src];item=/obj/item/clothing/mask/cigarette/cigar/havanian;cost=250'>250</A><br>"
	dat += "Kitty Ears: <A href='?src=\ref[src];item=/obj/item/clothing/head/kitty;cost=800'>800</A><br>"
	dat += "Eye patch: <A href='?src=\ref[src];item=/obj/item/clothing/glasses/eyepatch;cost=200'>200</A><br>"
	dat += "Walking stick: <A href='?src=\ref[src];item=/obj/item/weapon/staff/stick;cost=200'>200</A><br>"
	dat += "Zippo: <A href='?src=\ref[src];item=/obj/item/weapon/zippo;cost=200'>200</A><br>"
	dat += "Cigarette packet: <A href='?src=\ref[src];item=/obj/item/weapon/cigpacket;cost=50'>50</A><br>"
	dat += "Ushanka: <A href='?src=\ref[src];item=/obj/item/clothing/head/ushanka;cost=400'>400</A><br>"
	dat += "pAI card: <A href='?src=\ref[src];item=/obj/item/device/paicard;cost=400'>400</A><br>"
	//dat += "Sunglasses: <A href='?src=\ref[src];item=/obj/item/clothing/glasses/sunglasses;cost=800'>800</A><br>"
	dat += "Beer bottle: <A href='?src=\ref[src];item=/obj/item/weapon/reagent_containers/food/drinks/beer;cost=80'>80</A><br>"
	dat += "Captain flask: <A href='?src=\ref[src];item=/obj/item/weapon/reagent_containers/food/drinks/flask;cost=400'>400</A><br>"
	dat += "Black gloves: <A href='?src=\ref[src];item=/obj/item/clothing/gloves/black;cost=800'>800</A><br>"
	dat += "\"Three Mile Island\" Ice Tea: <A href='?src=\ref[src];item=/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/threemileisland;cost=100'>100</A><br>"
	dat += "Satchel: <A href='?src=\ref[src];item=/obj/item/weapon/storage/backpack/satchel;cost=400'>400</A><br>"
	//dat += "Tacticool Turtleneck: <A href='?src=\ref[src];item=/obj/item/clothing/under/syndicate/tacticool;cost=200'>200</A><br>"

	if(donators_special[ownerkey] && !special_used)
		dat += "<br>Special for [ownerkey]:<br>"
		switch(donators_special[ownerkey])
			if("catman")
				dat += "Make youself cat: <A href='?src=\ref[src];special=catman'>click</A><br>"
			if("black catman")
				dat += "Make youself cat: <A href='?src=\ref[src];special=black catman'>click</A><br>"

	usr << browse(dat, "window=donatorpanel;size=250x400")


/datum/donators/Topic(href, href_list)
	if(href_list["item"])
		attemptSpawnItem(href_list["item"],text2num(href_list["cost"]))
		return
	if(href_list["special"])
		switch(href_list["special"])
			if("catman")
				var/mob/living/carbon/human/H = owner.mob
				if(!istype(H))
					owner << "\red You must be a human to do this"
					return
				H.mutantrace = "cat"
				special_used = 1
			if("black catman")
				var/mob/living/carbon/human/H = owner.mob
				if(!istype(H))
					owner << "\red You must be a human to do this"
					return
				H.mutantrace = "catb"
				special_used = 1

/datum/donators/proc/attemptSpawnItem(var/item,var/cost)
	if(cost > money)
		usr << "\red You don't have enough funds."
		return 0

	if(!allowed_num_items)
		usr << "\red You already spawned max count of items."
		return

	var/mob/living/carbon/human/H = owner.mob
	if(!istype(H))
		usr << "\red You must be a human to use this."
		return 0

	if(H.stat)
		return 0

	money -= cost
	allowed_num_items--

	var/obj/spawned = new item(H)

	var/list/slots = list (
		"backpack" = H.slot_in_backpack,
		"left pocket" = H.slot_l_store,
		"right pocket" = H.slot_r_store,
		"left hand" = H.slot_l_hand,
		"right hand" = H.slot_r_hand,
	)
	var/where = H.equip_in_one_of_slots(spawned, slots, del_on_fail=0)
	if (!where)
		spawned.loc = H.loc
		usr << "\blue Your [spawned] has been spawned!"
	else
		usr << "\blue Your [spawned] has been spawned in your [where]!"

	owner.cmd_donator_panel()



//SPECIAL ITEMS
/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/threemileisland
	New()
		..()
		reagents.add_reagent("threemileisland", 50)
		on_reagent_change()