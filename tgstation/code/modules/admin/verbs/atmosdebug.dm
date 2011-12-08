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
	usr << "Show_atmo_time is now [show_atmo_time ? "On" : "Off"]"

/client/proc/delete_atmopipes()
	set category = "Debug"
	set name = "Delete Pipes"
	if(!src.authenticated || !src.holder)
		src << "Only administrators may use this command."
		return
	if(alert("Are you REALLY sure you want to delete all pipes in world? It's irreversible.","YOU ARE AN IDIOT?", "Yes", "No")=="Yes")
		log_admin("[key_name(usr)] uses delete_atmopipes button")
		message_admins("[key_name_admin(usr)] clicked on delete_atmopipes! Prepare to LAAAAAAAAGS", 1)
		for(var/obj/machinery/meter/M in world)
			del(M)
		for(var/obj/machinery/atmospherics/A in world)
			del(A)