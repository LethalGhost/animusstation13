/client/proc/warn_key()
	set name = "Warn Key"
	set desc = "Warn easy!"
	set category = "Z"

	var/list/players = new/list()
	for(var/client/C)
		if(!C.mob)
			continue
		players[C.key + " ([C.mob.name])"] = C.mob
	var/mob/M = players[input("Select player to warn","Warn Key")as null|anything in players]
	if(isnull(M))
		return

	warn(M)

/obj/admins/proc/controlpanel()
	set name = "Control panel"
	set category = "Z"
	set desc = "You are admin of admins!"

	if (!istype(src,/obj/admins))
		src = usr.client.holder
	if (!istype(src,/obj/admins))
		usr << "Error: you are not an admin!"
		return

	var/dat = "<html><head><title>Control Panel</title></head>"
	dat += "<b>Control panel</b><br><br>"
	dat += "Files:<br>"
	dat += "<A HREF='?src=\ref[src];controlpanel=readfile'>Read textfile</A><br>"
	dat += "<A HREF='?src=\ref[src];controlpanel=editfile'>Edit textfile</A><br>"
	dat += "<br>"
	dat += "SQL:<br>"
	dat += "Jobs: <A HREF='?src=\ref[src];controlpanel=sql_jobsplayer'>show selected player jobs</A><br>"
	dat += "Jobs: <A HREF='?src=\ref[src];controlpanel=sql_playersjob'>show selected jobs player</A><br>"
	dat += "Karmatotals: <A HREF='?src=\ref[src];controlpanel=sql_karmatotals'>view</A><br>"
	dat += "Karma: <A HREF='?src=\ref[src];controlpanel=sql_karmaspender'>show changes by player</A><br>"
	dat += "Karma: <A HREF='?src=\ref[src];controlpanel=sql_karmareceiver'>show player karma changes</A><br>"
	dat += "<br>"
	dat += "Other:<br>"
	dat += "<A HREF='?src=\ref[src];controlpanel=reloadlaureates'>Reload laureates</A><br>"

	usr << browse(dat, "window=controlpanel")


/obj/admins/Topic(href, href_list)
	..()
	if(href_list["controlpanel"])
		var/dat = "<html><head><title>Control Panel</title></head>"
		dat += "<b>Control panel</b> (<A HREF='?src=\ref[src];controlpanel=returntomenu'>return</A>)<br><br>"
		switch(href_list["controlpanel"])
			if("returntomenu")
				if(usr.client.holder)
					usr.client.holder.controlpanel() //hack?
				return
			if("readfile")
				var/fname = input("Filename","Filename","config/config.txt")
				var/text = file2text(fname)
				if(!text)
					return
				var/list/CL = dd_text2list(text, "\n")
				dat += "<b>[fname]:</b><br><br>"
				for(var/T in CL)
					dat += T
					dat += "<br>"
				usr << browse(dat, "window=controlpanel")
				return
			if("editfile")
				dat += "<font color=red>Attention: Don't be a dick.</font><br>"
				usr << browse(dat, "window=controlpanel")
				var/fname = input("Filename","Filename","config/laureates.txt") as text|null
				if(!fname)
					dat += "Cancelled.<br>"
					usr << browse(dat, "window=controlpanel")
					return
				var/text = file2text(fname)

				var/newtext = input("Edit file:", "Edit file", text) as message|null
				if(!newtext)
					dat += "Cancelled.<br>"
					usr << browse(dat, "window=controlpanel")
					return
				if(fexists(fname))
					fdel(fname)
				if(text2file(newtext,fname))
					dat += "Success!<br>"
				else
					dat += "Error.<br>"
				usr << browse(dat, "window=controlpanel")
				return
			if("reloadlaureates")
				if(alert("WARNING: If someone has already spawn objects, he can do it again!","Reload laureates?","Yes","No") == "Yes")
					load_laureates()
					return
			if("sql_jobsplayer")
				var/player = input("Input player key:","Select player") as text|null
				if(!player)
					return
				var/DBConnection/dbcon = new()
				dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
				if(dbcon.IsConnected())
					var/DBQuery/query = dbcon.NewQuery("SELECT job, fromstart, afterstart FROM jobs WHERE byondkey = '[player]'")
					if(query.Execute())
						dat += "Jobs player [player]:<br>"
						dat += "<table border=1 cellspacing=0><tr><td>Job</td><td>S</td><td>J</td></tr>"
						while(query.NextRow())
							dat += "<tr><td>[query.item[1]]</td><td>[query.item[2]]</td><td>[query.item[3]]</td></tr>"
						dat += "</table>"
					else
						dat += "query.Execute() error: [query.ErrorMsg()]<br>"
				else
					dat += "SQL connection error.<br>"
				usr << browse(dat, "window=controlpanel")
				return
			if("sql_playersjob")
				var/job = input("Input job:","Select job") as text|null
				if(!job)
					return
				var/DBConnection/dbcon = new()
				dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
				if(dbcon.IsConnected())
					var/DBQuery/query = dbcon.NewQuery("SELECT byondkey, fromstart, afterstart FROM jobs WHERE job = '[job]'")
					if(query.Execute())
						dat += "Players job [job]:<br>"
						dat += "<table border=1 cellspacing=0><tr><td>Player</td><td>S</td><td>J</td></tr>"
						while(query.NextRow())
							dat += "<tr><td>[query.item[1]]</td><td>[query.item[2]]</td><td>[query.item[3]]</td></tr>"
						dat += "</table>"
					else
						dat += "query.Execute() error: [query.ErrorMsg()]<br>"
				else
					dat += "SQL connection error.<br>"
				usr << browse(dat, "window=controlpanel")
				return
			if("sql_karmatotals")
				var/show = input("Show what?","View karma") as null|anything in list("More than 5","Less than -5")
				if(!show)
					return
				var/DBConnection/dbcon = new()
				dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
				if(!dbcon.IsConnected())
					dat += "SQL connection error.<br>"
				else
					switch(show)
						if("More than 5")
							var/DBQuery/query = dbcon.NewQuery("SELECT byondkey, karma FROM karmatotals WHERE karma > 5")
							if(query.Execute())
								dat += "Karma:<br>"
								dat += "<table border=1 cellspacing=0><tr><td>Player</td><td>K</td></tr>"
								while(query.NextRow())
									dat += "<tr><td>[query.item[1]]</td><td>[query.item[2]]</td></tr>"
								dat += "</table>"
							else
								dat += "query.Execute() error: [query.ErrorMsg()]<br>"
						if("Less than 5")
							var/DBQuery/query = dbcon.NewQuery("SELECT byondkey, karma FROM karmatotals WHERE karma < -5")
							if(query.Execute())
								dat += "Karma:<br>"
								dat += "<table border=1 cellspacing=0><tr><td>Player</td><td>K</td></tr>"
								while(query.NextRow())
									dat += "<tr><td>[query.item[1]]</td><td>[query.item[2]]</td></tr>"
								dat += "</table>"
							else
								dat += "query.Execute() error: [query.ErrorMsg()]<br>"
				usr << browse(dat, "window=controlpanel")
				return
			if("sql_karmaspender")
				var/spender = input("Input spender key:","Show karma changes") as text|null
				if(!spender)
					return
				var/DBConnection/dbcon = new()
				dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
				if(dbcon.IsConnected())
					var/DBQuery/query = dbcon.NewQuery("SELECT spendername, receiverkey, receivername, receiverrole, receiverspecial, isnegative, time FROM karma WHERE spenderkey = '[spender]'")
					if(query.Execute())
						dat += "Karma spends by [spender]:<br>"
						dat += "<table border=1 cellspacing=0><tr><td>SName</td><td>RKey</td><td>RName</td><td>RRole</td><td><RSpecial></td><td></td><td>Time</td></tr>"
						while(query.NextRow())
							dat += "<tr><td>[query.item[1]]</td><td>[query.item[2]]</td><td>[query.item[3]]</td><td>[query.item[4]]</td><td>[query.item[5]]</td><td>[text2num(query.item[6]) ? "-" : "+"]</td><td>[query.item[7]]</td></tr>"
						dat += "</table>R: Receiver, S: Spender<br>"
					else
						dat += "query.Execute() error: [query.ErrorMsg()]<br>"
				else
					dat += "SQL connection error.<br>"
				usr << browse(dat, "window=controlpanel")
				return
			if("sql_karmareceiver")
				var/receiver = input("Input receiver key:","Show karma changes") as text|null
				if(!receiver)
					return
				var/DBConnection/dbcon = new()
				dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
				if(dbcon.IsConnected())
					var/DBQuery/query = dbcon.NewQuery("SELECT spendername, spenderkey, receivername, receiverrole, receiverspecial, isnegative, time FROM karma WHERE receiverkey = '[receiver]'")
					if(query.Execute())
						dat += "[receiver] karma changes:<br>"
						dat += "<table border=1 cellspacing=0><tr><td>SName</td><td>SKey</td><td>RName</td><td>RRole</td><td><RSpecial></td><td></td><td>Time</td></tr>"
						while(query.NextRow())
							dat += "<tr><td>[query.item[1]]</td><td>[query.item[2]]</td><td>[query.item[3]]</td><td>[query.item[4]]</td><td>[query.item[5]]</td><td>[text2num(query.item[6]) ? "-" : "+"]</td><td>[query.item[7]]</td></tr>"
						dat += "</table>R: Receiver, S: Spender<br>"
					else
						dat += "query.Execute() error: [query.ErrorMsg()]<br>"
				else
					dat += "SQL connection error.<br>"
				usr << browse(dat, "window=controlpanel")
				return