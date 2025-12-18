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
	desc = "CLIP-MELD is putting out a notice to any able-bodied forces in the area to assist in clearing out a crystal infestation on a local ice-extraction moonbase. \
			A majority of the infestation is located within an ore vein to the north of the site, and is considered to be extremely dangerous, even to the strongest of crews. \
			Additionally, there are reports of a Frontiersmen outfit setting up in the ruins of the facility. Be careful handling this infestation so that CLIP-MELD may reclaim the site."
	mission_limit = 1
	faction = list(
		/datum/faction/clip,
	)

/datum/map_template/ruin/moon/hideout
	name = "Ramzi Cave Hideout"
	description = "A makeshift ramzi hideout in a cave, holding a smaller garrison."
	id = "moon_hideout"
	suffix = "moon_hideout.dmm"
