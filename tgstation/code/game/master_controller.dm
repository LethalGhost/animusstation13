var/global/datum/controller/game_controller/master_controller //Set in world.New()
var/global/controllernum = "no"

datum/controller/game_controller
	var/processing = 1

	proc
		setup()
		setup_objects()
		process()
		process_mobs()
		process_diseases()
		process_machines()
		process_pipes()
		process_objects()
		process_powernets()

	setup()
		if(master_controller && (master_controller != src))
			del(src)
			return
			//There can be only one master.

		if(!air_master)
			air_master = new /datum/controller/air_system()
			air_master.setup()

		if(!job_master)
			job_master = new /datum/controller/occupations()
			if(job_master.SetupOccupations())
				world << "\red \b Job setup complete"
				job_master.LoadJobs("config/jobs.txt")

		if(!tension_master)
			tension_master = new /datum/tension()

		world.tick_lag = 0.9

		setup_objects()

		setupgenetics()

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

		world << "\red \b Initializations complete."


	process_mobs()
		var/count = 0
		for(var/mob/M in world)
			count++
			
		var/half = count/2
		var/sleeped = 0;
		var/i = 0
		for(var/mob/M in world)
			M.Life()
			if (i>half && sleeped == 0)
				sleep(1)
				sleeped = 1;
			i++
			
	process_diseases()
		for(var/datum/disease/D in active_diseases)
			D.process()
			
	process_machines()
		var/fQuarter = machines.len/4
		var/sQuarter = fQuarter * 2;
		var/tQuarter = fQuarter * 3;
		var/sleeped = 0;
		var/i = 0
		
		for(var/obj/machinery/machine in machines)
			if(machine)
				machine.process()
				if(machine.use_power)
					machine.auto_use_power()
					
			if ((i>fQuarter && sleeped == 0) || (i>sQuarter && sleeped == 1) || (i>tQuarter && sleeped == 2))
				sleep(1)
				sleeped++;
			i++
					
	process_pipes()
		for(var/datum/pipe_network/network in pipe_networks)
			network.process()
			
	process_objects()
		for(var/obj/object in processing_objects)
//			spawn(0)Still need to test the spawn ticker
			object.process()
			
	process_powernets()
		for(var/datum/powernet/P in powernets)
			P.reset()
		
	process()

		if(!processing)
			return 0
		controllernum = "yes"
		spawn (100) controllernum = "no"

		air_master.process()
		
		sleep(1)
		
		tension_master.process()

		sleep(1)

		sun.calc_position()

		sleep(1)

		process_mobs()
		
		sleep(1)
		
		process_machines()
		
		sleep(1)

		process_objects()
		process_diseases()
		process_powernets()
		
		sleep(1)
		
		process_pipes()

		ticker.process()
		
		spawn(1) process()


		return 1