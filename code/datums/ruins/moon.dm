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

/datum/mission/ruin/signaled/drill/moonbase
	name = "Root out Crystal Infestation"
	desc = "N+S Logistics has lost contact with a recently established mining base. We believe that this base is located upon an extremely lucrative hydrogen-ice vein. \
			Due to loss of contact, N+S has been unable to verify the existence of this vein. Please move to the site, locate the drilling system, and bring us our geological survey results. \
			If an N+S team is still on site, please inform them that their communications system has been damaged, and that the next supply run will be in 3 weeks."
	mission_limit = 1
	faction = list(
		/datum/faction/clip,
	)
