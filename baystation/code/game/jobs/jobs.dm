var/list/occupations = list(
	"Counselor",
	"Chef",
	"Barman",
	"Janitor",
	"Archaeologist", "Archaeologist",
	"Quartermaster", "Quartermaster", "Quartermaster",
	"Head of Personnel",
	"Security Officer", "Security Officer", "Security Officer", "Security Officer", "Security Officer",
	"Forensic Technician",
	"Detective",
	"Head of Security",
	"Scientist", "Scientist", "Scientist",
	"Anomalist",
	"Roboticist",
	"Hydroponicist",
	"Research Director",
	"Medical Doctor", "Medical Doctor",
	"Surgeon",
	"Geneticist",
	"Virologist",
	"Chemist",
	"Chief Medical Officer",
	"Engineer", "Engineer", "Engineer", "Engineer", "Engineer",
	"Atmospheric Technician", "Atmospheric Technician", "Atmospheric Technician",
	"Chief Engineer",
	"AI") // no captain?

var/list/assistant_occupations = list(
	"Unassigned")

/proc/IsResearcher(var/job)
	switch(job)
		if("Genticist")
			return 1
		if("Scientist")
			return 1
		if("Medical Doctor")
			return 1
		if("Roboticist")
			return 1
		if("Hydroponicist")
			return 1
		if("Anomalist")
			return 1
		if("Research Director")
			return 2
		else
			return 0

/proc/GetRank(var/job) // as I understand: 1 - normal jobs, 2 - security related
	switch(job) // 3 - head, 4 - bigger head (hop, captain)
		if("Unassigned")
			return 0
		if("Engineer")
			return 1
		if("Security Officer")
			return 2
		if("Forensic Technician")
			return 2
		if("Detective")
			return 2
		if("Geneticist")
			return 1
		if("Scientist")
			return 1
		if("Anomalist")
			return 1
		if("Surgeon")
			return 1
		if("Virologist")
			return 1
		if("Archaeologist")
			return 1
		if("Chief Medical Officer")
			return 3
		if("Atmospheric Technician")
			return 1
		if("Medical Doctor")
			return 1
		if("Head of Personnel")
			return 4
		if("Head of Security")
			return 3
		if("Chief Engineer")
			return 3
		if("Research Director")
			return 3
		if("Counselor")
			return 1
		if("Roboticist")
			return 1
		if("Hydroponicist")
			return 1
		if("Barman")
			return 0
		if("Chef")
			return 0
		if("Janitor")
			return 0
		if("Chemist")
			return 2
		if("Quartermaster")
			return 2
		if("Archaeologist")
			return 2
		if("Captain")
			return 4
		else
			world << "[job] NOT GIVEN RANK, OOPS"

/proc/IsSecurity(var/job)
	if("Security Officer")
		return 1
	if("Forensic Technician")
		return 1
	if("Detective")
		return 1
	if("Head of Security")
		return 2
	else
		return 0