/turf/open/floor/plasteel
	icon = 'whitesands/icons/turf/floors/tiles.dmi'
	color = COLOR_FLOORTILE_GRAY
	icon_state = "tiled"
	floor_tile = /obj/item/stack/tile/plasteel
	broken_states = list("broken0", "broken1", "broken2")
	burnt_states = list("burned0", "burned1", "burned2")

/turf/open/floor/plasteel/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There's a <b>small crack</b> on the edge where you can pry it with a <b>crowbar</b>.</span>"

/turf/open/floor/plasteel/update_icon()
	if(!..())
		return 0
	if(!broken && !burnt)
		icon_state = icon_regular_floor


/turf/open/floor/plasteel/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/telecomms
	initial_gas_mix = TCOMMS_ATMOS
/turf/open/floor/plasteel/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/plasteel/dark
	color = COLOR_TILE_GRAY
	floor_tile = /obj/item/stack/tile/plasteel/dark
/turf/open/floor/plasteel/dark/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/dark/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/plasteel/white
	color = COLOR_WHITE
	floor_tile = /obj/item/stack/tile/plasteel/white
/turf/open/floor/plasteel/white/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/white/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/plasteel/mono
	icon_state = "monotile"
/turf/open/floor/plasteel/mono/dark
	color = COLOR_TILE_GRAY
/turf/open/floor/plasteel/mono/white
	color = COLOR_WHITE

/turf/open/floor/plasteel/tech
	icon = 'whitesands/icons/turf/floors/techfloor.dmi'
	icon_state = "techfloor_gray"
	color = null

/turf/open/floor/plasteel/tech/grid
	icon_state = "techfloor_grid"
/turf/open/floor/plasteel/tech/techmaint
	icon_state = "techmaint"
/turf/open/floor/plasteel/patterned
	icon_state = "tile_full"
/turf/open/floor/plasteel/patterned/cargo_one
	icon_state = "cargo_one_full"
/turf/open/floor/plasteel/patterned/brushed
	icon_state = "kafel_full"
/turf/open/floor/plasteel/patterned/monofloor
	icon_state = "steel_monofloor"
	color = null
/turf/open/floor/plasteel/patterned/grid
	icon_state = "grid"
/turf/open/floor/plasteel/patterned/ridged
	icon_state = "ridged"

/turf/open/floor/plasteel/showroomfloor
	icon = 'whitesands/icons/turf/floors.dmi'
	icon_state = "showroomfloor"

/turf/open/floor/plasteel/showroomfloor/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plasteel/solarpanel
	icon_state = "solarpanel"
/turf/open/floor/plasteel/airless/solarpanel
	icon_state = "solarpanel"


/turf/open/floor/plasteel/freezer
	color = null
	icon = 'whitesands/icons/turf/floors.dmi'
	icon_state = "freezer"

/turf/open/floor/plasteel/freezer/airless
	initial_gas_mix = AIRLESS_ATMOS


/turf/open/floor/plasteel/kitchen_coldroom
	name = "cold room floor"
	icon = 'whitesands/icons/turf/floors.dmi'
	initial_gas_mix = KITCHEN_COLDROOM_ATMOS
/turf/open/floor/plasteel/kitchen_coldroom/freezerfloor //tempted to make this a subset of freezer
	icon_state = "freezer"


/turf/open/floor/plasteel/grimy
	color = null
	icon = 'whitesands/icons/turf/floors.dmi'
	icon_state = "lino"
	tiled_dirt = FALSE

/turf/open/floor/plasteel/cult
	icon_state = "cult"
	color = null
	name = "engraved floor"

/turf/open/floor/plasteel/vaporwave
	color = null
	icon_state = "pinkblack"
	icon = 'icons/turf/floors.dmi'

/turf/open/floor/plasteel/goonplaque
	icon_state = "plaque"
	name = "commemorative plaque"
	desc = "\"This is a plaque in honour of our comrades on the G4407 Stations. Hopefully TG4407 model can live up to your fame and fortune.\" Scratched in beneath that is a crude image of a meteor and a spaceman. The spaceman is laughing. The meteor is exploding."
	tiled_dirt = FALSE

/turf/open/floor/plasteel/cult/narsie_act()
	return
/turf/open/floor/plasteel/cult/airless
	initial_gas_mix = AIRLESS_ATMOS


/turf/open/floor/plasteel/stairs //considering removal
	icon = 'icons/turf/floors.dmi'
	icon_state = "stairs"
	tiled_dirt = FALSE
/turf/open/floor/plasteel/stairs/left
	icon_state = "stairs-l"
/turf/open/floor/plasteel/stairs/medium
	icon_state = "stairs-m"
/turf/open/floor/plasteel/stairs/right
	icon_state = "stairs-r"
/turf/open/floor/plasteel/stairs/old
	icon_state = "stairs-old"


/turf/open/floor/plasteel/rockvault
	icon_state = "rockvault"
	icon = 'whitesands/icons/turf/floors/misc.dmi'
/turf/open/floor/plasteel/rockvault/alien
	icon_state = "alienvault"
/turf/open/floor/plasteel/rockvault/sandstone
	icon_state = "sandstonevault"


/turf/open/floor/plasteel/elevatorshaft
	icon = 'whitesands/icons/turf/floors.dmi'
	icon_state = "elevatorshaft"
	color = null

/turf/open/floor/plasteel/bluespace
	icon = 'icons/turf/floors.dmi'
	icon_state = "bluespace"
	color = null

/turf/open/floor/plasteel/sepia
	color = "#938170"
