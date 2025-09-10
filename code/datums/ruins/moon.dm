/datum/map_template/ruin/moon
	prefix = "_maps/RandomRuins/MoonRuins/"

	ruin_type = RUINTYPE_MOON

/datum/map_template/ruin/moon/moonbase
	name = "CLIP-MELD Moonbase"
	description = "An abandoned CLIP-MELD refining base lost to crystal infestation and the Frontiersmen. Home to a great vein of hydrogen ice."
	id = "moon_moonbase"
	suffix = "moon_moonbase.dmm"
	ruin_mission_types = list(
		/datum/mission/ruin/signaled/drill/moonbase,
	)

/datum/map_template/ruin/rockplanet/somme
	name = "Frontiersman Trench Complex"
	description = "Frontiersmen have dug in like ticks to the planet's surface."
	id = "rockplanet_somme"
	suffix = "rockplanet_somme.dmm"
/*	ruin_mission_types = list(
		/datum/mission/ruin/signaled/kill/ross,
		/datum/mission/ruin/missing_reporter,
	)
*/
