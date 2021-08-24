// Hey! Listen! Update \config\sandruinblacklist.txt with your new ruins!

/datum/map_template/ruin/whitesands
	prefix = "_maps/RandomRuins/SandRuins/"

/datum/map_template/ruin/whitesands/solgov_crash
	name = "Crashed SolGov Transport"
	id = "solgov-crash"
	description = "Not too long ago, a SolGov transporter shuttle needed to get from point A to point B, and not too long after getting near, someone decided \
					to see how maneuverable the famously unmaneuverable shuttles were."
	suffix = "whitesands_surface_solgovcrash.dmm"
	cost = 10
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/hermit
	name = "Sandstone Cave"
	id = "hermitsandcave"
	description = "A place of shelter for a lone hermit, scraping by to live another day."
	suffix = "whitesands_surface_hermit.dmm"
	allow_duplicates = FALSE
	cost = 10

/datum/map_template/ruin/whitesands/abductor_crash
	name = "Crashed Abductor Ship"
	id = "ws-abductor-crash"
	description = "Turns out that keeping your abductees unconscious is really important. Who knew?"
	suffix = "whitesands_surface_abductor_crash.dmm"
	allow_duplicates = FALSE
	cost = 5

/datum/map_template/ruin/whitesands/blood_drunk_miner
	name = "Blood-Drunk Miner"
	id = "blooddrunk"
	description = "A strange arrangement of stone tiles and an insane, beastly miner contemplating them."
	suffix = "whitesands_surface_blooddrunk1.dmm"
	cost = 0
	allow_duplicates = FALSE //will only spawn one variant of the ruin

/datum/map_template/ruin/whitesands/blood_drunk_miner/guidance
	name = "Blood-Drunk Miner (Guidance)"
	suffix = "whitesands_surface_blooddrunk2.dmm"

/datum/map_template/ruin/whitesands/blood_drunk_miner/hunter
	name = "Blood-Drunk Miner (Hunter)"
	suffix = "whitesands_surface_blooddrunk3.dmm"

/datum/map_template/ruin/whitesands/seed_vault
	name = "Seed Vault"
	id = "seed-vault"
	description = "The creators of these vaults were a highly advanced and benevolent race, and launched many into the stars, hoping to aid fledgling civilizations. \
	However, all the inhabitants seem to do is grow drugs and guns."
	suffix = "whitesands_surface_seed_vault.dmm"
	cost = 10
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/sin/envy
	name = "Ruin of Envy"
	id = "envy"
	description = "When you get what they have, then you'll finally be happy."
	suffix = "whitesands_surface_envy.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/water
	name = "Abandoned Water Extraction Facility"
	id = "waterplant"
	description = "An abandoned building that seems to have once used prisoner labour to extract water for a colony."
	suffix = "whitesands_surface_waterplant.dmm"
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

//////////OUTSIDE SETTLEMENTS/RUINS//////////
/datum/map_template/ruin/whitesands/survivors
	name = "Survivor Camp"
	id = "ws-survivors"
	description = "A small encampment of nomadic survivors of the First Colony, and their descendants. By all accounts, feral and without allegance to anyone but themselves."
	suffix = "whitesands_surface_camp_survivors.dmm"
	cost = 2
	placement_weight = 1.2
	always_place = TRUE

/datum/map_template/ruin/whitesands/survivors/hunters
	name = "Hunter Camp"
	id = "ws-survivors-hunter"
	description = "A small encampment of nomadic hunters of the First Colony, and their descendants. It's worth steering wide of these guys."
	suffix = "whitesands_surface_camp_hunters.dmm"
	cost = 3
	placement_weight = 0.8

/datum/map_template/ruin/whitesands/survivors/gunslingers
	name = "Mercenary Camp"
	id = "ws-survivors-gunslingers"
	description = "A small encampment of nomadic warriors of the First Colony, and their descendants. They might have the only working automatics on the planet."
	suffix = "whitesands_surface_camp_gunslingers.dmm"
	cost = 5
	placement_weight = 0.7

/datum/map_template/ruin/whitesands/survivors/adobe
	name = "Native Adobe"
	id = "ws-survivors-adobe"
	description = "A semi-permanent settlement of survivors of the First Colony, and their descendants. Places like this often stash gear and supplies for their bretheren."
	suffix = "whitesands_surface_camp_adobe.dmm"
	cost = 10
	placement_weight = 0.5
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/survivors/farm
	name = "Abandoned Farm"
	id = "ws-farm"
	description = "A abandoned farm, destroyed from years of shootouts and lack of maintenance."
	cost = 1
	placement_weight = 0.5
	suffix = "whitesands_surface_camp_farm.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/survivors/drugstore
	name = "Abandoned Store"
	id = "ws-drugstore"
	description = "A store that once sold a variety of items and equipment."
	cost = 1
	placement_weight = 0.5
	suffix = "whitesands_surface_camp_drugstore.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/whitesands/survivors/saloon
	name = "Abandoned Saloon"
	id = "ws-saloon"
	description = "A western style saloon that has not been touched in years"
	cost = 1
	placement_weight = 0.5
	suffix = "whitesands_surface_camp_saloon.dmm"
	allow_duplicates = FALSE
