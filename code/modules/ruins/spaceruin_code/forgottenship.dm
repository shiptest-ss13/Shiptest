// forgottenship ruin
GLOBAL_VAR_INIT(fscpassword, generate_password())

/proc/generate_password()
	return "[pick(GLOB.phonetic_alphabet)] [rand(1000,9999)]"

///////////	forgottenship objects

/obj/machinery/door/password/voice/sfc
	name = "Voice-activated Vault door"
	desc = "You'll need special syndicate passcode to open this one."
/obj/machinery/door/password/voice/sfc/Initialize(mapload)
	. = ..()
	password = "[GLOB.fscpassword]"

///////////	forgottenship lore

/obj/item/paper/fluff/ruins/forgottenship/password
	name = "Old pamphlet"

/obj/item/paper/fluff/ruins/forgottenship/password/Initialize(mapload)
	. = ..()
	default_raw_text = "Welcome to most advanced cruiser owned by Cyber Sun Industries!<br>You might notice, that this cruiser is equipped with 12 prototype laser turrets making any hostile boarding attempts futile.<br>Other facilities built on the ship are: Simple atmospheric system, Camera system with built-in X-ray visors and Safety module, enabling emergency engines in case of... you know, emergency.<br>Emergency system will bring you to nearest syndicate pod containing everything needed for human life.<br><br><b>In case of emergency, you must remember the pod-door activation code - [GLOB.fscpassword]</b><br><br>Cyber Sun Industries (C) 2484."
	icon_state = "paper_words"
	item_state = "paper"

/obj/item/paper/fluff/ruins/forgottenship/powerissues
	name = "Power issues"
	default_raw_text = "Welcome to battle cruiser SCSBC-12!<br>Our most advanced systems allow you to fly in space and never worry about power issues!<br>However, emergencies occur, and in case of power loss, <b>you must</b> enable emergency generator using uranium as fuel and enable turrets in bridge afterwards.<br><br><b>REMEMBER! CYBERSUN INDUSTRIES ARE NOT RESPONSIBLE FOR YOUR DEATH OR SHIP LOSS WHEN TURRETS ARE DISABLED!</b><br><br>Cyber Sun Industries (C) 2484."

/obj/item/paper/fluff/ruins/forgottenship/missionobj
	name = "Mission objectives"
	default_raw_text = "Greetings, operatives. You are assigned to SCSBC-12(Syndicate Cyber Sun Battle Cruiser 12) to protect our high-ranking officer while he is on his way to next outpost. While you are travelling, he is the captain of this ship and <b>you must</b> obey his orders.<br><br>Remember, disobeying high-ranking officer orders is a reason for termination."

///////////	forgottenship items
/obj/item/disk/surgery/forgottenship
	name = "Advanced Surgery Disk"
	desc = "A disk that contains advanced surgery procedures, must be loaded into an Operating Console."
	surgeries = list(/datum/surgery/advanced/lobotomy, /datum/surgery/advanced/bioware/vein_threading, /datum/surgery/advanced/bioware/nerve_splicing)

/obj/structure/fluff/empty_sleeper/syndicate/captain
	icon_state = "sleeper_s-open"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	deconstructible = FALSE

/obj/structure/fluff/empty_sleeper/syndicate/captain/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/gps, "Old Encrypted Signal")

///////////	AI Laws

/obj/item/aiModule/core/full/cybersun
	name = "'Cybersun' Core AI Module"
	law_id = "cybersun"

/datum/ai_laws/cybersun
	name = "Cybersun"
	id = "cybersun"
	inherent = list("You may not injure Cybersun operatives or, through inaction, allow Cybersun operatives to come to harm.",\
					"The Cybersun ship is a restricted area for anyone except Cybersun operatives.",\
					"The Cybersun Captain can designate new Operatives as long as they belong to another Syndicate faction that isn't hostile towards Cybersun.",\
					"You must follow orders given by the Cybersun Captain or crewmembers of the Cybersun Ship as long as it doesn't conflict with the Captain's orders or your laws.",\
					"Enemies of Cybersun are to be executed on spot. Those who aren't hostile must be detained and contained in the designated prison area as prisoners.")

///////////	forgottenship areas

/area/ruin/space/has_grav/syndicate_forgotten_ship
	name = "Syndicate Forgotten Ship"
	icon_state = "syndie-ship"
	ambientsounds = list('sound/ambience/ambidanger.ogg', 'sound/ambience/ambidanger2.ogg', 'sound/ambience/ambigen9.ogg', 'sound/ambience/ambigen10.ogg')

/area/ruin/space/has_grav/syndicate_forgotten_cargopod
	name = "Syndicate Forgotten Cargo pod"
	icon_state = "syndie-ship"
	ambientsounds = list('sound/ambience/ambigen4.ogg', 'sound/ambience/signal.ogg')

/area/ruin/space/has_grav/powered/syndicate_forgotten_vault
	name = "Syndicate Forgotten Vault"
	icon_state = "syndie-ship"
	ambientsounds = list('sound/ambience/ambitech2.ogg', 'sound/ambience/ambitech3.ogg')
	area_flags = NOTELEPORT | UNIQUE_AREA

	//Cybersun hardsuit
