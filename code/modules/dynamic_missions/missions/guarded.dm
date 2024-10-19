/obj/effect/landmark/mission_poi/guard
	icon_state = "guard"

/datum/mission/dynamic/nt_files
	name = "NT asset recovery"
	value = 1250
	mission_reward = list(
		/obj/item/gun/energy/e_gun/old,
		/obj/item/gun/energy/laser/retro,
		/obj/item/gun/energy/laser/captain
	)
	faction = /datum/faction/nt
	setpiece_item = /obj/item/documents/nanotrasen

/datum/mission/dynamic/nt_files/generate_mission_details()
	. = ..()
	name = pick("NT asset recovery", "asset recovery requested ASAP")
	author = "Captain [random_species_name()]"
	desc = pick("Look- long story short, I need this folder retrieved. You don't ask why, I make sure you get paid.")
