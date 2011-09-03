// SUITS

/obj/item/clothing/suit
	icon = 'suits.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	flags = FPRINT | TABLEPASS
	var/airflowprot = 0
	var/list/allowed = list(/obj/item/weapon/tank/emergency_oxygen)

/obj/item/clothing/suit/rig
	name = "robust suit"
	desc = "Robust"
	icon_state = "rig"
	item_state = "rig"
	flags = FPRINT|TABLEPASS|PLASMAGUARD
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	permeability_coefficient = 0.02
	protective_temperature = 1000
	heat_transfer_coefficient = 0.02
	gas_transfer_coefficient = 0.01
	airflowprot = 1

/obj/item/clothing/suit/bio_suit
	name = "bio suit"
	desc = "A suit that protects against biological contamination."
	icon_state = "bio_suit"
	item_state = "bio_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	heat_transfer_coefficient = 0.30
	flags = FPRINT|TABLEPASS|PLASMAGUARD

/obj/item/clothing/suit/storage/det_suit
	name = "coat"
	desc = "Someone who wears this means business"
	icon_state = "detective"
	item_state = "det_suit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

/obj/item/clothing/suit/judgerobe
	name = "judge's robe"
	desc = "This robe commands authority"
	icon_state = "judge"
	item_state = "judge"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

/obj/item/clothing/suit/storage/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat"
	item_state = "labcoat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	permeability_coefficient = 0.25
	heat_transfer_coefficient = 0.75

/obj/item/clothing/suit/labcoat/cmo
	name = "chief medical officer's labcoat"
	desc = "Bluer than the standard model."
	allowed = list(/obj/item/weapon/tank/emergency_oxygen, /obj/item/device/analyzer, /obj/item/weapon/dnainjector, /obj/item/weapon/reagent_containers/dropper, /obj/item/weapon/reagent_containers/syringe, /obj/item/device/healthanalyzer/*, /obj/item/device/flashlight/pen*/)
	icon_state = "labcoat_cmo_open"
	item_state = "labcoat_cmo"
	//armor = list(melee = 0, bullet = 0, laser = 2, taser = 2, bomb = 0, bio = 55, rad = 5)

/obj/item/clothing/suit/storage/chef
	name = "chef coat"
	desc = "A fancy chef's coat."
	icon_state = "chef"
	item_state = "chef"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/suit/storage/apron
	name = "apron"
	desc = "A simple blue apron. It has a big pocket on the front you could store something in."
	icon_state = "apron"
	item_state = "apron"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/suit/straight_jacket
	name = "straight jacket"
	desc = "A suit that totally restrains an individual"
	icon_state = "straightjacket"
	item_state = "straightjacket"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/wcoat
	name = "waistcoat"
	icon_state = "vest"
	item_state = "wcoat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/suit/wizrobe
	name = "robe"
	desc = "A magnificent blue robe that seems to radiate power"
	icon_state = "wizard"
	item_state = "wizrobe"
	gas_transfer_coefficient = 0.01 // IT'S MAGICAL OKAY JEEZ +1 TO NOT DIE
	permeability_coefficient = 0.01
	heat_transfer_coefficient = 0.01
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

// ARMOR

/obj/item/clothing/suit/armor/vest
	name = "armor"
	desc = "An armored vest that protects against some damage."
	icon_state = "armor"
	item_state = "armor"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	flags = FPRINT | TABLEPASS | ONESIZEFITSALL

/obj/item/clothing/suit/storage/gearharness
	name = "gear harness"
	desc = "A simple security harness, used for storing small objects"
	icon_state = "gearharness"
	item_state = "gearharness"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	flags = FPRINT | TABLEPASS | ONESIZEFITSALL

/obj/item/clothing/suit/storage/armourrigvest
	name = "armour rig vest"
	desc = "An important looking armoured vest, outfitted with pockets."
	icon_state = "armourrigvest"
	item_state = "armourrigvest"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	flags = FPRINT | TABLEPASS | ONESIZEFITSALL

/obj/item/clothing/suit/armor/a_i_a_ptank
	desc = "A wearable bomb with a health analyzer attached"
	name = "Analyzer/Igniter/Armor/Plasmatank Assembly"
	icon_state = "bomb"
	item_state = "bombvest"
	var/obj/item/device/healthanalyzer/part1 = null
	var/obj/item/device/igniter/part2 = null
	var/obj/item/weapon/tank/plasma/part4 = null
	var/obj/item/clothing/suit/armor/vest/part3 = null
	var/status = 0
	flags = FPRINT | TABLEPASS | CONDUCT | ONESIZEFITSALL
	body_parts_covered = UPPER_TORSO

/obj/item/clothing/suit/armor/captain
	name = "captain's armor"
	icon_state = "caparmor"
	item_state = "caparmor"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/centcomm
	name = "Cent. Com. armor"
	desc = "A suit that protects against some damage."
	icon_state = "centcom"
	item_state = "centcom"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/heavy
	name = "heavy armor"
	desc = "A heavily armored suit that protects against moderate damage."
	icon_state = "heavy"
	item_state = "swat_suit"
	gas_transfer_coefficient = 0.90
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/tdome/red
	name = "thunderdome suit (red)"
	icon_state = "tdred"
	item_state = "tdred"

/obj/item/clothing/suit/armor/tdome/green
	name = "thunderdome suit (green)"
	icon_state = "tdgreen"
	item_state = "tdgreen"

/obj/item/clothing/suit/armor/swat
	name = "swat suit"
	icon_state = "heavy"
	item_state = "heavy"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/riot
	name = "riot suit"
	desc = "Heavy segmented armor designed to help control rioters."
	icon_state = "riotsuit"
	item_state = "riotsuit"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

// FIRE SUITS

/obj/item/clothing/suit/fire
	name = "firesuit"
	desc = "A suit that protects against fire and heat."
	icon_state = "fire"
	item_state = "fire_suit"
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

	protective_temperature = 4500
	heat_transfer_coefficient = 0.01

/obj/item/clothing/suit/fire/heavy
	name = "firesuit"
	desc = "A suit that protects against extreme fire and heat."
	icon_state = "thermal"
	item_state = "ro_suit"

	protective_temperature = 10000
	heat_transfer_coefficient = 0.01

// SPACE SUITS

/obj/item/clothing/suit/space
	name = "space suit"
	desc = "A suit that protects against low pressure environments."
	icon_state = "space"
	gas_transfer_coefficient = 0.01
	item_state = "s_suit"
	flags = FPRINT | TABLEPASS | SUITSPACE | PLASMAGUARD
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	permeability_coefficient = 0.02
	protective_temperature = 1000
	heat_transfer_coefficient = 0.02

/obj/item/clothing/suit/space/syndicate
	name = "red space suit"
	icon_state = "syndicate"
	item_state = "space_suit_syndicate"