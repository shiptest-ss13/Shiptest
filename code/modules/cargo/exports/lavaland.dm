//Tendril chest artifacts and ruin loot. Includes ash drake loot since they drop two sets of armor + random item
//Consumable or one-use items like the magic D20 and gluttony's blessing are omitted
//no more 999999 currency after one frost world, sorry

/datum/export/lavaland/minor
	cost = 5000
	unit_name = "minor lava planet artifact"
	export_types = list(/obj/item/immortality_talisman,
						/obj/item/book_of_babel,
						/obj/item/wisp_lantern,
						/obj/item/reagent_containers/glass/bottle/potion/flight,
						/obj/item/clothing/glasses/godeye,
						/obj/item/clothing/suit/space/hardsuit/cult,
						/obj/item/voodoo,
						/obj/item/grenade/clusterbuster/inferno,
						/obj/item/clothing/neck/memento_mori,
						/obj/item/organ/heart/cursed/wizard,
						/obj/item/clothing/suit/hooded/cloak/drake,
						/obj/item/dragons_blood,
						/obj/item/lava_staff,
						/obj/item/ship_in_a_bottle,
						/obj/item/clothing/shoes/clown_shoes/banana_shoes,
						/obj/item/veilrender/vealrender,
						/obj/item/clothing/suit/armor/ascetic)

/datum/export/lavaland/major //valuable chest/ruin loot and staff of storms
	cost = 10000
	unit_name = "lava planet artifact"
	export_types = list(/obj/item/guardiancreator,
						/obj/item/rod_of_asclepius,
						/obj/item/clothing/suit/space/hardsuit/ert/paranormal,
						/obj/item/prisoncube,
						/obj/item/staff/storm,
						/obj/item/gun/energy/spur,
						/obj/item/freeze_cube,
						/obj/item/clothing/gloves/gauntlets,
						/obj/item/necromantic_stone/lava,
						)

//Megafauna loot, except for ash drakes and legion

/datum/export/lavaland/megafauna
	cost = 40000
	unit_name = "major lava planet artifact"
	export_types = list(/obj/item/hierophant_club,
						/obj/item/melee/transforming/cleaving_saw,
						/obj/item/organ/vocal_cords/colossus,
						/obj/machinery/anomalous_crystal,
						/obj/item/mayhem,
						/obj/item/blood_contract,
						/obj/item/guardiancreator/miner/choose//this is basically the most valulable mining loot so good luck getting a miner to part ways
						)
/*
/datum/export/lavaland/trophycommon
	cost = 1500
	unit_name = "common hunting trophy"
	export_types = list(/obj/item/mob_trophy/legion_skull,
						/obj/item/mob_trophy/wolf_ear,
						/obj/item/mob_trophy/bear_paw,
						/obj/item/mob_trophy/goliath_tentacle,
						/obj/item/mob_trophy/watcher_wing)

/datum/export/lavaland/trophyrare
	cost = 5000
	unit_name = "rare hunting trophy"
	export_types = list(/obj/item/mob_trophy/dwarf_skull,
						/obj/item/mob_trophy/fang,
						/obj/item/mob_trophy/war_paw,
						/obj/item/mob_trophy/elder_tentacle,
						/obj/item/mob_trophy/ice_crystal,
						/obj/item/mob_trophy/magma_wing,
						/obj/item/mob_trophy/tail_spike,
						/obj/item/mob_trophy/ice_wing)

/datum/export/lavaland/trophymega
	cost = 10000
	unit_name = "big game hunting trophy"
	export_types = list(/obj/item/mob_trophy/legionnaire_spine,
						/obj/item/mob_trophy/ash_spike,
						/obj/item/mob_trophy/demon_claws,
						/obj/item/mob_trophy/broodmother_tongue,
						/obj/item/mob_trophy/ice_block_talisman,
						/obj/item/mob_trophy/miner_eye,
						/obj/item/mob_trophy/vortex_talisman,
						/obj/item/mob_trophy/blaster_tubes)
*/

/datum/export/lavaland/megafauna/total_printout(datum/export_report/ex, notes = TRUE) //in the unlikely case a miner feels like selling megafauna loot
	. = ..()
	if(. && notes)
		. += " On behalf of the Nanotrasen RnD division: Thank you for your hard work."

/datum/export/lavaland/megafauna/hev/suit
	cost = 30000
	unit_name = "H.E.C.K. suit"
	export_types = list(/obj/item/clothing/suit/space/hostile_environment)

/datum/export/lavaland/megafauna/hev/helmet
	cost = 10000
	unit_name = "H.E.C.K. helmet"
	export_types = list(/obj/item/clothing/head/helmet/space/hostile_environment)

//not technically lavaland but this had a useful infrastructure to store them under
/datum/export/lavaland/gems/rupee
	cost = 3500
	unit_name = "Ruperium Auction"
	export_types = list(/obj/item/gem/rupee)

/datum/export/lavaland/gems/diamond
	cost = 5500
	unit_name = "Frost Diamond Auction"
	export_types = list(/obj/item/gem/fdiamond)

/datum/export/lavaland/gems/amber
	cost = 7500
	unit_name = "Draconic Amber"
	export_types = list(/obj/item/gem/amber)

/datum/export/lavaland/gems/plasma
	cost = 12000
	unit_name = "Metastable Phoron"
	export_types = list(/obj/item/gem/phoron)

/datum/export/lavaland/gems/void
	cost = 23000
	unit_name = "Null Crystal"
	export_types = list(/obj/item/gem/void)

/datum/export/lavaland/gems/blood
	unit_name = "Ichorium Crystal"
	cost = 13000
	export_types = list(/obj/item/gem/bloodstone)
