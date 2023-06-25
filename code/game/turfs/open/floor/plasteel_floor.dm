/turf/open/floor/plasteel
	icon = 'icons/turf/floors/tiles.dmi'
	base_icon_state = "tiled_gray"
	icon_state = "tiled_gray"
	floor_tile = /obj/item/stack/tile/plasteel
	broken_states = list("broken0", "broken1", "broken2")
	burnt_states = list("burned0", "burned1", "burned2")

/turf/open/floor/plasteel/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There's a <b>small crack</b> on the edge where you can pry it with a <b>crowbar</b>.</span>"

/turf/open/floor/plasteel/update_icon_state()
	if(broken || burnt)
		return
	icon_state = base_icon_state

/turf/open/floor/plasteel/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plasteel/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/plasteel/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/plasteel/dark
	icon_state = "tiled_dark"
	base_icon_state = "tiled_dark"
	floor_tile = /obj/item/stack/tile/plasteel/dark
/turf/open/floor/plasteel/dark/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/dark/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/plasteel/white
	icon_state = "tiled_light"
	base_icon_state = "tiled_light"
	floor_tile = /obj/item/stack/tile/plasteel/white
/turf/open/floor/plasteel/white/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/white/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/plasteel/mono
	icon_state = "monotile_gray"
	base_icon_state = "monotile_gray"
/turf/open/floor/plasteel/mono/dark
	icon_state = "monotile_dark"
	base_icon_state = "monotile_dark"
/turf/open/floor/plasteel/mono/white
	icon_state = "monotile_light"
	base_icon_state = "monotile_light"

/turf/open/floor/plasteel/tech
	icon = 'icons/turf/floors/techfloor.dmi'
	icon_state = "techfloor"
	base_icon_state = "techfloor"
	floor_tile = /obj/item/stack/tile/plasteel/tech

/turf/open/floor/plasteel/tech/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plasteel/tech/grid
	icon_state = "techfloor_grid"
	base_icon_state = "techfloor_grid"
	floor_tile = /obj/item/stack/tile/plasteel/tech/grid
/turf/open/floor/plasteel/tech/grid/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/tech/techmaint
	icon_state = "techmaint"
	base_icon_state = "techmaint"
	floor_tile = /obj/item/stack/tile/plasteel/tech/techmaint
/turf/open/floor/plasteel/tech/techmaint/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/patterned
	icon_state = "tile_full"
	base_icon_state = "tile_full"
/turf/open/floor/plasteel/patterned/cargo_one
	icon_state = "cargo_one_full"
	base_icon_state = "cargo_one_full"
/turf/open/floor/plasteel/patterned/brushed
	icon_state = "kafel_full"
	base_icon_state = "kafel_full"

/turf/open/floor/plasteel/patterned/grid
	icon_state = "grid"
	base_icon_state = "grid"
/turf/open/floor/plasteel/patterned/ridged
	icon_state = "ridged"
	base_icon_state = "ridged"

/turf/open/floor/plasteel/showroomfloor
	icon = 'icons/turf/floors.dmi'
	icon_state = "showroomfloor"
	base_icon_state = "showroomfloor"

/turf/open/floor/plasteel/showroomfloor/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plasteel/solarpanel
	icon_state = "solarpanel"
	base_icon_state = "solarpanel"

/turf/open/floor/plasteel/airless/solarpanel
	icon_state = "solarpanel"
	base_icon_state = "solarpanel"


/turf/open/floor/plasteel/freezer
	icon = 'icons/turf/floors.dmi'
	icon_state = "freezer"
	base_icon_state = "freezer"

/turf/open/floor/plasteel/freezer/airless
	initial_gas_mix = AIRLESS_ATMOS


/turf/open/floor/plasteel/kitchen_coldroom
	name = "cold room floor"
	icon = 'icons/turf/floors.dmi'
	initial_gas_mix = KITCHEN_COLDROOM_ATMOS

/turf/open/floor/plasteel/kitchen_coldroom/freezerfloor //tempted to make this a subset of freezer
	icon_state = "freezer"
	base_icon_state = "freezer"


/turf/open/floor/plasteel/grimy
	icon = 'icons/turf/floors.dmi'
	icon_state = "lino"
	base_icon_state = "lino"
	tiled_dirt = FALSE
	floor_tile = /obj/item/stack/tile/plasteel/grimy

/turf/open/floor/plasteel/cult
	icon_state = "cult"
	base_icon_state = "cult"
	name = "engraved floor"

/turf/open/floor/plasteel/vaporwave
	icon = 'icons/turf/floors.dmi'
	icon_state = "pinkblack"
	base_icon_state = "pinkblack"

/turf/open/floor/plasteel/goonplaque
	name = "commemorative plaque"
	desc = "\"This is a plaque in honour of our comrades on the G4407 Stations. Hopefully TG4407 model can live up to your fame and fortune.\" Scratched in beneath that is a crude image of a meteor and a spaceman. The spaceman is laughing. The meteor is exploding."
	icon_state = "plaque"
	base_icon_state = "plaque"
	tiled_dirt = FALSE

/turf/open/floor/plasteel/cult/narsie_act()
	return

/turf/open/floor/plasteel/cult/airless
	initial_gas_mix = AIRLESS_ATMOS


/turf/open/floor/plasteel/stairs //considering removal
	icon = 'icons/turf/floors.dmi'
	icon_state = "stairs"
	base_icon_state = "stairs"
	tiled_dirt = FALSE
	color = COLOR_FLOORTILE_GRAY

/turf/open/floor/plasteel/stairs/left
	icon_state = "stairs-l"
	base_icon_state = "stairs-l"

/turf/open/floor/plasteel/stairs/medium
	icon_state = "stairs-m"
	base_icon_state = "stairs-m"

/turf/open/floor/plasteel/stairs/right
	icon_state = "stairs-r"
	base_icon_state = "stairs-r"

/turf/open/floor/plasteel/stairs/old
	icon_state = "stairs-old"
	base_icon_state = "stairs-old"

/turf/open/floor/plasteel/stairs/wood
	color = "#A47449"
	barefootstep = "wood"
	footstep = "wood"

/turf/open/floor/plasteel/rockvault
	icon_state = "rockvault"
	base_icon_state = "rockvault"
	icon = 'icons/turf/floors/misc.dmi'

/turf/open/floor/plasteel/rockvault/alien
	icon_state = "alienvault"
	base_icon_state = "alienvault"

/turf/open/floor/plasteel/rockvault/sandstone
	icon_state = "sandstonevault"
	base_icon_state = "sandstonevault"


/turf/open/floor/plasteel/elevatorshaft
	icon = 'icons/turf/floors.dmi'
	icon_state = "elevatorshaft"
	base_icon_state = "elevatorshaft"

/turf/open/floor/plasteel/bluespace
	icon = 'icons/turf/floors.dmi'
	icon_state = "bluespace"
	base_icon_state = "bluespace"

/turf/open/floor/plasteel/sepia
	icon_state = "tiled_light"
	base_icon_state = "tiled_light"
	color = "#938170"

/turf/open/floor/plasteel/icecropolis
	baseturfs = /turf/open/indestructible/necropolis/air
