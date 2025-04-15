// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/lavaland
	prefix = "_maps/RandomRuins/LavaRuins/"
	ruin_type = RUINTYPE_LAVA

/datum/map_template/ruin/lavaland/biodome/winter
	name = "Solarian Winter Biodome"
	id = "biodome-winter"
	description = "A Solarian frontier research facility created by the Pionierskompanien \
	This one seems to simulate the wintery climate of the northern provinces, including a sauna!"
	suffix = "lavaland_surface_biodome_winter.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/lavaland/buried_shrine
	name = "Buried Shrine"
	id = "buried_shrine"
	description = "An ancient temple belonging to some long-gone inhabitants, wrecked and buried by the volcanic activity of it's home planet."
	suffix = "lavaland_surface_buried_shrine.dmm"

/datum/map_template/ruin/lavaland/lava_canyon
	name = "Lava Canyon"
	id = "lava_canyon"
	description = "Tectonic activity has gouged a large fissure into the surface of the planet here. Tucked in the crevasse, the remains of an ashwalker village lay in ashes."
	suffix = "lavaland_surface_lava_canyon.dmm"

/datum/map_template/ruin/lavaland/wrecked_factory
	name = "Wrecked Factory"
	id = "wreck_factory"
	description = "A Nanotrasen processing facility, assaulted by a pirate raid that has killed most of the staff. The offices however, remain unbreached for now."
	suffix = "lavaland_surface_wrecked_factory.dmm"
	ruin_mission_types = list(
		/datum/mission/ruin/nanotrasen_docs,
		/datum/mission/ruin/captain_medal,
		/datum/mission/ruin/brainchip
	)

/datum/mission/ruin/nanotrasen_docs
	name = "Nanotrasen Asset Recovery Program."
	author = "Nanotrasen Recovery Program"
	desc = "We've recently lost contact with a processing facility within the purview of this outpost. Nanotrasen is interested in the retrieval of sensitive assets located within the facility."
	faction = list(
		/datum/faction/nt,
		/datum/faction/syndicate/cybersun
	)
	mission_limit = 1
	setpiece_item = /obj/item/documents/nanotrasen

/datum/mission/ruin/nanotrasen_docs/generate_mission_details()
	. = ..()
	if(faction == /datum/faction/nt)
		name = "Nanotrasen Asset Recovery Program"
		author = "Nanotrasen Recovery Program"
		desc = "Nanotrasen Corporate has recently lost contact with a processing facility within the purview of this outpost. Nanotrasen is interested in the retrieval of sensitive assets located within the facility."
		value = 1500
	if(faction == /datum/faction/syndicate/cybersun)
		name = "Cybersun Capture Program"
		author = "Cybersun Virtual Solutions"
		desc = "Cybersun VS is extremely interested in the contents of a documents package located at a Nanotrasen facility recently hit by the Ramzi Clique. Retrieve it for us, and we'll pay handsomely."
		value = 2000

/datum/mission/ruin/captain_medal
	name = "Recover War Medal"
	desc = "A few months back, I lost my medal for \"Valiant Command Under Fire\". I've managed to track it down to a world in this system, and I'd like it retrieved."
	faction = /datum/faction/nt
	mission_limit = 1
	setpiece_item = /obj/item/clothing/accessory/medal/gold/captain

/datum/mission/ruin/brainchip
	name = "Nanotrasen Asset Recovery Program"
	author = "Nanotrasen Recovery Program"
	desc = "Retrieve an implant from cargo technician who has failed to report proper usage of the system as stipulated by contract."
	faction = /datum/faction/nt
	value = 1000
	mission_limit = 1
	setpiece_item = /mob/living/carbon/human

/obj/effect/landmark/mission_poi/main/implanted
	var/implant_type = /obj/item/organ/cyberimp/brain/datachip

/obj/effect/landmark/mission_poi/main/implanted/use_poi(_type_to_spawn)
	var/mob/living/carbon/human/implanted = ..()
	if(istype(implanted, /mob/living/carbon/human))
		var/obj/item/organ/implant = new implant_type()
		implant.Insert(implanted)
		return implant

/datum/map_template/ruin/lavaland/fallenstar
	name = "Crashed Starwalker"
	id = "crashed_star"
	description = "A crashed pirate ship. It would seem that it's crew died a while ago."
	suffix = "lavaland_crashed_starwalker.dmm"
	ruin_mission_types = list(/datum/mission/ruin/blackbox)

/datum/map_template/ruin/lavaland/abandonedlisteningpost
	name = "Abandoned Listening Post"
	id = "abandonedlistening"
	description = "An abandoned Cybersun listening post. Seems like the Ramzi Clique has an interest in the site."
	suffix = "lavaland_abandonedlisteningpost.dmm"
	ruin_mission_types = list(/datum/mission/ruin/blackbox)
