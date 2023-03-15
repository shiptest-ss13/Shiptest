// Hey! Listen! Update \config\sandruinblacklist.txt with your new ruins!

/datum/map_template/ruin/whitesands
	prefix = "_maps/RandomRuins/SandRuins/"

/datum/map_template/ruin/whitesands/seed_vault
	name = "Seed Vault"
	id = "seed-vault"
	description = "The creators of these vaults were a highly advanced and benevolent race, and launched many into the stars, hoping to aid fledgling civilizations. \
	However, all the inhabitants seem to do is grow drugs and guns."
	suffix = "whitesands_surface_seed_vault.dmm"
	cost = 10
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/starfury_crash
	name = "Starfury Crash"
	id = "starfurycrash"
	description = "The remains of an unidentified syndicate battleship has crashed here."
	suffix = "whitesands_surface_starfurycrash.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/golem_hijack
	name = "Crashed Golem Ship"
	id = "golemcrash"
	description = "The remains of a mysterious ship, inhabited by strange lizardpeople and golems of some sort. Who knows what happened here."
	suffix = "whitesands_surface_golemhijack.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/medipen_plant
	name = "Abandoned Medipen Factory"
	id = "medipenplant"
	description = "A once prosperous autoinjector manufacturing plant."
	suffix = "whitesands_surface_medipen_plant.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/youreinsane
	name = "Lost Engine"
	id = "ws-youreinsane"
	description = "Nanotrasen would like to remind all employees that the Pi\[REDACTED\]er is not real."
	suffix = "whitesands_surface_youreinsane.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/assaultpodcrash
	name = "Crashed Syndicate Assault Drop Pod"
	id = "ws-assaultpodcrash"
	description = "The fauna of desert planets can be deadly even to equipped Syndicate Operatives."
	suffix = "whitesands_surface_assaultpodcrash.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/conveniencestore
	name = "Conveniently Abandoned Convenience Store"
	id = "ws-conveniencestore"
	description = "Pretty convenient that they have a convenience store out here, huh?"
	suffix = "whitesands_surface_conveniencestore.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/onlyaspoonful
	name = "Abandoned Spoon Factory"
	id = "ws-onlyaspoonful"
	description = "Literally a fucking spoon factory"
	suffix = "whitesands_surface_onlyaspoonful.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/chokepoint
	name = "Chokepoint"
	id = "ws-chokepoint"
	description = "Some sort of survivors, brandishing old nanotrasen security gear."
	suffix = "whitesands_surface_chokepoint.dmm"
	allow_duplicates = FALSE

//////////OUTSIDE SETTLEMENTS/RUINS//////////
/datum/map_template/ruin/whitesands/survivors/drugstore
	name = "Abandoned Store"
	id = "ws-drugstore"
	description = "A store that once sold a variety of items and equipment."
	cost = 1
	placement_weight = 0.5
	suffix = "whitesands_surface_camp_drugstore.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/survivors/combination //combined extra large ruin of several other whitesands survivor ruins (excludes the drugstore)
	name = "Wasteland Survivor Village"
	id = "ws-combination"
	description = "A small encampment of nomadic survivors of the First Colony, and their descendants. By all accounts, feral and without allegance to anyone but themselves."
	cost = 1
	placement_weight = 0.5
	suffix = "whitesands_surface_camp_combination.dmm"
	allow_duplicates = FALSE
