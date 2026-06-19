//claims to be mining.dm
// has a bunch of mob-butcher loot
/datum/export/gems
	desc = "Rare gems and crystals draw many eyes, and just as many buyers."
	elasticity_coeff = 0.3
	valid_event_target = FALSE

/datum/export/gems/rupee
	unit_name = "Ruperium"
	cost = 1000
	export_types = list(/obj/item/gem/rupee)

/datum/export/gems/diamond
	unit_name = "Frost Diamond"
	cost = 3500
	export_types = list(/obj/item/gem/fdiamond)

/datum/export/gems/amber
	unit_name = "Draconic Amber"
	cost = 5500
	export_types = list(/obj/item/gem/amber)

/datum/export/gems/plasma
	unit_name = "Metastable Phoron"
	cost = 11000
	export_types = list(/obj/item/gem/phoron)

/datum/export/gems/void
	unit_name = "Null Crystal"
	cost = 19000
	export_types = list(/obj/item/gem/void)

/datum/export/gems/blood
	unit_name = "Ichorium Crystal"
	cost = 9000
	export_types = list(/obj/item/gem/bloodstone)

/datum/export/gems/strange_crystal
	unit_name = "Strange crystal"
	cost = 4000
	export_types = list(/obj/item/strange_crystal)
