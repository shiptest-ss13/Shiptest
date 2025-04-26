/datum/export/trophycommon
	cost = 250
	unit_name = "common hunting trophy"
	export_types = list(
		/obj/item/mob_trophy/legion_skull,
		/obj/item/mob_trophy/wolf_ear,
		/obj/item/mob_trophy/bear_paw,
		/obj/item/mob_trophy/goliath_tentacle,
		/obj/item/mob_trophy/watcher_wing
	)

/datum/export/trophyrare
	cost = 1000
	unit_name = "rare hunting trophy"
	export_types = list(
		/obj/item/mob_trophy/dwarf_skull,
		/obj/item/mob_trophy/fang,
		/obj/item/mob_trophy/war_paw,
		/obj/item/mob_trophy/elder_tentacle,
		/obj/item/mob_trophy/ice_crystal,
		/obj/item/mob_trophy/magma_wing,
		/obj/item/mob_trophy/tail_spike,
		/obj/item/mob_trophy/ice_wing
	)

/datum/export/trophymega
	cost = 3000
	elasticity_coeff = 0
	unit_name = "big game hunting trophy"
	export_types = list(
		/obj/item/mob_trophy/legionnaire_spine,
		/obj/item/mob_trophy/ash_spike,
		/obj/item/mob_trophy/demon_claws,
		/obj/item/mob_trophy/broodmother_tongue,
		/obj/item/mob_trophy/ice_block_talisman,
		/obj/item/mob_trophy/miner_eye,
		/obj/item/mob_trophy/vortex_talisman,
		/obj/item/mob_trophy/blaster_tubes
	)

/datum/export/dogtag
	desc = "CLIP has posted several bounties for wanted members of both the Frontiersman and the Clique. Bring back their tags, we'll reward you well."
	cost = 200
	elasticity_coeff = 0

/datum/export/dogtag/frontiersmen
	unit_name = "frontiersmen dogtags"
	export_types = list(/obj/item/clothing/neck/dogtag/frontier)

/datum/export/dogtag/ramzi
	unit_name = "ramzi dogtags"
	export_types = list(/obj/item/clothing/neck/dogtag/ramzi)
