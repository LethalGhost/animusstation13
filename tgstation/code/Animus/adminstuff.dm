/client/proc/warn_key()
	set name = "Warn Key"
	set desc = "Warn easy!"
	set category = "Z"

	var/list/players = new/list()
	for(var/client/C)
		players[C.ckey + " ([C.mob.name])"] = C.mob
	var/mob/M = players[input("Select player to warn","Warn Key")as null|anything in players]
	if(isnull(M))
		return

	warn(M)