// HATS. OH MY WHAT A FINE CHAPEAU, GOOD SIR.

/obj/item/clothing/head
	name = "head"
	icon = 'hats.dmi'
	body_parts_covered = HEAD
	var/list/allowed = list(/obj/item/weapon/pen)

/obj/item/clothing/head/bio_hood
	name = "bio hood"
	icon_state = "bio_hood"
	item_state = "bio_hood"
	permeability_coefficient = 0.01
	flags = FPRINT|TABLEPASS|HEADSPACE|HEADCOVERSEYES|HEADCOVERSMOUTH|PLASMAGUARD

/obj/item/clothing/head/righelm
	name = "robust helm"
	icon_state = "rig_helm"
	flags = FPRINT|TABLEPASS|HEADSPACE|HEADCOVERSEYES|HEADCOVERSMOUTH|PLASMAGUARD
	permeability_coefficient = 0.02
	protective_temperature = 1000
	heat_transfer_coefficient = 0.02
	gas_transfer_coefficient = 0.01
	body_parts_covered = HEAD

/obj/item/clothing/head/cakehat
	name = "cakehat"
	desc = "It is a cakehat"
	icon_state = "cake0"
	var/onfire = 0.0
	var/status = 0
	flags = FPRINT|TABLEPASS|HEADSPACE|HEADCOVERSEYES
	var/fire_resist = T0C+1300	//this is the max temp it can stand before you start to cook. although it might not burn away, you take damage

/obj/item/clothing/head/caphat
	name = "captain's hat"
	icon_state = "captain"
	flags = FPRINT|TABLEPASS
	item_state = "caphat"

/obj/item/clothing/head/centhat
	name = "Cent. Comm. hat"
	icon_state = "centcom"
	flags = FPRINT|TABLEPASS
	item_state = "centcom"

/obj/item/clothing/head/det_hat
	name = "hat"
	desc = "Someone who wears this will look very smart"
	icon_state = "detective"

/obj/item/clothing/head/powdered_wig
	name = "powdered wig"
	desc = "A powdered wig"
	icon_state = "pwig"
	item_state = "pwig"

/obj/item/clothing/head/that
	name = "hat"
	desc = "An amish looking hat"
	icon_state = "tophat"
	item_state = "that"

/obj/item/clothing/head/wizard
	name = "wizard hat"
	desc = "It has WIZZARD written across it in sequins"
	icon_state = "wizard"

/obj/item/clothing/head/chefhat
	name = "chef's hat"
	desc = "Bork bork bork!"
	icon_state = "chef"
	item_state = "chef"
	flags = FPRINT | TABLEPASS