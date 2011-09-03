// CHUMP HELMETS: COOKING THEM DESTROYS THE CHUMP HELMET SPAWN.

/obj/item/clothing/head/helmet
	name = "helmet"
	icon_state = "helmet"
	flags = FPRINT|TABLEPASS|HEADCOVERSEYES
	item_state = "helmet"
	protective_temperature = 500
	heat_transfer_coefficient = 0.10

/obj/item/clothing/head/helmet/riot
	name = "riot helmet"
	icon_state = "riothelmet"
	flags = FPRINT|TABLEPASS|HEADSPACE|HEADCOVERSEYES|HEADCOVERSMOUTH
	item_state = "riothelmet"

/obj/item/clothing/head/helmet/space
	name = "space helmet"
	icon_state = "space"
	flags = FPRINT | TABLEPASS | HEADSPACE | HEADCOVERSEYES | HEADCOVERSMOUTH | PLASMAGUARD
	see_face = 0.0
	item_state = "space"

/obj/item/clothing/head/helmet/space/syndicate
	name = "red space helmet"
	icon_state = "syndicate"
	item_state = "syndicate"

/obj/item/clothing/head/helmet/swat
	name = "swat helmet"
	icon_state = "swat"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "swat"

/obj/item/clothing/head/helmet/thunderdome
	name = "thunderdome helmet"
	icon_state = "thunderdome"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "thunderdome"

/obj/item/clothing/head/helmet/hardhat
	name = "hard hat"
	icon_state = "hardhat0"
	flags = FPRINT | TABLEPASS
	item_state = "hardhat0"
	var/on = 0

/obj/item/clothing/head/helmet/plump
	name = "plump helmet helmet"
	icon_state = "plump"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "plump"

/obj/item/clothing/head/helmet/welding
	name = "welding helmet"
	desc = "A head-mounted face cover designed to protect the wearer completely from space-arc eye."
	icon_state = "welding"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	see_face = 0.0
	item_state = "welding"
	protective_temperature = 1300
	m_amt = 3000
	g_amt = 1000
	var/up = 0 //up/down

/obj/item/clothing/head/helmet/HoS
	name = "head of security's helmet"
	icon_state = "hoscap"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES

/obj/item/clothing/head/helmet/HoP
	name = "head of personnel's helmet"
	icon_state = "hopcap"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES

/obj/item/clothing/head/helmet/captain
	name = "captain's helmet"
	icon_state = "captaincap"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES