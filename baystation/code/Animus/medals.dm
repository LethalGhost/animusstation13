/* Title goes for medal name that should be in byond hub, ex - http://www.byond.com/games/Nikie/AnimusStationMedals
Announce goes for announcement to everybody - 0, or only to player and admins - 1
If end_show var is set to 1, the medal will be added to list of medals that will be announced to everybody
after the round end (after escape phase). You don't need to use it on medals such as "Newborn",
but on those like "Lights out" or "I bring darkness!", since those will spoil the gamemode, or smth
&quot; is a "
*/

var/global/list/end_round_medals

/mob/proc/unlock_medal(title, announce, end_show)
	spawn()
		if(config.medal_hub && config.medal_password)
			if(ismob(src) && src.key)
				if(world.SetMedal(title, src, config.medal_hub, config.medal_password) == 1)
					if(announce)
						world << "<font color=olive><b>[src.key] earned the &quot;[title]&quot; medal.</b></font>"
					if(!announce)
						src << "<font color=olive><b>You earned the &quot;[title]&quot; medal! Only 4 your eyes.</b></font>"
						message_admins("[src.key] earned the &quot;[title]&quot; medal.")
					if(end_show)
						world.add_to_end_medals(title, src.key)

/client/proc/unlock_medal_client(title, announce, end_show) // If src is not a mob (client in starting screen)
	spawn()
		if(config.medal_hub && config.medal_password)
			if(!ismob(src) && src.key)
				if(world.SetMedal(title, src, config.medal_hub, config.medal_password) == 1)
					if(announce)
						world << "<font color=olive><b>[src.key] earned the &quot;[title]&quot; medal.</b></font>"
					if(!announce)
						src << "<font color=olive><b>You earned the &quot;[title]&quot; medal! Only 4 your eyes.</b></font>"
						message_admins("[src.key] earned the &quot;[title]&quot; medal.")
					if(end_show)
						world.add_to_end_medals(title, src.key)

/world/proc/announce_end_medals()
	if(end_round_medals.len)
		world << "<b>Special medals that were achieved during the round:</b>"
		world << "<li>[end_round_medals]</li>"
	else
		world << "<font color=olive><b>No &quot;special&quot; medals were achieved during the round!</b></font>"

/world/proc/add_to_end_medals(title, key)
	if(title && key)
		if(!end_round_medals.len) // check is for proper
			end_round_medals += "    [title] for [key]"
		else
			end_round_medals += "    <br>[title] for [key]"

/world/proc/newborn_medal(client/client)
	spawn()
		if(config.medal_hub && config.medal_password)
			if(client.key)
				if(world.GetMedal("Newborn", client, config.medal_hub, config.medal_password) == 1)
					if(world.SetMedal("Old Generation", client, config.medal_hub, config.medal_password) == 1)
						world << "<font color=olive><b>[client.key] played on the server long time ago and earned the &quot;Old Generation&quot; medal!</b></font>"
				else
					if(world.SetMedal("New Generation", client, config.medal_hub, config.medal_password) == 1)
						world << "<font color=olive><b>[client.key] is playing on the server for the first time and earned the &quot;New Generation&quot; medal!</b></font>"

/client/verb/cmd_medals()
	set category = "OOC"
	set name = "Medals"

	world.hub = config.medal_hub // they say it can be null, but then it won't work
	world.hub_password = config.medal_password

	if(!config.medal_hub || !config.medal_password)
		src << "The medal hub configuration is not set!"
		return

	src << "Stealing your medal information..."

	var/medal
	var/pMedals = world.GetMedal(medal, usr, config.medal_hub) // medal, who, hub // param_Medals
	var/lMedals = params2list(pMedals) // making them a list // list_Medals

	var/medal_got // For output
	var/medal_count = 0 // For counting
	src << "<b>Medals:</b>" // First line
	for (medal_got in lMedals)
		src << "<li>            [medal_got]</li>" // leaving alot of        spaces and showing the medal
		medal_count++ // then counting it

	src << "<b>You have [medal_count] medals.</b>" // and then showing amount of medals
