/obj/item/clothing/glasses
	name = "glasses"
	icon = 'glasses.dmi'
	w_class = 2.0
	flags = GLASSESCOVERSEYES

/obj/item/clothing/glasses/blindfold
	name = "blindfold"
	icon_state = "blindfold"
	item_state = "blindfold"

/obj/item/clothing/glasses/meson
	name = "optical meson scanner"
	icon_state = "meson"
	item_state = "glasses"

/obj/item/clothing/glasses/regular
	name = "prescription glasses"
	desc = "Can you see me now?"
	icon_state = "glasses"
	item_state = "glasses"

/obj/item/clothing/glasses/sunglasses
	name = "sunglasses"
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks many flashes."
	icon_state = "sun"
	item_state = "sunglasses"
	protective_temperature = 1300
	var/already_worn = 0

/obj/item/clothing/glasses/thermal
	name = "sunglasses"
	desc = "These don't look like ordinary sunglasses."
	icon_state = "sun"
	item_state = "glasses"