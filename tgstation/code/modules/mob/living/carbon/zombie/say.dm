/mob/living/carbon/zombie/say(var/message)
	for(var/datum/disease/pierrot_throat/D in viruses)
		var/list/temp_message = dd_text2list(message, " ")
		var/list/pick_list = list()
		for(var/i = 1, i <= temp_message.len, i++)
			pick_list += i
		for(var/i=1, ((i <= D.stage) && (i <= temp_message.len)), i++)
			if(prob(5 * D.stage))
				var/H = pick(pick_list)
				if(findtext(temp_message[H], "*") || findtext(temp_message[H], ";") || findtext(temp_message[H], ":")) continue
				temp_message[H] = "HONK"
				pick_list -= H
			message = dd_list2text(temp_message, " ")
	..(message)

/mob/living/carbon/zombie/say_understands(var/other)
	if (istype(other, /mob/living/silicon/ai))
		return 1
	if (istype(other, /mob/living/silicon/decoy))
		return 1
	if (istype(other, /mob/living/silicon/pai))
		return 1
	if (istype(other, /mob/living/silicon/robot))
		return 1
	if (istype(other, /mob/living/carbon/brain))
		return 1
	if (istype(other, /mob/living/carbon/metroid))
		return 1
	return ..()