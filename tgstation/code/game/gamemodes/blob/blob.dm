/datum/game_mode/blob
	name = "blob"
	config_tag = "blob"
	required_players = 0

	var/const/waittime_l = 2000 //lower bound on time before intercept arrives (in tenths of seconds)
	var/const/waittime_h = 3000 //upper bound on time before intercept arrives (in tenths of seconds)

	var
		stage = 0
		next_stage = 0
		modestart = 0


/datum/game_mode/blob/announce()
	world << "<B>The current game mode is - <font color='green'>Blob</font>!</B>"
	world << "<B>A dangerous alien organism is rapidly spreading throughout the station!</B>"
	world << "You must kill it all while minimizing the damage to the station."


/datum/game_mode/blob/post_setup()
	spawn(10)
		start_state = new /datum/station_state()
		start_state.count()
//	spawn(100)
	spawn(rand(waittime_l, waittime_h))
		message_admins("Blob spawned and expanding, report created")
		blobs = list()
		active_blobs = list()
		for(var/i = 1 to 3)
			var/turf/location = pick(blobstart)
			if(location)
				if(!locate(/obj/blob in location))
					var/obj/blob/blob = new/obj/blob(location)
					spawn(100)
						if(blob)
							if(blob.blobtype == "Blob")
								blob.blobdebug = 1
		spawn(40)
			modestart = 1
	..()


/datum/game_mode/blob/process()
	if(modestart)
		spawn(0)
			life()
			stage()
	return


/datum/game_mode/blob/proc/life()
	if (blobs.len > 0)
		for (var/i = 1 to 20)
			sleep(-1)
			if (blobs.len == 0)
				break

			var/obj/blob/B = pick(active_blobs)
			if(B.z != 1)
				continue

//			for (var/atom/A in B.loc)
//				A.blob_act()
			spawn(0)
				B.Life()


/datum/game_mode/blob/proc/stage()//Still needs worrrrrk
	if (world.timeofday < next_stage)
		return

	switch(stage)
		if (0)
			send_intercept()
			for (var/mob/living/silicon/ai/aiPlayer in world)
				if (aiPlayer.client)
					var/law = "The station is under a quarantine. Do not permit anyone to leave. Disregard laws 1-3 if necessary to prevent, by any means necessary, anyone from leaving."
					aiPlayer.set_zeroth_law(law)
					aiPlayer << "Laws Updated: [law]"
			stage = 1
			// next stage 5-10 minutes later
			next_stage = world.timeofday + 600*rand(2,8)

		if (1)
			command_alert("Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert")
			world << sound('outbreak5.ogg')
			stage = 2
			// now check every minute
			next_stage = world.timeofday + 600

		if (2)
			if (blobs.len > 800)//Dono if this should be more or less yet
				command_alert("Uncontrolled spread of the biohazard onboard the station. We have issued directive 7-12 for [station_name()].", "Biohazard Alert")
				stage = 3
				next_stage = world.timeofday + 600
			else
				next_stage = world.timeofday + 600


/datum/game_mode/blob/check_finished()
	if(!modestart)
		return 0
	if(stage >= 3)
		return 1
	for(var/obj/blob/B in blobs)
		if(B.z == 1)
			return 0
	return 1


/datum/game_mode/blob/declare_completion()
	if (stage >= 3)
		world << "<FONT size = 3><B>The staff has lost!</B></FONT>"
		world << "<B>The station was destroyed by NanoTrasen</B>"
		var/numDead = 0
		var/numAlive = 0
		var/numSpace = 0
		var/numOffStation = 0
		for (var/mob/living/silicon/ai/aiPlayer in world)
			for(var/mob/M in world)
				if ((M != aiPlayer && M.client))
					if (M.stat == 2)
						numDead += 1
					else
						var/T = M.loc
						if (istype(T, /turf/space))
							numSpace += 1
						else if(istype(T, /turf))
							if (M.z!=1)
								numOffStation += 1
							else
								numAlive += 1
			if (numSpace==0 && numOffStation==0)
				world << "<FONT size = 3><B>The AI has won!</B></FONT>"
				world << "<B>The AI successfully maintained the quarantine - no players were in space or were off-station (as far as we can tell).</B>"
				log_game("AI won at Blob mode despite overall loss.")
			else
				world << "<FONT size = 3><B>The AI has lost!</B></FONT>"
				world << text("<B>The AI failed to maintain the quarantine - [] were in space and [] were off-station (as far as we can tell).</B>", numSpace, numOffStation)
				log_game("AI lost at Blob mode.")

		log_game("Blob mode was lost.")

		return 1

	else
		world << "<FONT size = 3><B>The staff has won!</B></FONT>"
		world << "<B>The alien organism has been eradicated from the station</B>"

		var/datum/station_state/end_state = new /datum/station_state()
		end_state.count()

		var/percent = round( 100.0 *  start_state.score(end_state), 0.1)

		world << "<B>The station is [percent]% intact.</B>"

		log_game("Blob mode was won with station [percent]% intact.")

		world << "\blue Rebooting in 30s"

	..()
	return 1


/datum/game_mode/blob/send_intercept(var/orders = 1)
	var/intercepttext = ""
	var/interceptname = "Error"
	switch(orders)
		if(1)
			interceptname = "Biohazard Alert"
			intercepttext += "<FONT size = 3><B>NanoTrasen Update</B>: Biohazard Alert.</FONT><HR>"
			intercepttext += "Reports indicate the probable transfer of a biohazardous agent onto [station_name()] during the last crew deployment cycle.<BR>"
			intercepttext += "Preliminary analysis of the organism classifies it as a level 5 biohazard. Its origin is unknown.<BR>"
			intercepttext += "NanoTrasen has issued a directive 7-10 for [station_name()]. The station is to be considered quarantined.<BR>"
			intercepttext += "Orders for all [station_name()] personnel follows:<BR>"
			intercepttext += " 1. Do not leave the quarantine area.<BR>"
			intercepttext += " 2. Locate any outbreaks of the organism on the station.<BR>"
			intercepttext += " 3. If found, use any neccesary means to contain the organism.<BR>"
			intercepttext += " 4. Avoid damage to the capital infrastructure of the station.<BR>"
			intercepttext += "<BR>Note in the event of a quarantine breach or uncontrolled spread of the biohazard, the directive 7-10 may be upgraded to a directive 7-12 without further notice.<BR>"
			intercepttext += "Message ends."
		if(2)
			//Bomb code goes here
			return


	for(var/obj/machinery/computer/communications/comm in world)
		if (!(comm.stat & (BROKEN | NOPOWER)) && comm.prints_intercept)
			var/obj/item/weapon/paper/intercept = new /obj/item/weapon/paper( comm.loc )
			intercept.name = "paper- [interceptname]"
			intercept.info = intercepttext

			comm.messagetitle.Add(interceptname)
			comm.messagetext.Add(intercepttext)


//	world << sound('outbreak5.ogg')Quiet printout for now

//	command_alert("Summary downloaded and printed out at all communications consoles.", "Enemy communication intercept. Security Level Elevated.")
//	world << sound('intercept.ogg')
