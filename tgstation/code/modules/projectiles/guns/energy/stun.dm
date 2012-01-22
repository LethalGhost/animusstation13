
/obj/item/weapon/gun/energy/taser
	name = "taser gun"
	desc = "A small, low capacity gun used for non-lethal takedowns."
	icon_state = "taser"
	fire_sound = 'Taser.ogg'
	charge_cost = 100
	projectile_type = "/obj/item/projectile/energy/electrode"
	cell_type = "/obj/item/weapon/cell/crap"

/obj/item/weapon/gun/energy/taser/small
	animus = 1
	icon = 'gun_animus.dmi'
	name = "pocket taser gun"
	desc = "A realy small, low capacity service gun used by heads for selfdefence. Slightly stronger than the standard model, but uses more power. Can shot 3 times before recarge needed."
	icon_state = "smalltaser99"
	fire_sound = 'Taser.ogg'
	origin_tech = "combat=4;materials=3;powerstorage=1"
	charge_cost = 166
	w_class = 1.0
	projectile_type = "/obj/item/projectile/energy/electrode/hard"
	cell_type = "/obj/item/weapon/cell/crap"

	update_icon()
		var/ratio = power_supply.charge / power_supply.maxcharge
		ratio = round(ratio, 0.33) * 100
		icon_state = text("smalltaser[]", ratio)

/obj/item/weapon/gun/energy/taser/cyborg/load_into_chamber()//TOOD: change this over to the slowly recharge other cell
	if(in_chamber)
		return 1
	if(isrobot(src.loc))
		var/mob/living/silicon/robot/R = src.loc
		if(R && R.cell)
			R.cell.use(charge_cost)
			in_chamber = new /obj/item/projectile/energy/electrode(src)
			return 1
	return 0



/obj/item/weapon/gun/energy/stunrevolver
	name = "stun revolver"
	desc = "A high-tech revolver that fires stun cartridges. The stun cartridges can be recharged using a conventional energy weapon recharger."
	icon_state = "stunrevolver"
	fire_sound = 'Gunshot.ogg'
	origin_tech = "combat=3;materials=3;powerstorage=2"
	charge_cost = 125
	projectile_type = "/obj/item/projectile/energy/electrode"
	cell_type = "/obj/item/weapon/cell"



/obj/item/weapon/gun/energy/crossbow
	name = "mini energy-crossbow"
	desc = "A weapon favored by many of the syndicates stealth specialists."
	icon_state = "crossbow"
	w_class = 2.0
	item_state = "crossbow"
	m_amt = 2000
	origin_tech = "combat=2;magnets=2;syndicate=5"
	silenced = 1
	fire_sound = 'Genhit.ogg'
	projectile_type = "/obj/item/projectile/energy/bolt"
	cell_type = "/obj/item/weapon/cell/crap"
	var/charge_tick = 0


	New()
		..()
		processing_objects.Add(src)


	Del()
		processing_objects.Remove(src)
		..()


	process()
		charge_tick++
		if(charge_tick < 4) return 0
		charge_tick = 0
		if(!power_supply) return 0
		power_supply.give(100)
		return 1


	update_icon()
		return



/obj/item/weapon/gun/energy/crossbow/largecrossbow
	name = "Energy Crossbow"
	desc = "A weapon favored by syndicate infiltration teams."
	w_class = 4.0
	force = 10
	m_amt = 200000
	projectile_type = "/obj/item/projectile/energy/bolt/large"


