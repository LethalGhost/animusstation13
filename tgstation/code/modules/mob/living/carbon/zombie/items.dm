/obj/item/weapon/melee/zombie/claw
	name = "claws"
	desc = "Your claws!"
	icon = 'zombies.dmi'
	icon_state = "zombieclaw"
	force = 25.0

/obj/item/weapon/melee/zombie/claw/dropped()
	spawn(1)
		var/mob/living/carbon/zombie/Z = usr
		Z.restore_claws()
		del(src)

//walking on broken glass!
/obj/item/clothing/shoes/zombieboots
	name = "zombieboots"
	icon = null
	icon_state = null
	canremove = 0

/mob/living/carbon/zombie/proc/restore_claws()
	var/obj/item/I
	if(!istype(l_hand,/obj/item/weapon/melee/zombie/claw))
		I = new/obj/item/weapon/melee/zombie/claw(src)
		src.l_hand = I
		I.layer = 20
	if(!istype(r_hand,/obj/item/weapon/melee/zombie/claw))
		I = new/obj/item/weapon/melee/zombie/claw(src)
		src.r_hand = I
		I.layer = 20