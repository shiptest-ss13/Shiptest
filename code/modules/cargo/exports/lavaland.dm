//Tendril chest artifacts and ruin loot. Includes ash drake loot since they drop two sets of armor + random item
//Consumable or one-use items like the magic D20 and gluttony's blessing are omitted
//no more 999999 currency after one frost world, sorry

/datum/export/lavaland/minor
	cost = 5000
	unit_name = "minor lava planet artifact"
	export_types = list(/obj/item/immortality_talisman,
						/obj/item/book_of_babel,
						/obj/item/gun/magic/hook,
						/obj/item/wisp_lantern,
						/obj/item/reagent_containers/glass/bottle/potion/flight,
						/obj/item/katana/cursed,
						/obj/item/clothing/glasses/godeye,
						/obj/item/melee/ghost_sword,
						/obj/item/clothing/suit/space/hardsuit/cult,
						/obj/item/voodoo,
						/obj/item/grenade/clusterbuster/inferno,
						/obj/item/clothing/neck/necklace/memento_mori,
						/obj/item/organ/heart/cursed/wizard,
						/obj/item/clothing/suit/hooded/cloak/drake,
						/obj/item/dragons_blood,
						/obj/item/lava_staff,
						/obj/item/ship_in_a_bottle,
						/obj/item/clothing/shoes/clown_shoes/banana_shoes,
						/obj/item/gun/magic/staff/honk,
						/obj/item/kitchen/knife/envy,
						/obj/item/gun/ballistic/revolver/russian/soul,
						/obj/item/veilrender/vealrender,
						/obj/item/nullrod/scythe/talking/necro,
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
						/obj/item/guardiancreator/miner/choose,//this is basically the most valulable mining loot so good luck getting a miner to part ways
						/obj/item/gun/magic/staff/spellblade,
						)

/datum/export/lavaland/trophycommon
	cost = 1500
	unit_name = "common hunting trophy"
	export_types = list(/obj/item/crusher_trophy/legion_skull,
						/obj/item/crusher_trophy/wolf_ear,
						/obj/item/crusher_trophy/bear_paw,
						/obj/item/crusher_trophy/goliath_tentacle,
						/obj/item/crusher_trophy/watcher_wing)

/datum/export/lavaland/trophyrare
	cost = 5000
	unit_name = "rare hunting trophy"
	export_types = list(/obj/item/crusher_trophy/dwarf_skull,
						/obj/item/crusher_trophy/fang,
						/obj/item/crusher_trophy/war_paw,
						/obj/item/crusher_trophy/elder_tentacle,
						/obj/item/crusher_trophy/ice_crystal,
						/obj/item/crusher_trophy/magma_wing,
						/obj/item/crusher_trophy/tail_spike,
						/obj/item/crusher_trophy/ice_wing)

/datum/export/lavaland/trophymega
	cost = 10000
	unit_name = "big game hunting trophy"
	export_types = list(/obj/item/crusher_trophy/legionnaire_spine,
						/obj/item/crusher_trophy/ash_spike,
						/obj/item/crusher_trophy/demon_claws,
						/obj/item/crusher_trophy/broodmother_tongue,
						/obj/item/crusher_trophy/ice_block_talisman,
						/obj/item/crusher_trophy/king_goat,
						/obj/item/crusher_trophy/miner_eye,
						/obj/item/crusher_trophy/vortex_talisman,
						/obj/item/crusher_trophy/blaster_tubes)

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
