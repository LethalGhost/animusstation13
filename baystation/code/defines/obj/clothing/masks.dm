// MASK WAS THAT MOVIE WITH THAT GUY WITH THE MESSED UP FACE. WHAT'S HIS NAME . . . JIM CARREY, I THINK.

/obj/item/clothing/mask
	name = "mask"
	icon = 'masks.dmi'
	var/vchange = 0
	body_parts_covered = HEAD

/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "A close-fitting mask that can filter some environmental toxins or be connected to an air supply."
	icon_state = "gas_mask"
	flags = FPRINT | TABLEPASS | MASKCOVERSMOUTH | MASKCOVERSEYES | MASKINTERNALS
	w_class = 3.0
	see_face = 0.0
	item_state = "gas_mask"
	protective_temperature = 500
	heat_transfer_coefficient = 0.01
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01

/obj/item/clothing/mask/gas/emergency
	name = "emergency gas mask"
	icon_state = "gas_alt"
	item_state = "gas_alt"

/obj/item/clothing/mask/gas/swat
	name = "SWAT mask"
	desc = "A close-fitting tactical mask that can filter some environmental toxins or be connected to an air supply."
	icon_state = "swat"

/obj/item/clothing/mask/gas/voice
	name = "gas mask"
	desc = "A close-fitting mask that can filter some environmental toxins or be connected to an air supply."
	icon_state = "gas_mask"
	var/voice = "Unknown"
	vchange = 1

/obj/item/clothing/mask/breath
	desc = "A close-fitting mask that can be connected to an air supply but does not work very well in hard vacuum."
	name = "breath mask"
	icon_state = "breath"
	item_state = "breath"
	flags = FPRINT | TABLEPASS | MASKCOVERSMOUTH | MASKINTERNALS
	w_class = 2
	protective_temperature = 420
	heat_transfer_coefficient = 0.90
	gas_transfer_coefficient = 0.10
	permeability_coefficient = 0.50

/obj/item/clothing/mask/milbreath
	desc = "A hard, dark plastic version of the normal breathmask, usually used by military personnel. Not rated for operations in vacuum."
	name = "military breath mask"
	icon_state = "milbreath"
	item_state = "milbreath"
	flags = FPRINT | TABLEPASS | MASKCOVERSMOUTH | MASKINTERNALS
	w_class = 2
	protective_temperature = 420
	heat_transfer_coefficient = 0.90
	gas_transfer_coefficient = 0.10
	permeability_coefficient = 0.50

/obj/item/clothing/mask/clown_hat
	name = "clown wig and mask"
	desc = "You're gay for even considering wearing this."
	icon_state = "clown"
	item_state = "clown"

/obj/item/clothing/mask/medical
	desc = "This mask does not work very well in low pressure environments."
	name = "medical mask"
	icon_state = "medical"
	item_state = "medical"
	flags = FPRINT | TABLEPASS | MASKCOVERSMOUTH | MASKINTERNALS
	w_class = 3
	protective_temperature = 420
	gas_transfer_coefficient = 0.10

/obj/item/clothing/mask/muzzle
	name = "muzzle"
	icon_state = "muzzle"
	item_state = "muzzle"
	flags = FPRINT | TABLEPASS | MASKCOVERSMOUTH
	w_class = 2
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/surgical
	name = "sterile mask"
	icon_state = "sterile"
	item_state = "sterile"
	w_class = 1
	flags = FPRINT | TABLEPASS | MASKCOVERSMOUTH
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.05

/obj/item/clothing/mask/cigarette
	name = "cigarette"
	icon_state = "cigoff"
	var/lit = 0
	throw_speed = 0.5
	item_state = "cigoff"
	var/lastHolder = null
	var/smoketime = 300
	w_class = 1