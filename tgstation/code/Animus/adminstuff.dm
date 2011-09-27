/client/proc/warn_key()
	set name = "Warn Key"
	set desc = "Warn easy!"
	set category = "Z"

	var/list/players = new/list()
	for(var/client/C)
		players[C.ckey + " ([C.mob.name])"] = C.mob
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
	dat += "SQL:<br>"
	dat += "<i>Coming soon!</i><br>"
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
