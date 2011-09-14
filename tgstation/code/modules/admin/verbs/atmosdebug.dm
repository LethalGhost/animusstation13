var/show_atmo_time = 0

/client/proc/atmosscan()
	set category = "Mapping"
	set name = "Check Plumbing"
	if(!src.authenticated || !src.holder)
		src << "Only administrators may use this command."
		return

	for (var/obj/machinery/atmospherics/plumbing in world)
		if (plumbing.nodealert)
			usr << "Unconnected [plumbing.name] located at [plumbing.x],[plumbing.y],[plumbing.z] ([get_area(plumbing.loc)])"

/client/proc/toggle_atmopipe()
	set category = "Debug"
	set name = "Show atmo timing"
	show_atmo_time = !show_atmo_time