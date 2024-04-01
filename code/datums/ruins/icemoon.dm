// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/icemoon
	prefix = "_maps/RandomRuins/IceRuins/"
	allow_duplicates = FALSE
	cost = 5
	ruin_type = RUINTYPE_ICE

// above ground only

/datum/map_template/ruin/icemoon/engioutpost
	name = "Engineer Outpost"
	id = "engioutpost"
	description = "Blown up by an unfortunate accident."
	suffix = "icemoon_surface_engioutpost.dmm"


/datum/map_template/ruin/icemoon/hydroponicslab //Shiptest edit
	name = "Hydroponics Lab"
	id = "hydroponicslab"
	description = "An abandoned hydroponics research facility containing hostile plant fauna."
	suffix = "icemoon_hydroponics_lab.dmm"

// above and below ground together


// below ground only

/datum/map_template/ruin/icemoon
	name = "underground ruin"

/datum/map_template/ruin/icemoon/abandonedvillage
	name = "Abandoned Village"
	id = "abandonedvillage"
	description = "Who knows what lies within?"
	suffix = "icemoon_underground_abandoned_village.dmm"

/datum/map_template/ruin/icemoon/corpreject
	name = "NT Security Solutions Site Gamma"
	id = "corpreject"
	description = "Nanotrasen Corporate Security Solutions vault site Gamma."
	suffix = "icemoon_surface_corporate_rejects.dmm"

/datum/map_template/ruin/icemoon/syndicate_outpost
	name = "Abandoned Syndicate Outpost"
	id = "syndicate-outpost-icemoon"
	description = "A outpost that used to be a staging area for nuclear operatives. The Syndicate have moved to another location, but this still remains."
	suffix = "icemoon_underground_abandoned_newcops.dmm"

/datum/map_template/ruin/icemoon/drakelair
	name = "Dragon's Lair"
	id = "drake-lair"
	description = "\"First the creature's Flame breathed from beneath the stone, Hot battle-fumes, and the earth rumbled.\""
	suffix = "icemoon_underground_drakelair.dmm"

/datum/map_template/ruin/icemoon/brazillian_lab
	name = "Barricaded Compound"
	id = "brazillian-lab"
	description = "A conspicuous compound in the middle of the cold wasteland. What goodies are inside?"
	suffix = "icemoon_underground_brazillianlab.dmm"

/datum/map_template/ruin/icemoon/crashed_holemaker
	name = "Crashed Holemaker"
	id = "crashed_holemaker"
	description = "Safety records for early Nanotrasen Spaceworks vessels were, and always have been, top of their class. Absolutely no multi-billion credit projects have been painstakingly erased from history. (Citation Needed)"
	suffix = "icemoon_crashed_holemaker.dmm"
