var/global/datum/controller/game_controller/master_controller //Set in world.New()
var/global/controllernum = "no"

datum/controller/game_controller
	var/processing = 1

	proc
		setup()
		setup_objects()
		process()

	setup()
		if(master_controller && (master_controller != src))
			del(src)
			return
			//There can be only one master.

		if(!air_master)
			air_master = new /datum/controller/air_system()
			air_master.setup()

		world.tick_lag = 0.9

		setup_objects()

		setupgenetics()

		//setupcorpses() Not used any more.
		syndicate_code_phrase = generate_code_phrase()//Sets up code phrase for traitors, for the round.
		syndicate_code_response = generate_code_phrase()

		emergency_shuttle = new /datum/shuttle_controller/emergency_shuttle()

		if(!ticker)
			ticker = new /datum/controller/gameticker()

		spawn
			ticker.pregame()

	setup_objects()
		world << "\red \b Initializing objects"
		sleep(-1)

		for(var/obj/object in world)
			object.initialize()

		world << "\red \b Initializing pipe networks"
		sleep(-1)

		for(var/obj/machinery/atmospherics/machine in world)
			machine.build_network()

		world << "\red \b Initializing atmos machinery."
		sleep(-1)
		for(var/obj/machinery/atmospherics/unary/vent_pump/T in world)
			T.broadcast_status()
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/T in world)
			T.broadcast_status()

		/*world << "\red \b Initializing atmos machinery"
		sleep(-1)

		find_air_alarms()*/

		world << "\red \b Initializations complete."


	process()

		if(!processing)
			return 0
		//world << "Processing"
		controllernum = "yes"
		spawn (100) controllernum = "no"

		var/start_time = world.timeofday

		air_master.process()

		sleep(1)

		sun.calc_position()

		sleep(-1)

		for(var/mob/M in world)
			M.Life()

		sleep(-1)

		for(var/datum/disease/D in active_diseases)
			D.process()

		for(var/obj/machinery/machine in machines)
			if(machine)
				machine.process()
				if(machine && machine.use_power)
					machine.auto_use_power()


		sleep(-1)
		sleep(1)

		for(var/obj/object in processing_objects)
//			spawn(0)Still need to test the spawn ticker
			object.process()
		var/loctime
		loctime = world.timeofday
		for(var/datum/pipe_network/network in pipe_networks)
			network.process()
		if(show_atmo_time)
			world << "\red Process pipe network\n"
			loctime = world.timeofday  - loctime
			world << loctime

		for(var/datum/powernet/P in powernets)
			P.reset()

		sleep(-1)

		ticker.process()

		sleep(world.timeofday+10-start_time)

		spawn process()


		return 1