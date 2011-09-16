//global var
/var/datum/deathmatch/deathmatch = null

//=============
// TEAM DATUM =
//=============
/datum/deathmatchteam
	var/name = "Team"
	var/players_lastname = "Smith"
	//spawn point
	var/spawn_x = 1
	var/spawn_y = 1
	var/spawn_z = 1
	//clothing
	var/jumpsuit = /obj/item/clothing/under/color/grey

	var/list/players = null //ckeys list
	var/list/ghosts = list() //assotiative list, "ckey"=ref on origin mob

	//statistics
	var/deathcount = 0

/datum/deathmatchteam/proc/addplayer(var/player)
	if(!player)
		return
	var/mob/M
	for(var/mob/T in world)
		if(T.ckey == player)
			if(!istype(T,/mob/dead/observer))
				alert("[player] is not observer.")
				return
			ghosts[player] = T
			M = T
			break
	if(!M)
		alert("Cannot find player [player]")
		return
	if(!players)
		players = new/list()
	players += player

/datum/deathmatchteam/proc/spawnplayer(var/player)
	if(!player)
		return
	var/mob/M
	for(var/mob/F in world)
		if(F.ckey == player)
			M = F
			break
	var/mob/living/carbon/human/newhuman = new/mob/living/carbon/human(locate(spawn_x + rand(-1,1), spawn_y + rand(-1,1), spawn_z))
	newhuman.real_name = pick(first_names_male) + " " + players_lastname
	newhuman.name = newhuman.real_name
	//spawn clothing
	//newhuman.equip_if_possible(new jumpsuit(newhuman), newhuman.w_uniform)//it does not work, I do not know why --balagi
	var/obj/item/clothing/under/jsuit = new jumpsuit(newhuman)
	newhuman.w_uniform = jsuit
	jsuit.layer = 20
	newhuman.equip_if_possible(new /obj/item/clothing/shoes/black(newhuman), newhuman.slot_shoes)
	//newhuman.equip_if_possible(new /obj/item/clothing/gloves/black(newhuman), newhuman.slot_gloves)
	sleep(10)
	newhuman.ckey = player

	if(istype(M,/mob/dead/observer))
		if(M != ghosts[player])
			spawn(10)
				del(M)
			M = M:corpse
	if(istype(M, /mob/living/carbon/human))
		if(M.stat == 2)
			deathcount++
		M:brain_op_stage = 4 //lol

/datum/deathmatchteam/Topic(href, href_list)
	if(href_list["command"])
		switch(href_list["command"])
			if("changename")
				name = input("Input new name","Change name",name)
			if("changelastname")
				players_lastname = input("Input new lastname","Change lastname",players_lastname)
			if("changeX")
				spawn_x = input("Input X of spawn point","Input X",spawn_x) as num
			if("changeY")
				spawn_y = input("Input Y of spawn point","Input Y",spawn_y) as num
			if("changeZ")
				spawn_z = input("Input Z of spawn point","Input Z",spawn_z) as num
			if("changejumpsuit")
				usr << "changejumpsuit"
				var/possible_jumpsuits[] = typesof(/obj/item/clothing/under/color) - (/obj/item/clothing/under/color)
				jumpsuit = input("Select jumpsuit!","Jumpsuit") in possible_jumpsuits
			if("jumptospawn")
				usr.loc = locate(spawn_x,spawn_y,spawn_z)
			if("setloc")
				if(alert("Are you sure?","Set loc","Ok","Cancel") == "Ok")
					spawn_x = usr.x
					spawn_y = usr.y
					spawn_z = usr.z
			if("addplayer")
				var/player = input("Input player ckey","New player")
				addplayer(player)
			if("spawn_team")
				for(var/K in players)
					spawnplayer(K)
			if("message_team")
				var/message = sanitize(input("Message to [name]","Team message"))
				if(!message)
					return
				for(var/mob/M in world)
					if(M.ckey in players)
						M << "\blue [message]"
				usr << "\blue You send \"[message]\" to [name]"
	if(href_list["rpage"])
		deathmatch.Topic("",list("command"=href_list["rpage"])) //refresh

//==============
// MATCH DATUM =
//==============
/datum/deathmatch
	var/list/teams = list()

/datum/deathmatch/Topic(href, href_list)
	if(href_list["command"])
		var/dat = "<html><head><title>Deathmatch</title></head>"
		dat += "<b>Deathmatch</b> (<A HREF='?src=\ref[src];command=returntomenu'>return</A>)<br><br>"
		switch(href_list["command"])
			if("returntomenu")
				if(usr.client.holder)
					usr.client.holder.animus_deathmatch() //hack?
			/*if("create")
				deathmatch = new/datum/deathmatch
				//refresh
				if(usr.client.holder)
					usr.client.holder.animus_deathmatch()*/
			if("setup_teams")
				dat += "<b>Setup teams</b> (<A HREF='?src=\ref[src];command=setup_teams'>refresh</A>)<br>"
				if(deathmatch.teams.len)
					for(var/datum/deathmatchteam/team in deathmatch.teams)
						dat += "Name: <A HREF='?src=\ref[team];command=changename;rpage=setup_teams'>[team.name]</A><br>"
						dat += "Players lastname: <A HREF='?src=\ref[team];command=changelastname;rpage=setup_teams'>[team.players_lastname]</A><br>"
						dat += "Spawn point: <A HREF='?src=\ref[team];command=changeX;rpage=setup_teams'>X([team.spawn_x])</A> "
						dat += "<A HREF='?src=\ref[team];command=changeY;rpage=setup_teams'>Y([team.spawn_y])</A> "
						dat += "<A HREF='?src=\ref[team];command=changeZ;rpage=setup_teams'>Z([team.spawn_z])</A>"
						dat += " || <A HREF='?src=\ref[team];command=jumptospawn;rpage=setup_teams'>jump to</A>"
						dat += " || <A HREF='?src=\ref[team];command=setloc;rpage=setup_teams'>set loc</A><br>"
						dat += "Standart clothing:<br>"
						dat += "Jumpsuit: <A HREF='?src=\ref[team];command=changejumpsuit;rpage=setup_teams'>[team.jumpsuit]</A><br>"
						dat += "==============<br>"
				dat += "<A HREF='?src=\ref[src];command=newteam;rpage=setup_teams'>Create new team<br>"
				usr << browse(dat, "window=animus_dm")
			if("newteam")
				var/teamtype = input("Select team:","New team") in list("Thunderdome red","Thunderdome green","Custom")// as null|anything
				if(!teamtype)
					return
				var/datum/deathmatchteam/newdm = new/datum/deathmatchteam
				switch(teamtype)
					if("Thunderdome red")
						newdm.name = "Red team"
						newdm.players_lastname = pick("Stall","Harrow","Sholl")
						newdm.spawn_x = 117
						newdm.spawn_y = 75
						newdm.spawn_z = 2
						newdm.jumpsuit = /obj/item/clothing/under/color/red
					if("Thunderdome green")
						newdm.name = "Green team"
						newdm.players_lastname = pick("Baer","Kadel","Noton")
						newdm.spawn_x = 139
						newdm.spawn_y = 75
						newdm.spawn_z = 2
						newdm.jumpsuit = /obj/item/clothing/under/color/green
				teams += newdm
			if("recruit_teams")
				dat += "<b>Recruit teams</b> (<A HREF='?src=\ref[src];command=recruit_teams'>refresh</A>)<br>"
				dat += "=============<br>"
				for(var/datum/deathmatchteam/team in deathmatch.teams)
					dat += "[team.name]<br>"
					if(team.players)
						for(var/P in team.players)
							dat += "[P]<br>"
					dat += "<A HREF='?src=\ref[team];command=addplayer;rpage=recruit_teams'>Add new player</A><br>"
					dat += "=============<br>"
				usr << browse(dat, "window=animus_dm")
			if("control_teams")
				dat += "<b>Control teams</b> (<A HREF='?src=\ref[src];command=control_teams'>refresh</A>)<br>"
				dat += "=============<br>"
				for(var/datum/deathmatchteam/team in deathmatch.teams)
					dat += "[team.name]<br>"
					dat += "<A HREF='?src=\ref[team];command=spawn_team;rpage=control_teams'>Spawn team</A><br>"
					dat += "<A HREF='?src=\ref[team];command=message_team;rpage=control_teams'>Message to team</A><br>"
					dat += "Team deaths: [team.deathcount]<br>"
					dat += "=============<br>"
				usr << browse(dat, "window=animus_dm")
			if("stop_dm")
				if(alert("Are you sure?","Stop deathmatch","Yes","No") == "Yes")
					for(var/datum/deathmatchteam/team in teams)
						for(var/p in team.ghosts)
							world << "p: [p] ghosts(p): [team.ghosts[p]]"
							var/mob/M = team.ghosts[p]
							M.ckey = p
					del(deathmatch)

	if(href_list["rpage"])
		deathmatch.Topic("",list("command"=href_list["rpage"])) //refresh

//VERB
/obj/admins/proc/animus_deathmatch()
	set name = "Deathmatch"
	set desc = "DM control panel"
	set category = "Z"

	if (!istype(src,/obj/admins))
		src = usr.client.holder
	if (!istype(src,/obj/admins))
		usr << "Error: you are not an admin!"
		return

	var/dat = "<html><head><title>Deathmatch</title></head>"

	dat += "<b>Deathmatch</b><br><br>"
	if(!deathmatch)
		if(alert("Create deathmatch?","Deathmatch","Yes","No") == "No")
			return
		deathmatch = new /datum/deathmatch
		alert("Deathmatch created","Alert")
	dat += "<A HREF='?src=\ref[deathmatch];command=setup_teams'>Setup teams</A><br>"
	if(deathmatch.teams.len)
		dat += "<A HREF='?src=\ref[deathmatch];command=recruit_teams'>Recruit teams</A><br>"
		dat += "<A HREF='?src=\ref[deathmatch];command=control_teams'>Control teams</A><br>"

		dat += "<br><A HREF='?src=\ref[deathmatch];command=stop_dm'>Stop deathmatch (return all players to thier original ghosts)</A><br>"
	else
		dat += "Recruit teams<br>"
		dat += "Control teams<br>"


	usr << browse(dat, "window=animus_dm")