/obj/machinery/console
	name = "computer"
	icon = 'computer.dmi'
	density = 1
	anchored = 1.0
	var/brightnessred = 2
	var/brightnessgreen = 2
	var/brightnessblue = 2

/obj/machinery/console/meteorhit(var/obj/O as obj)
	for(var/x in src.verbs)
		src.verbs -= x
	set_broken()
	var/datum/effects/system/harmless_smoke_spread/smoke = new /datum/effects/system/harmless_smoke_spread()
	smoke.set_up(5, 0, src)
	smoke.start()
	return

/obj/machinery/console/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
			return
		if(2.0)
			if (prob(50))
				for(var/x in src.verbs)
					src.verbs -= x
				set_broken()
		if(3.0)
			if (prob(25))
				for(var/x in src.verbs)
					src.verbs -= x
				set_broken()
		else
	return

//