// "Main" clothing file. Look to clothing folder for actual clothing.
// Gimmicks moved to obj\clothing\gimmick.dm for all of your gay fantasy roleplay dress-up shenanigans.

/obj/item/clothing
	name = "clothing"
//	var/obj/item/clothing/master = null

	var/see_face = 1.0
	var/color = null

	var/body_parts_covered = 0 //see setup.dm for appropriate bit flags

	var/protective_temperature = 0
	var/heat_transfer_coefficient = 1 //0 prevents all transfers, 1 is invisible
	var/gas_transfer_coefficient = 1 // for leaking gas from turf to mask and vice-versa (for masks right now, but at some point, i'd like to include space helmets)
	var/permeability_coefficient = 1 // for chemicals/diseases
	var/siemens_coefficient = 1 // for electrical admittance/conductance (electrocution checks and shit)

// Thats stuff just doesn't deserves own file

/obj/item/clothing/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature >= 373.15 && protective_temperature < exposed_temperature)
		for(var/mob/M in viewers(5, src))
			M << "\red \the [src] burns up."
		del(src)

/obj/item/clothing/ears
	name = "ears"
	w_class = 1.0
	throwforce = 2

/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	icon_state = "earmuffs"
	protective_temperature = 500
	item_state = "earmuffs"





