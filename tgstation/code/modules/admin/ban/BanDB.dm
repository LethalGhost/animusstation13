//sql bans by BalaGi. 14.10.2011


var/CMinutes = null

/proc/UpdateTime()
	CMinutes = round((world.realtime / 10) / 60)
	return 1


/proc/CheckBan(var/client/clientvar)
	var/id = clientvar.computer_id
	var/key = clientvar.ckey

	var/DBConnection/dbcon = new()
	dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
	if(dbcon.IsConnected())

		var/DBQuery/query_set
		query_set= dbcon.NewQuery("SET NAMES 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET CHARACTER SET 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET SESSION collation_connection = 'cp1251_general_ci';")
		query_set.Execute()

		var/DBQuery/query = dbcon.NewQuery("SELECT reason, expires, id FROM bans WHERE byondkey = '[key]' || computerid = '[id]'")
		if(query.Execute())
			while(query.NextRow())
				var/minutes = text2num(query.item[2])
				if(minutes == 0)
					return "[query.item[1]]\n(This is a permanent ban)"
				var/timeleft =  GetExp(minutes)
				if(timeleft)
					return "[query.item[1]]\n(This ban will be automatically removed in [timeleft].)"
				else //expired ban
					RemoveBan(text2num(query.item[3]), "EXPIRED")
		dbcon.Disconnect()
	return 0

/proc/AddBan(ckey, computerid, reason, bannedby, temp, minutes, nolog = 0)
	var/bantimestamp
	if(temp)
		UpdateTime()
		bantimestamp = num2text(CMinutes + minutes,20)
	else
		bantimestamp = 0

	var/DBConnection/dbcon = new()
	dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
	if(dbcon.IsConnected())

		var/DBQuery/query_set
		query_set= dbcon.NewQuery("SET NAMES 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET CHARACTER SET 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET SESSION collation_connection = 'cp1251_general_ci';")
		query_set.Execute()

		var/DBQuery/query = dbcon.NewQuery("SELECT id FROM bans WHERE byondkey = '[ckey]' || computerid = '[computerid]'")
		if(query.Execute())
			while(query.NextRow())
				usr << "\red Ban already exists. BanID = [query.item[1]]"
				dbcon.Disconnect()
				return 0
		query = dbcon.NewQuery("INSERT INTO bans (byondkey, computerid, reason, bannedby, expires) VALUES ('[ckey]', '[computerid]', '[reason]', '[bannedby]', '[bantimestamp]')")
		if(query.Execute())
			if(!nolog)
				dblog_ban_unban("ban",bannedby,ckey,"add","Reason: [reason]. Duration: [minutes] minutes.")
		dbcon.Disconnect()
		return 1
	return 0

/proc/GetExp(minutes as num)
	UpdateTime()
	var/exp = minutes - CMinutes
	if (exp > 0)
		var/timeleftstring
		if (exp >= 1440) //1440 = 1 day in minutes
			timeleftstring = "[round(exp / 1440, 0.1)] Days"
		else if (exp >= 60) //60 = 1 hour in minutes
			timeleftstring = "[round(exp / 60, 0.1)] Hours"
		else
			timeleftstring = "[exp] Minutes"
		return timeleftstring
	else
		return 0

/proc/RemoveBan(banid, remover)
	var/DBConnection/dbcon = new()
	dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
	if(dbcon.IsConnected())

		var/DBQuery/query_set
		query_set= dbcon.NewQuery("SET NAMES 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET CHARACTER SET 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET SESSION collation_connection = 'cp1251_general_ci';")
		query_set.Execute()

		var/DBQuery/query = dbcon.NewQuery("SELECT byondkey, reason, bannedby, expires FROM bans WHERE id=[banid]")
		if(query.Execute())
			if(!query.NextRow())
				return 0
			var/logmessage
			if(remover == "EXPIRED")
				UpdateTime()
				var/ago = CMinutes - text2num(query.item[4])
				logmessage = "Ban by [query.item[3]] expired [ago] minutes ago."
			else
				logmessage = "Banned by [query.item[3]] with reason: [query.item[2]]. Remaining time: [GetExp(text2num(query.item[4]))]"
			dblog_ban_unban("ban", remover, query.item[1], "remove", logmessage)
			query = dbcon.NewQuery("DELETE FROM bans WHERE id=[banid]")
			if(query.Execute())
				return 1
			else
				return 0
	else
		return 0

/obj/admins/proc/unbanpanel()
	var/count = 0
	var/dat = ""

	var/DBConnection/dbcon = new()
	dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
	if(dbcon.IsConnected())

		var/DBQuery/query_set
		query_set= dbcon.NewQuery("SET NAMES 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET CHARACTER SET 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET SESSION collation_connection = 'cp1251_general_ci';")
		query_set.Execute()

		var/DBQuery/query = dbcon.NewQuery("SELECT id, byondkey, bannedby, reason, expires FROM bans ORDER BY time DESC")
		if(query.Execute())
			while(query.NextRow())
				var/bantime = text2num(query.item[5])
				var/expbantime = GetExp(bantime)
				if(bantime == 0 || expbantime)
					dat += "<tr><td><A href='?src=\ref[src];unbanf=[query.item[1]];unbankey=[query.item[2]]'>(U)</A><A href='?src=\ref[src];unbane=[query.item[1]];unbankey=[query.item[2]]'>(E)</A> Key: <B>[query.item[2]]</B></td><td>[bantime ? expbantime : "Permaban"]</td><td>By: [query.item[3]]</td><td>Reason: [query.item[4]]</td></tr>"
					count++
		dat += "</table>"
		dat = "<HR><B>Bans:</B> <FONT COLOR=blue>(U) = Unban , (E) = Edit Ban</FONT> - <FONT COLOR=green>([count] Bans)</FONT><HR><table border=1 rules=all frame=void cellspacing=0 cellpadding=3 >[dat]"
	else
		dat += "SQL Connection error."
	usr << browse(dat, "window=unbanp;size=875x400")

//logging
//bantype: "ban" or "job"
//action: "add","edit" or "remove"
/proc/dblog_ban_unban(bantype, adminkey, targetkey, action, notes)
	var/DBConnection/dbcon = new()
	dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
	if(dbcon.IsConnected())

		var/DBQuery/query_set
		query_set= dbcon.NewQuery("SET NAMES 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET CHARACTER SET 'cp1251';")
		query_set.Execute()
		query_set= dbcon.NewQuery("SET SESSION collation_connection = 'cp1251_general_ci';")
		query_set.Execute()

		var/DBQuery/query = dbcon.NewQuery("INSERT INTO banslog (bantype, adminkey, targetkey, action, notes) VALUES ('[bantype]', '[adminkey]', '[targetkey]', '[action]', '[notes]')")
		query.Execute()
	return