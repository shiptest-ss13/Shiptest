//Synth snouts (This is the most important part)
/datum/sprite_accessory/snouts/synthliz
	recommended_species = list(SPECIES_SYNTHLIZ)
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/synthliz_snouts.dmi'
	color_src = USE_ONE_COLOR
	default_color = null
	name = "Synthetic Lizard - Snout"
	icon_state = "synthliz_basic"

/datum/sprite_accessory/snouts/synthliz/synthliz_under
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Snout Under"
	icon_state = "synthliz_under"

/datum/sprite_accessory/snouts/synthliz/synthliz_tert
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Snout Tertiary"
	icon_state = "synthliz_tert"

/datum/sprite_accessory/snouts/synthliz/synthliz_tertunder
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Snout Tertiary Under"
	icon_state = "synthliz_tertunder"

/datum/sprite_accessory/snouts/synthliz/synthliz_long
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Snout Long"
	icon_state = "synthliz_long"

/datum/sprite_accessory/snouts/synthliz/synthliz_thicklong
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Snout Long & Thick"
	icon_state = "synthliz_thicklong"

/datum/sprite_accessory/snouts/synthliz/barlessbasic
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Barless"
	icon_state = "synthliz_barless_basic"

/datum/sprite_accessory/snouts/synthliz/barlessunder
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Barless Under"
	icon_state = "synthliz_barless_under"

/datum/sprite_accessory/snouts/synthliz/barlessover
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Barless Over"
	icon_state = "synthliz_barless_over"

/datum/sprite_accessory/snouts/synthliz/barlesstert
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Barless Tertiary"
	icon_state = "synthliz_barless_tert"

/datum/sprite_accessory/snouts/synthliz/barlesstertunder
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Barless Tertiary Under"
	icon_state = "synthliz_barless_tertunder"

//Protogen snoot
/datum/sprite_accessory/snouts/synthliz/protogen
	color_src = USE_MATRIXED_COLORS
	name = "Protogen"
	icon_state = "protogen"

/datum/sprite_accessory/snouts/synthliz/protogen_withbolt
	color_src = USE_MATRIXED_COLORS
	name = "Protogen - With Bolt"
	icon_state = "protogen_withbolt"


//Synth tails
/datum/sprite_accessory/tails/synthliz
	recommended_species = list(SPECIES_SYNTHLIZ)
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/synthliz_tails.dmi'
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard"
	icon_state = "synthliz"
	general_type = SPECIES_LIZARD

//Synth Antennae
/datum/sprite_accessory/ipc_antenna/synthliz
	recommended_species = list(SPECIES_SYNTHLIZ)
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/synthliz_antennas.dmi'
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Antennae"
	icon_state = "synth_antennae"
	default_color = null

/datum/sprite_accessory/ipc_antenna/synthliz/synthliz_curled
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Curled"
	icon_state = "synth_curled"

/datum/sprite_accessory/ipc_antenna/synthliz/synthliz_thick
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Thick"
	icon_state = "synth_thick"

/datum/sprite_accessory/ipc_antenna/synthliz/synth_thicklight
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Thick Light"
	icon_state = "synth_thicklight"

/datum/sprite_accessory/ipc_antenna/synthliz/synth_short
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Short"
	icon_state = "synth_short"

/datum/sprite_accessory/ipc_antenna/synthliz/synth_sharp
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Sharp"
	icon_state = "synth_sharp"

/datum/sprite_accessory/ipc_antenna/synthliz/synth_sharplight
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Sharp Light"
	icon_state = "synth_sharplight"

/datum/sprite_accessory/ipc_antenna/synthliz/synth_horns
	color_src = USE_ONE_COLOR
	name = "Synthetic Lizard - Horns"
	icon_state = "synth_horns"

/datum/sprite_accessory/ipc_antenna/synthliz/synth_hornslight
	color_src = USE_MATRIXED_COLORS
	name = "Synthetic Lizard - Horns Light"
	icon_state = "synth_hornslight"

/datum/sprite_accessory/ipc_antenna/synthliz/cobrahood
	name = "Synthetic Lizard - Cobra Hood"
	icon_state = "cobrahood"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/ipc_antenna/synthliz/cobrahoodears
	name = "Synthetic Lizard - Cobra Hood (Ears)"
	icon_state = "cobraears"
	color_src = USE_MATRIXED_COLORS

//Synth Taurs (Ported from Virgo)
/datum/sprite_accessory/taur/synthliz
	name = "Cybernetic Lizard"
	icon_state = "synthlizard"
	taur_mode = BODYTYPE_TAUR_PAW
	recommended_species = list(SPECIES_SYNTHLIZ)

/datum/sprite_accessory/taur/synthliz/inv
	name = "Cybernetic Lizard (Inverted)"
	icon_state = "synthlizardinv"

/datum/sprite_accessory/taur/synthliz/feline
	name = "Cybernetic Feline"
	icon_state = "synthfeline"

/datum/sprite_accessory/taur/synthliz/feline/inv
	name = "Cybernetic Feline (Inverted)"
	icon_state = "synthfelineinv"

/datum/sprite_accessory/taur/synthliz/horse
	name = "Cybernetic Horse"
	icon_state = "synthhorse"
	taur_mode = BODYTYPE_TAUR_HOOF
	alt_taur_mode = BODYTYPE_TAUR_PAW

/datum/sprite_accessory/taur/synthliz/horse/inv
	name = "Cybernetic Horse (Inverted)"
	icon_state = "synthhorseinv"

/datum/sprite_accessory/taur/synthliz/wolf
	name = "Cybernetic Wolf"
	icon_state = "synthwolf"

/datum/sprite_accessory/taur/synthliz/wolf/inv
	name = "Cybernetic Wolf (Inverted)"
	icon_state = "synthwolfinv"

/datum/sprite_accessory/taur/synthliz/synthnaga
	name = "Cybernetic Naga"
	icon_state = "synthnaga"
	taur_mode = BODYTYPE_TAUR_SNAKE
