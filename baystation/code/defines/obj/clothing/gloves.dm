/obj/item/clothing/gloves
	name = "gloves"
	icon = 'gloves.dmi'
	protective_temperature = 400
	heat_transfer_coefficient = 0.25
	w_class = 2.0
	siemens_coefficient = 0.50
	var/elecgen = 0
	var/uses = 0
	body_parts_covered = HANDS

/obj/item/clothing/gloves/black
	name = "black gloves"
	desc = "These gloves are fire-resistant."
	icon_state = "black"
	item_state = "bgloves"
	protective_temperature = 1500
	heat_transfer_coefficient = 0.01

/obj/item/clothing/gloves/cyborg
	name = "cyborg gloves"
	desc = "beep boop borp"
	icon_state = "black"
	item_state = "r_hands"
	siemens_coefficient = 1.0

/obj/item/clothing/gloves/latex
	name = "latex gloves"
	icon_state = "latex"
	item_state = "lgloves"
	siemens_coefficient = 0.30

	protective_temperature = 310
	heat_transfer_coefficient = 0.90

/obj/item/clothing/gloves/swat
	name = "SWAT gloves"
	desc = "These tactical gloves are somewhat fire and impact-resistant."
	icon_state = "black"
	item_state = "swat_gl"
	siemens_coefficient = 0.30

	protective_temperature = 1100
	heat_transfer_coefficient = 0.05

/obj/item/clothing/gloves/stungloves/
	name = "stungloves"
	desc = "These gloves are electrically charged."
	icon_state = "yellow"
	item_state = "ygloves"
	siemens_coefficient = 0.30
	elecgen = 1
	uses = 10

/obj/item/clothing/gloves/yellow
	name = "insulated gloves"
	desc = "These gloves are electrically insulated."
	icon_state = "yellow"
	item_state = "ygloves"
	siemens_coefficient = 0
	protective_temperature = 1000
	heat_transfer_coefficient = 0.01

/obj/item/clothing/gloves/green
	name = "green gloves"
	desc = "Fancy green gloves with fancy gold embroidery."
	icon_state = "green"
	item_state = "greengloves"
	siemens_coefficient = 0.30
	protective_temperature = 1100
	heat_transfer_coefficient = 0.05

/obj/item/clothing/gloves/red
	name = "red gloves"
	desc = "Heavily padded heavy-duty red gloves."
	icon_state = "red"
	item_state = "redgloves"
	siemens_coefficient = 0.30
	protective_temperature = 1100
	heat_transfer_coefficient = 0.05