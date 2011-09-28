//statistics
/proc/addJobsStartStatistics(var/key,var/job,var/fromstart=1)
	var/DBConnection/dbcon = new()
	dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
	if(!dbcon.IsConnected())
		return 0

	var/DBQuery/query = dbcon.NewQuery("SELECT id, byondkey, job, [fromstart ? "fromstart" : "afterstart"] FROM jobs")
	query.Execute()

	while(query.NextRow())
		if(key != query.item[2])
			continue
		if(job != query.item[3])
			continue
		var/id = text2num(query.item[1])
		var/count = text2num(query.item[4])
		count++

		query = dbcon.NewQuery("UPDATE jobs SET [fromstart ? "fromstart" : "afterstart"]=\"[count]\" WHERE id=[id]")
		/*if(!query.Execute())
			world << "\green SQL Error: [query.ErrorMsg()]"*/
		query.Execute()
		dbcon.Disconnect()
		return 1

	query = dbcon.NewQuery("INSERT INTO jobs (byondkey, job, fromstart, afterstart) VALUES ('[key]', '[job]', '[fromstart ? 1 : 0]', '[fromstart ? 0 : 1]')")
	/*if(!query.Execute())
		world << "\red SQL Error: <b>[query.ErrorMsg()]</b>"*/
	query.Execute()
	dbcon.Disconnect()
	return 1