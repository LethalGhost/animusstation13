// UNDERS AND BY THAT, NATURALLY I MEAN UNIFORMS/JUMPSUITS

/obj/item/clothing/under
	icon = 'uniforms.dmi'
	name = "under"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	protective_temperature = T0C + 50
	heat_transfer_coefficient = 0.30
	permeability_coefficient = 0.90
	flags = FPRINT | TABLEPASS | ONESIZEFITSALL

// Colors

/obj/item/clothing/under/chameleon
//starts off as black
	name = "chameleon jumpsuit"
	icon_state = "black"
	item_state = "bl_suit"
	color = "black"
	desc = null
	var/list/clothing_choices = list()

/obj/item/clothing/under/chameleon/all

/obj/item/clothing/under/color/black
	name = "black jumpsuit"
	icon_state = "black"
	item_state = "bl_suit"
	color = "black"

/obj/item/clothing/under/color/blue
	name = "blue jumpsuit"
	icon_state = "blue"
	item_state = "b_suit"
	color = "blue"

/obj/item/clothing/under/color/green
	name = "green jumpsuit"
	icon_state = "green"
	item_state = "g_suit"
	color = "green"

/obj/item/clothing/under/color/grey
	name = "grey jumpsuit"
	icon_state = "grey"
	item_state = "gy_suit"
	color = "grey"

/obj/item/clothing/under/color/orange
	name = "orange jumpsuit"
	icon_state = "orange"
	item_state = "o_suit"
	color = "orange"

/obj/item/clothing/under/color/pink
	name = "pink fumpsuit"
	icon_state = "pink"
	item_state = "p_suit"
	color = "pink"

/obj/item/clothing/under/color/red
	name = "red jumpsuit"
	icon_state = "red"
	item_state = "r_suit"
	color = "red"

/obj/item/clothing/under/color/white
	name = "white jumpsuit"
	desc = "Made of a special fiber that gives special protection against biohazards."
	icon_state = "white"
	item_state = "w_suit"
	color = "white"
	permeability_coefficient = 0.50

/obj/item/clothing/under/color/yellow
	name = "yellow jumpsuit"
	icon_state = "yellow"
	item_state = "y_suit"
	color = "yellow"

// RANKS

/obj/item/clothing/under/rank/atmospheric_technician
	name = "atmospherics jumpsuit"
	desc = "It has an Atmospherics rank stripe on it."
	icon_state = "atmos"
	item_state = "y_suit"
	color = "atmos"

/obj/item/clothing/under/rank/captain
	name = "captain's jumpsuit"
	desc = "It has a Captains rank stripe on it."
	icon_state = "captain"
	item_state = "dg_suit"
	color = "captain"

/obj/item/clothing/under/rank/archaeologist
	name = "archaeologist's jumpsuit"
	desc = "A snappy jumpsuit with a sturdy set of overalls. It has a Archaeologist rank stripe on it."
	icon_state = "archaeologist"
	item_state = "b_suit"
	color = "archaeologist"

/obj/item/clothing/under/rank/counselor
	name = "counselor's jumpsuit"
	desc = "It has a Counselor rank stripe on it."
	icon_state = "counselor"
	item_state = "bl_suit"
	color = "counselor"

/obj/item/clothing/under/rank/chemist
	name = "chemistry jumpsuit"
	desc = "Made of a special fiber that gives protection against biohazards. Has a Chemist rank stripe on it."
	icon_state = "chemistry"
	item_state = "w_suit"
	color = "chemistry"
	permeability_coefficient = 0.40

/obj/item/clothing/under/rank/engineer
	name = "engineering jumpsuit"
	desc = "It has an Engineering rank stripe on it."
	icon_state = "engine"
	item_state = "y_suit"
	color = "engine"

/obj/item/clothing/under/rank/forensic_technician
	name = "forensic's jumpsuit"
	desc = "It has a Forensics rank stripe on it."
	icon_state = "darkred"
	item_state = "r_suit"
	color = "forensicsred"

/obj/item/clothing/under/rank/geneticist
	name = "genetic's jumpsuit"
	desc = "Made of a special fiber that gives protection against biohazards. Has a genetics rank stripe on it."
	icon_state = "genetics"
	item_state = "w_suit"
	color = "geneticswhite"
	permeability_coefficient = 0.50

/obj/item/clothing/under/rank/anomalist
	name = "anomalist's jumpsuit"
	desc = "Made of a special fiber that gives protection against biohazards. Has a anomalist rank stripe on it."
	icon_state = "anomalist"
	item_state = "w_suit"
	color = "anomalist"
	permeability_coefficient = 0.50

/obj/item/clothing/under/rank/head_of_personnel
	name = "head of personnel's jumpsuit"
	desc = "It has a Head of Personnel rank stripe on it."
	icon_state = "hop"
	item_state = "b_suit"
	color = "hopblue"

/obj/item/clothing/under/rank/head_of_security
	name = "head of security jumpsuit"
	desc = "It has a Head of Security rank stripe on it."
	icon_state = "hos"
	item_state = "r_suit"
	color = "hosred"

/obj/item/clothing/under/rank/chief_engineer
	name = "chief engineer's jumpsuit"
	desc = "It has a Chief Engineer rank stripe on it."
	icon_state = "chiefengineer"
	item_state = "g_suit"
	color = "chief"

/obj/item/clothing/under/rank/research_director
	name = "research director's jumpsuit"
	desc = "It has a Research Director rank stripe on it."
	icon_state = "director"
	item_state = "g_suit"
	color = "director"

/obj/item/clothing/under/rank/chief_medical_officer
	name = "chief medical officer's jumpsuit"
	desc = "Made of a special fiber that gives special protection against biohazards. Has a Chief Medical Officer rank stripe on it."
	icon_state = "medical"
	item_state = "w_suit"
	color = "medical"
	permeability_coefficient = 0.50
	//armor = list(melee = 0, bullet = 0, laser = 2, taser = 2, bomb = 0, bio = 10, rad = 0) // tg stuff, not ported

/obj/item/clothing/under/rank/janitor
	name = "janitor's jumpsuit"
	desc = "The janitorial crew jumpsuit."
	icon_state = "janitor"
	color = "janitor"

/obj/item/clothing/under/rank/scientist
	name = "scientist's jumpsuit"
	desc = "Made of a special fiber that gives special protection against biohazards. Has a toxins rank stripe on it."
	icon_state = "toxins"
	item_state = "w_suit"
	color = "toxinswhite"
	permeability_coefficient = 0.50

/obj/item/clothing/under/rank/medical
	name = "medical doctor's jumpsuit"
	desc = "Made of a special fiber that gives special protection against biohazards. Has a medical rank stripe on it."
	icon_state = "medical"
	item_state = "w_suit"
	color = "medical"
	permeability_coefficient = 0.50

/obj/item/clothing/under/rank/hydroponics
	name = "hydroponics jumpsuit"
	desc = "Made of a special fiber that gives special protection against biohazards. Has a Hydroponics rank stripe on it."
	icon_state = "hydroponics"
	item_state = "g_suit"
	color = "hydroponics"
	permeability_coefficient = 0.50

/obj/item/clothing/under/rank/roboticist
	name = "robotics jumpsuit"
	desc = "Made of a special fiber that gives protection against electrocution. Has a Robotics rank stripe on it."
	icon_state = "robotics"
	item_state = "bl_suit"
	color = "robotics"
	siemens_coefficient = 0.50

// OTHER NONRANKED STATION JOBS

/obj/item/clothing/under/bartender
	name = "bartender's uniform"
	desc = "It looks like it could use more flair."
	icon_state = "ba_suit"
	item_state = "ba_suit"
	color = "ba_suit"

/obj/item/clothing/under/clown
	name = "clown suit"
	desc = "Wearing this, all the children love you, for all the wrong reasons."
	icon_state = "clown"
	color = "clown"

/obj/item/clothing/under/chef
	name = "chef's uniform"
	desc = "Issued only to the most hardcore chefs in space."
	icon_state = "chef"
	color = "chef"

/obj/item/clothing/under/det
	name = "hard worn suit"
	desc = "Someone who wears this means business"
	icon_state = "detective"
	item_state = "det"
	color = "detective"

/obj/item/clothing/under/ftech
	name = "forensic technician's jumpsuit"
	desc = "A variant of the security outfit, for forensic techs."
	icon_state = "forensicsred"
	item_state = "r_suit"
	color = "forensicsred"

/obj/item/clothing/under/lawyer
	name = "lawyer's suit"
	desc = "Slick threads."
	flags = FPRINT | TABLEPASS

/obj/item/clothing/under/lawyer/black
	icon_state = "lawyer_black"
	item_state = "lawyer_black"
	color = "lawyer_black"

/obj/item/clothing/under/lawyer/red
	icon_state = "lawyer_red"
	item_state = "lawyer_red"
	color = "lawyer_red"

/obj/item/clothing/under/lawyer/blue
	icon_state = "lawyer_blue"
	item_state = "lawyer_blue"
	color = "lawyer_blue"

/obj/item/clothing/under/sl_suit
	name = "amish suit"
	desc = "A very amish looking suit"
	icon_state = "sl_suit"
	color = "sl_suit"

/obj/item/clothing/under/cargo
	name = "quartermaster's jumpsuit"
	desc = "What can brown do for you?"
	icon_state = "lightbrown"
	item_state = "lb_suit"
	color = "cargo"

/obj/item/clothing/under/syndicate
	name = "tactical turtleneck"
	desc = "Non-descript, slightly suspicious civilian clothing."
	icon_state = "syndicate"
	item_state = "bl_suit"
	color = "syndicate"

// Athletic shorts.. heh
/obj/item/clothing/under/shorts
	name = "athletic shorts"
	desc = "95% Polyester, 5% Spandex!"
	flags = FPRINT | TABLEPASS

/obj/item/clothing/under/shorts/red
	icon_state = "redshorts"
	color = "redshorts"

/obj/item/clothing/under/shorts/green
	icon_state = "greenshorts"
	color = "greenshorts"

/obj/item/clothing/under/shorts/blue
	icon_state = "blueshorts"
	color = "blueshorts"

/obj/item/clothing/under/shorts/black
	icon_state = "blackshorts"
	color = "blackshorts"

/obj/item/clothing/under/shorts/grey
	icon_state = "greyshorts"
	color = "greyshorts"