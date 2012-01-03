
/obj/item/clothing/suit/armor/commissar
	animus = 1
	name = "commissar's armored trenchoat"
	desc = "A trenchoat augmented with a special alloy for some protection and style"
	icon = 'suits_animus.dmi'
	icon_state = "commissarcoat"
	item_state = "jensencoat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	flags = FPRINT | TABLEPASS | ONESIZEFITSALL
	armor = list(melee = 65, bullet = 30, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/head/commissar
	animus = 1
	name = "Commissar Hat"
	desc = "The hat of the Commissar."
	icon = 'hats_animus.dmi'
	icon_state = "comcap"
	flags = FPRINT|TABLEPASS|SUITSPACE
	item_state = "caphat"
