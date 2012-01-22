//Baseline portable generator. Has all the default handling. Not intended to be used on it's own (since it generates unlimited power).
/obj/machinery/power/port_gen/pacman_gas
	name = "P.A.C.M.A.N.G.-type Portable Generator"
	desc = "P.A.C.M.A.N. type G portable generator. Uses gas plasma as a fuel source."
	icon = 'machinery_animus.dmi'
	icon_state = "potgasgen000"
	power_gen = 2500
	var
		charge_cell = 1
		obj/item/weapon/tank/plasma/Canister = null
		obj/item/weapon/cell/Cell = null
		board_path = "/obj/item/weapon/circuitboard/pacman_gas"
		heat = 0
		time_per_mole = 50
	emagged = 0
	/*
	process()
	if(P)
		if(P.air_contents.toxins <= 0)
			P.air_contents.toxins = 0
			eject()
		else
			P.air_contents.toxins -= 0.001
	return
	*/

	HasFuel()
		if(Canister && Canister.air_contents.toxins > 0)
			return 1
		return 0

	UseFuel()
		var/needed_gas = 1 / (time_per_mole / power_output)
		var/temp = min(needed_gas, Canister.air_contents.toxins)
		Canister.air_contents.toxins -= temp
		Canister.air_contents.carbon_dioxide += temp
		var/lower_limit = 56 + power_output * 10
		var/upper_limit = 76 + power_output * 10
		var/bias = 0
		if (power_output > 4)
			upper_limit = 400
			bias = power_output * 3
		if (heat < lower_limit)
			heat += 3
		else
			heat += rand(-7 + bias, 7 + bias)
			if (heat < lower_limit)
				heat = lower_limit
			if (heat > upper_limit)
				heat = upper_limit

		if (heat > 300)
			overheat()
			del(src)
		return

	New()
		..()
		component_parts = list()
		component_parts += new /obj/item/weapon/stock_parts/micro_laser(src)
		component_parts += new /obj/item/weapon/cable_coil(src)
		component_parts += new /obj/item/weapon/cable_coil(src)
		component_parts += new /obj/item/weapon/stock_parts/capacitor(src)
		component_parts += new board_path(src)
		RefreshParts()

	update_icon()
		..()
		icon_state = "potgasgen[Cell ? "1" : "0"][Canister ? "1" : "0"][active]"

	RefreshParts()
		var/temp_rating = 0
		var/temp_reliability = 0
		for(var/obj/item/weapon/stock_parts/SP in component_parts)
			//if(istype(SP, /obj/item/weapon/stock_parts/matter_bin))
				//max_coins = SP.rating * SP.rating * 1000
			if(istype(SP, /obj/item/weapon/stock_parts/micro_laser) || istype(SP, /obj/item/weapon/stock_parts/capacitor))
				temp_rating += SP.rating
		for(var/obj/item/weapon/CP in component_parts)
			temp_reliability += CP.reliability
		reliability = min(round(temp_reliability / 4), 100)
		power_gen = round(initial(power_gen) * temp_rating)

	examine()
		..()
		usr << "\blue The generator has [Canister.air_contents.toxins] units of fuel left, producing [power_gen] per cycle."
		if(crit_fail)
			usr << "\red The generator seems to have broken down."

	handleInactive()
		heat -= 2
		if (heat < 0)
			heat = 0
		else
			for(var/mob/M in viewers(1, src))
				if (M.client && M.machine == src)
					src.updateUsrDialog()

	proc
		overheat()
			explosion(src.loc, 2, 5, 2, -1)

	attackby(var/obj/item/O as obj, var/mob/user as mob)
		if(istype(O, /obj/item/weapon/tank/plasma))
			if(Canister)
				user << "\red The generator already has a plasma tank loaded!"
				return
			Canister = O
			user.drop_item()
			O.loc = src
			update_icon()
			user << "\blue You add the plasma tank to the generator."
		else if(istype(O, /obj/item/weapon/cell))
			if(Cell)
				user << "\red The generator already has a cell loaded!"
				return
			Cell = O
			user.drop_item()
			O.loc = src
			update_icon()
			user << "\blue You add the cell to the generator."
		else if (istype(O, /obj/item/weapon/card/emag))
			emagged = 1
			emp_act(1)
		else if(!active)
			if(istype(O, /obj/item/weapon/wrench))
				anchored = !anchored
				playsound(src.loc, 'Deconstruct.ogg', 50, 1)
				update_icon()
				if(anchored)
					user << "\blue You secure the generator to the floor."
				else
					if(!charge_cell)
						charge_cell = 1
					user << "\blue You unsecure the generator from the floor."
				for(var/mob/M in viewers(1, src))
					if (M.client && M.machine == src)
						src.updateUsrDialog()
				makepowernets()
			else if(istype(O, /obj/item/weapon/screwdriver))
				open = !open
				playsound(src.loc, 'Screwdriver.ogg', 50, 1)
				update_icon()
				if(open)
					user << "\blue You open the access panel."
				else
					user << "\blue You close the access panel."
			else if(istype(O, /obj/item/weapon/crowbar) && !open)
				var/obj/machinery/constructable_frame/machine_frame/new_frame = new /obj/machinery/constructable_frame/machine_frame(src.loc)
				for(var/obj/item/I in component_parts)
					if(I.reliability < 100)
						I.crit_fail = 1
					I.loc = src.loc
				if(Canister)
					Canister.loc = src.loc
				if(Cell)
					Cell.loc = src.loc
				new_frame.state = 2
				new_frame.icon_state = "box_1"
				del(src)

	attack_hand(mob/user as mob)
		..()
		interact(user)

	attack_ai(mob/user as mob)
		interact(user)

	attack_paw(mob/user as mob)
		interact(user)

	proc
		interact(mob/user)
			if (get_dist(src, user) > 1 )
				if (!istype(user, /mob/living/silicon/ai))
					user.machine = null
					user << browse(null, "window=port_gen")
					return

			user.machine = src

			var/dat = text("<b>[name]</b><br>")
			if(active)
				dat += text("Generator: <A href='?src=\ref[src];action=disable'>On</A><br>")
			else
				dat += text("Generator: <A href='?src=\ref[src];action=enable'>Off</A><br>")
			if(!anchored)
				dat += text("Send energy to: Cell<br>")
			else
				if(charge_cell)
					dat += text("Send energy to: <A href='?src=\ref[src];action=send_to_powernet'>Cell</A><br>")
				else
					dat += text("Send energy to: <A href='?src=\ref[src];action=send_to_cell'>Powernet</A><br>")
			if(Canister)
				dat += text("Currently loaded plasma tank: [Canister.air_contents.toxins] (<A href='?src=\ref[src];action=eject_canister'>Eject</A>)<br>")
			else
				dat += text("No plasma tank currently loaded.<br>")
			if(Cell)
				dat += text("Currently loaded cell charge: [Cell.charge]/[Cell.maxcharge] (<A href='?src=\ref[src];action=eject_cell'>Eject</A>)<br>")
			else
				dat += text("No cell currently loaded.<br>")
			dat += text("Power output: <A href='?src=\ref[src];action=lower_power'>-</A> [power_gen * power_output * (1 - charge_cell * 0.98)] <A href='?src=\ref[src];action=higher_power'>+</A><br>")
			dat += text("Heat: [heat]<br>")
			dat += "<br><A href='?src=\ref[src];action=close'>Close</A>"
			user << browse("[dat]", "window=port_gen")

	Topic(href, href_list)
//		if(..())
//			return

		src.add_fingerprint(usr)
		if(href_list["action"])
			if(href_list["action"] == "enable")
				if(!active && HasFuel() && !crit_fail)
					active = 1
					update_icon()
					src.updateUsrDialog()
			else if(href_list["action"] == "disable")
				if (active)
					active = 0
					update_icon()
					src.updateUsrDialog()
			else if(href_list["action"] == "send_to_cell")
				if (!charge_cell)
					charge_cell = 1
					update_icon()
					src.updateUsrDialog()
			else if(href_list["action"] == "send_to_powernet")
				if (charge_cell)
					charge_cell = 0
					update_icon()
					src.updateUsrDialog()
			else if(href_list["action"] == "lower_power")
				if(power_output > 1)
					power_output--
					src.updateUsrDialog()
			else if (href_list["action"] == "higher_power")
				if (power_output < 4 || emagged)
					power_output++
					src.updateUsrDialog()
			else if (href_list["action"] == "eject_canister")
				if (Canister)
					Canister.loc = src.loc
					Canister = null
					update_icon()
					src.updateUsrDialog()
			else if (href_list["action"] == "eject_cell")
				if (Cell)
					Cell.loc = src.loc
					Cell.updateicon()
					Cell = null
					update_icon()
					src.updateUsrDialog()
			else if (href_list["action"] == "close")
				usr << browse(null, "window=port_gen")
				usr.machine = null

	process()
		if(active && HasFuel() && !crit_fail)
			if(prob(reliability))
				if(charge_cell)
					Cell.charge += power_gen * power_output * 0.02
					if (Cell.charge >= Cell.maxcharge)
						Cell.charge = Cell.maxcharge
						active = 0
						Cell.loc = src.loc
						Cell.updateicon()
						Cell = null
						update_icon()
				else
					if(anchored)
						add_avail(power_gen * power_output)
					else
						active = 0
						update_icon()
			else if(!recent_fault)
				recent_fault = 1
			else crit_fail = 1
			UseFuel()
			for(var/mob/M in viewers(1, src))
				if (M.client && M.machine == src)
					src.updateUsrDialog()

		else
			if(Canister && Canister.air_contents.toxins <= 0)
				Canister.loc = src.loc
				Canister = null
				update_icon()
				for(var/mob/M in viewers(1, src))
					if (M.client && M.machine == src)
						src.updateUsrDialog()
			if(active)
				active = 0
				update_icon()
			handleInactive()