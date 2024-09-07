/datum/preset_holoimage/cybersun_intel_director
	species_type = /datum/species/ipc
	outfit_type = /datum/outfit/job/syndicate/captain/cybersun

/obj/item/disk/holodisk/kansatsu/mission
	desc = "A classified holodisk containing a mission for the Cybersun Industries Intelligence Division."
	preset_image_type = /datum/preset_holoimage/cybersun_intel_director

/obj/item/disk/holodisk/kansatsu/mission/New(obj/L)
	..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-3, 2)

/obj/item/disk/holodisk/kansatsu/mission/safety
	name = "\improper IG-I-296" // Information Gathering - Infiltration - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents.	Your vessel has been assigned a mission to infiltrate vessels belonging to any group of interest.
	DELAY 40
	SAY You must gather information about the safety measures on board. You are to look for any potential flaws and exploits.
	DELAY 40
	SAY You must avoid recognition while performing this mission.
	DELAY 40
	SAY Your officers must then prepare an official report on this.
	DELAY 40
	SAY This mission will be considered completed with at least three reports. Do not disappoint us.
	DELAY 40
	"}

/obj/item/disk/holodisk/kansatsu/mission/bugging
	name = "\improper IG-I-085" // Information Gathering - Infiltration - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents.	Your vessel has been assigned a mission to infiltrate vessels belonging to any group of interest.
	DELAY 40
	SAY You are to plant a tracking beacon on board, in a secure location.
	DELAY 40
	SAY You must avoid recognition while performing this mission.
	DELAY 40
	SAY This mission will be considered completed with at least four beacons planted. Do not disappoint us.
	DELAY 40
	"}

/obj/item/storage/box/syndie_kit/tracking_beacons
	name = "box of tracking beacons"

/obj/item/storage/box/syndie_kit/tracking_beacons/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/beacon(src)

/obj/item/disk/holodisk/kansatsu/mission/crew
	name = "\improper IG-I-138" // Information Gathering - Infiltration - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents. Your vessel has been assigned a mission to infiltrate vessels belonging to any group of interest.
	DELAY 40
	SAY You must profile five members of the crew. Their profile must include credentials, habits and skills. Any further information is optional, but advised.
	DELAY 40
	SAY You must avoid recognition while performing this mission.
	DELAY 40
	SAY Your officers must then prepare an official report on this.
	DELAY 40
	SAY This mission will be considered completed with at least five reports. Do not disappoint us.
	DELAY 40
	"}

/obj/item/disk/holodisk/kansatsu/mission/valueables
	name = "\improper IG-I-271" // Information Gathering - Infiltration - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents. Your vessel has been assigned a mission to infiltrate vessels belonging to any group of interest.
	DELAY 40
	SAY On board, you must locate and catalogue all the objects of value. You may not seize them, unless you are tasked to by another mission.
	DELAY 40
	SAY You must avoid recognition while performing this mission.
	DELAY 40
	SAY Your officers must then prepare an official report on this.
	DELAY 40
	SAY This mission will be considered completed with at least three reports. Do not disappoint us.
	DELAY 40
	"}

/obj/item/disk/holodisk/kansatsu/mission/ruins
	name = "\improper IG-S-290" // Information Gathering - Scouting - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents. Your vessel has been assigned a mission to scout your current sector.
	DELAY 40
	SAY You are to locate war-era derelicts. You must explore them and take note of all the relevant details.
	DELAY 40
	SAY Your officers must then prepare an official report on this.
	DELAY 40
	SAY This mission will be considered completed with at least five reports. Do not disappoint us.
	DELAY 40
	"}

/obj/item/disk/holodisk/kansatsu/mission/documents
	name = "\improper E-019" // Extraction - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents. Your vessel has been assigned a mission to locate and retrieve an asset belonging to any group of interest that is not friendly to us.
	DELAY 40
	SAY To be precise, you are after a bundle of classified documents.
	DELAY 40
	SAY You must avoid recognition while performing this mission.
	DELAY 40
	SAY Do not disappoint us.
	DELAY 20
	"}

/obj/item/disk/holodisk/kansatsu/mission/pet
	name = "\improper E-271" // Extraction - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents. Your vessel has been assigned a mission to locate and retrieve an asset belonging to any group of interest that is not friendly to us.
	DELAY 40
	SAY To be precise, you are after a domesticated animal. The cutest you can possibly find.
	DELAY 40
	SAY You must avoid recognition while performing this mission.
	DELAY 40
	SAY Do not disappoint us.
	DELAY 20
	"}

/obj/item/disk/holodisk/kansatsu/mission/gem
	name = "\improper E-147" // Extraction - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents. Your vessel has been assigned a mission to locate and retrieve an asset.
	DELAY 40
	SAY To be precise, you are after a rare gem.
	DELAY 40
	SAY They can be found in derelicts and remains of certain fauna.
	DELAY 40
	SAY You are also permitted to retrieve it from any group of interest that is not friendly to us. You must avoid recognition if you do so.
	DELAY 40
	SAY Do not disappoint us.
	DELAY 20
	"}

/obj/item/disk/holodisk/kansatsu/mission/anomalies
	name = "\improper RD-166" // Research Division - Random Number
	preset_record_text = {"
	NAME Intelligence Director Torch-3
	SAY Agents. Your vessel has been assigned a mission to assist our research department.
	DELAY 40
	SAY You are to collect at least four anomaly cores.
	DELAY 40
	SAY They are scattered around the planetoids in your sector. You are also permitted to retrieve them from other vessels.
	DELAY 40
	SAY The anomaly cores must be stored in your armory, in the company-issued secure crate.
	DELAY 40
	SAY Do not disappoint us.
	DELAY 20
	"}


/obj/effect/spawner/lootdrop/kansatsu_missions
	name = "Kansatsu Missions"
	lootdoubles = FALSE
	loot = list(
		/obj/item/disk/holodisk/kansatsu/mission/safety = 3,
		/obj/item/disk/holodisk/kansatsu/mission/crew = 5,
		/obj/item/disk/holodisk/kansatsu/mission/valueables = 4,
		/obj/item/disk/holodisk/kansatsu/mission/ruins = 5,
		/obj/item/disk/holodisk/kansatsu/mission/documents = 4,
		/obj/item/disk/holodisk/kansatsu/mission/pet = 3,
		/obj/item/disk/holodisk/kansatsu/mission/gem = 3,
		/obj/item/disk/holodisk/kansatsu/mission/anomalies = 2, // Lower because it doesn't really use much of the spy gimmick. Still fits though so it stays.
		/obj/item/disk/holodisk/kansatsu/mission/bugging = 4
	)

	lootcount = 2

/datum/preset_holoimage/cybersun_researcher
	outfit_type = /datum/outfit/job/syndicate/science/cybersun
	species_type = /datum/species/elzuose

/obj/item/disk/holodisk/kansatsu/gear
	preset_image_type = /datum/preset_holoimage/cybersun_researcher

/obj/item/disk/holodisk/kansatsu/gear/tablets
	name = "\improper IR-241" // Introductory Recording - Random Number
	desc = "A classified holodisk containing an introduction to the Syndix tablets."
	preset_record_text = {"
	NAME Researcher Meenus-Seeba
	SAY You have been issued a set of Cybersun Virtual Solutions Syndix Tablets.
	DELAY 40
	SAY They will allow you to maintain communications over a long range, via the Chatting feature.
	DELAY 40
	SAY We advise you to create a private channel where you maintain contact with personnel on missions.
	DELAY 40
	SAY Good luck.
	DELAY 20
	"}

/obj/item/disk/holodisk/kansatsu/gear/chameleon
	name = "\improper IR-174" // Introductory Recording - Random Number
	desc = "A classified holodisk containing an introduction to the Chameleon gear."
	preset_record_text = {"
	NAME Researcher Meenus-Seeba
	SAY You have been issued a Cybersun Industries Chameleon Gear Set.
	DELAY 40
	SAY It contains three pieces of advanced gear used for espionage.
	DELAY 40
	SAY First gadget included is the Chameleon kit - a holographically amplified set of clothing that can swiftly and quitely allow to blend in.
	DELAY 40
	SAY Second piece of gear is the Chameleon holster. It allows you to smuggle a firearm past any security checkpoint, which will prove vital for self-defense and assassination missions.
	DELAY 40
	SAY Third, and most exciting, is the Chameleon projector. It is a personal cloaking device that is excellent for getting in and out unnoticed.
	DELAY 40
	SAY Good luck.
	DELAY 20
	"}

/obj/item/disk/holodisk/kansatsu/gear/pens
	name = "\improper IR-304" // Introductory Recording - Random Number
	desc = "A classified holodisk containing an introduction to the modified pens."
	preset_record_text = {"
	NAME Researcher Meenus-Seeba
	SAY You have been issued a set of Cybersun Biodynamics Modified Pen Kit.
	DELAY 40
	SAY It contains three advanced pens with utility in espionage.
	DELAY 40
	SAY First of the pens doubles as a tiny energy knife. Extremely useful in combat and for utility, while being practically unrecognizable.
	DELAY 40
	SAY Second pen is equipped with a hidden chemical injector at the tip. After stabbing a target with it, they will be subdued shortly. Perfect for target extraction.
	DELAY 40
	SAY Third pen, and the most visually distinctive one, has a diamond tip that can be used to mine. Not the fastest way to move around, but can certainly prove useful in emergencies.
	DELAY 40
	SAY The Cybersun Industries Modified Pen Kit also contains a complimentraty pocket protector to carry the pens in without drawing too much suspicion.
	DELAY 40
	SAY Good luck.
	DELAY 20
	"}
