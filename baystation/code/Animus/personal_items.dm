/obj/item/weapon/reagent_containers/food/snacks/fortunecookie/good_luck
	New()
		var/obj/item/weapon/paper/paper = new(src)
		paper.info = "Good luck!"
		..()

/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/threemileisland
	New()
		..()
		reagents.add_reagent("threemileisland", 50)
		on_reagent_change()

var/list/laureates = list(
	"rastaf0" = list(
		"Cup" = /obj/item/weapon/reagent_containers/food/drinks/golden_cup/tournament_26_06_2011,
		"Cookie" = /obj/item/weapon/reagent_containers/food/snacks/fortunecookie/good_luck,
	),
	"perpentach" = list(
		"Cookie" = /obj/item/weapon/reagent_containers/food/snacks/fortunecookie/good_luck,
	),
	"sloopoke" = list(
		"Walking stick" = /obj/item/weapon/staff/stick,
	),
	"randysandy" = list(
		"Premium Havanian Cigar" = /obj/item/clothing/mask/cigarette/cigar/havanian,
	),
	"morfei" = list(
		"" = /obj/item/weapon/reagent_containers/food/drinks/drinkingglass/threemileisland,
	),
	"michaelshepard" = list(
		"зачем бы тебе это понадобилось?" = /obj/item/weapon/banhammer,
	),
	"new4life" = list(
		"Трость" = /obj/item/weapon/cane,
	),
	
	
	
	
// 	"" = list(
// 		"" = /obj/item/clothing/mask/cigarette/cigar/havanian,
// 	),
	
	
	
	
)

/client/proc/spawn_personal_item()
	set name = "Spawn personal item"
	set category = "OOC"
	var/mob/living/carbon/human/H = usr
	if (!istype(H))
		usr << "\red Wrong mob! Must be a human!"
		return
	var/list/items = laureates[usr.ckey]
	if (!items)
		usr << "\red You do not have any awards or personal items!"
		return
	var/selected_path
	if (items.len > 1)
		var/choise = input("Select an item") as null|anything in items
		if (isnull(choise))
			return
		selected_path = items[choise]
		items -= choise
	else
		selected_path = items[items[1]]
		items.len = 0
		H.verbs -= /client/proc/spawn_personal_item
	var/obj/spawned = new selected_path(H)
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
	
