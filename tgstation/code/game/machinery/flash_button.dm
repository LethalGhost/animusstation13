
/obj/machinery/flash_control
	var/list/obj/machinery/flasher/targets = list()

	New()
		..()
		spawn(20)
			for(var/obj/machinery/flasher/F in world)
				if(F.id == src.id)
					targets += F
			if(targets.len==0)
				stat |= BROKEN
			update_icon()
			return
		return

	attack_ai(mob/user as mob)
		return src.attack_hand(user)

	attack_paw(mob/user as mob)
		return src.attack_hand(user)

	attackby(obj/item/weapon/W, mob/user as mob)
		if(istype(W, /obj/item/device/detective_scanner))
			return
		return src.attack_hand(user)

	attack_hand(mob/user as mob)
		if(stat & (NOPOWER|BROKEN))
			return
		if(active)
			return

		use_power(5)

		active = 1
		icon_state = "launcheract"

		for(var/obj/machinery/flasher/F in targets)
			F.flash()

		sleep(50)

		icon_state = "launcherbtt"
		active = 0

		return