/client/proc/InfectMob(mob/living/carbon/M as mob in world)	// Targetted infection
	set category = "Special Verbs"
	set name = "Direct Infection"

	if(!authenticated || !holder)
		src << "Only administrators may use this command."
		return
	var/list/viruses = get_premaded_diseases()
	var/V = input("Choose the virus to spread", "BIOHAZARD") in viruses
	if(V != "cancel")
		if(!M.virus2)
			M.virus2 = new /datum/disease2/disease
			M.virus2.makespecial(V)
			message_admins("Direct infection: [key_name_admin(usr)] infected [M.name]/[M.ckey] by [V]", 1)
		else
			src << "[M.name] is already infected."

/proc/change_message_by_virus(var/message, var/datum/disease2/disease/virus)
	switch(virus.say_tag)
		if("pierrot")
			var/list/temp_message = dd_text2list(message, " ")
			var/list/pick_list = list()
			for(var/i = 1, i <= temp_message.len, i++)
				pick_list += i
			for(var/i=1, ((i <= virus.stage) && (i <= temp_message.len)), i++)
				if(prob(5 * virus.stage))
					var/H = pick(pick_list)
					if(findtext(temp_message[H], "*") || findtext(temp_message[H], ";") || findtext(temp_message[H], ":")) continue
					temp_message[H] = "ÊÎÊÎÊÎ"
					pick_list -= H
			message = dd_list2text(temp_message, " ")
	return message

