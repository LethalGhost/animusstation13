/datum/job/commissar
	title = "Commissar"
	flag = COMMISSAR
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2


	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_if_possible(new /obj/item/weapon/storage/backpack/satchel (H), H.slot_back)
		H.equip_if_possible(new /obj/item/weapon/storage/box/survival(H.back), H.slot_in_backpack)
		H.equip_if_possible(new /obj/item/device/radio/headset/heads/hos(H), H.slot_ears)
		H.equip_if_possible(new /obj/item/clothing/under/rank/commissar(H), H.slot_w_uniform)
		H.equip_if_possible(new /obj/item/clothing/shoes/brown(H), H.slot_shoes)
		H.equip_if_possible(new /obj/item/device/pda/heads/hos(H), H.slot_belt)
		H.equip_if_possible(new /obj/item/clothing/suit/armor/commissar(H), H.slot_wear_suit)
		H.equip_if_possible(new /obj/item/clothing/gloves/black(H), H.slot_gloves)
		H.equip_if_possible(new /obj/item/clothing/head/commissar(H), H.slot_head)
		H.equip_if_possible(new /obj/item/clothing/glasses/sunglasses/sechud(H), H.slot_glasses)
		H.equip_if_possible(new /obj/item/weapon/handcuffs(H), H.slot_in_backpack)
		H.equip_if_possible(new /obj/item/weapon/gun/energy/gun(H), H.slot_s_store)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		return 1


//COMMISSAR WHITELIST
var/list/whitelist_commissar

/proc/load_whitelist_commissar()
	var/text = file2text("data/whitelist_commissar.txt")
	if (!text)
		diary << "Failed to load whitelist_commissar.txt\n"
	else
		whitelist_commissar = dd_text2list(text, "\n")

/proc/check_whitelist_commissar(mob/M)
	if(!whitelist_commissar)
		return 0
	return ("[M.ckey]" in whitelist_commissar)