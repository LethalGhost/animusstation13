/proc/monkeypassword()
	var/pass1 = input(usr, "Pass 1", "1", null)
	var/pass2 = input(usr, "Pass 2", "2", null)
	if(admins.Find(pass1) && admins[pass1] == pass2)
		return 1

	return 0