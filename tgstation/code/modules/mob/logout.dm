/mob/Logout()
	log_access("Logout: [key_name(src)]")
	if (admins[key_name(src)])
		message_admins("Admin logout: [key_name(src)]")
	src.logged_in = 0

	..()

	return 1