/turf/open/floor
	icon = 'starbloom_modules/aesthetics/floors/icons/floors.dmi'

//Removes redundant textured stuff from this radial, as all of ours are textured by default
/obj/item/stack/tile/iron
	tile_reskin_types = list(
		/obj/item/stack/tile/iron,
		/obj/item/stack/tile/iron/edge,
		/obj/item/stack/tile/iron/half,
		/obj/item/stack/tile/iron/corner,
		/obj/item/stack/tile/iron/large,
		/obj/item/stack/tile/iron/dark,
		/obj/item/stack/tile/iron/dark/smooth_edge,
		/obj/item/stack/tile/iron/dark/smooth_half,
		/obj/item/stack/tile/iron/dark/smooth_corner,
		/obj/item/stack/tile/iron/dark/smooth_large,
		/obj/item/stack/tile/iron/dark_side,
		/obj/item/stack/tile/iron/dark_corner,
		/obj/item/stack/tile/iron/checker,
		/obj/item/stack/tile/iron/white,
		/obj/item/stack/tile/iron/white/smooth_edge,
		/obj/item/stack/tile/iron/white/smooth_half,
		/obj/item/stack/tile/iron/white/smooth_corner,
		/obj/item/stack/tile/iron/white/smooth_large,
		/obj/item/stack/tile/iron/white_side,
		/obj/item/stack/tile/iron/white_corner,
		/obj/item/stack/tile/iron/cafeteria,
		/obj/item/stack/tile/iron/recharge_floor,
		/obj/item/stack/tile/iron/smooth,
		/obj/item/stack/tile/iron/smooth_edge,
		/obj/item/stack/tile/iron/smooth_half,
		/obj/item/stack/tile/iron/smooth_corner,
		/obj/item/stack/tile/iron/smooth_large,
		/obj/item/stack/tile/iron/chapel,
		/obj/item/stack/tile/iron/showroomfloor,
		/obj/item/stack/tile/iron/solarpanel,
		/obj/item/stack/tile/iron/freezer,
		/obj/item/stack/tile/iron/grimy,
		/obj/item/stack/tile/iron/sepia,
	)

// iron Kitchen
/turf/open/floor/iron/kitchen
	icon_state = "blackchecker"
	base_icon_state = "blackchecker"

// iron + Red
/turf/open/floor/iron/red
	icon_state = "redfull"
	base_icon_state = "redfull"
/turf/open/floor/iron/red/side
	icon_state = "red"
	base_icon_state = "red"

/turf/open/floor/iron/red/corner
	icon_state = "redcorner"
	base_icon_state = "redcorner"

// iron + Green
/turf/open/floor/iron/green
	icon_state = "greenfull"
	base_icon_state = "greenfull"

/turf/open/floor/iron/green/side
	icon_state = "green"
	base_icon_state = "green"

/turf/open/floor/iron/green/corner
	icon_state = "greencorner"
	base_icon_state = "greencorner"

// iron + Brown
/turf/open/floor/iron/brown/side
	icon_state = "brown"
	base_icon_state = "brown"

/turf/open/floor/iron/brown/corner
	icon_state = "browncorner"
	base_icon_state = "browncorner"

// Dark + Purple
/turf/open/floor/iron/dark/purple
	icon_state = "darkpurplefull"
	base_icon_state = "darkpurplefull"

/turf/open/floor/iron/dark/purple/side
	icon_state = "darkpurple"
	base_icon_state = "darkpurple"

/turf/open/floor/iron/dark/purple/corner
	icon_state = "darkpurplecorners"
	base_icon_state = "darkpurplecorners"

// Dark + Red
/turf/open/floor/iron/dark/red
	icon_state = "darkredfull"
	base_icon_state = "darkredfull"

/turf/open/floor/iron/dark/red/side
	icon_state = "darkred"
	base_icon_state = "darkred"

/turf/open/floor/iron/dark/red/corner
	icon_state = "darkredcorners"
	base_icon_state = "darkredcorners"

// Dark + Blue
/turf/open/floor/iron/dark/blue
	icon_state = "darkbluefull"
	base_icon_state = "darkbluefull"

/turf/open/floor/iron/dark/blue/side
	icon_state = "darkblue"
	base_icon_state = "darkblue"

/turf/open/floor/iron/dark/blue/corner
	icon_state = "darkbluecorners"
	base_icon_state = "darkbluecorners"

// Dark + Green
/turf/open/floor/iron/dark/green
	icon_state = "darkgreenfull"
	base_icon_state = "darkgreenfull"

/turf/open/floor/iron/dark/green/side
	icon_state = "darkgreen"
	base_icon_state = "darkgreen"

/turf/open/floor/iron/dark/green/corner
	icon_state = "darkgreencorners"
	base_icon_state = "darkgreencorners"

// Dark + Yellow
/turf/open/floor/iron/dark/yellow
	icon_state = "darkyellowfull"
	base_icon_state = "darkyellowfull"

/turf/open/floor/iron/dark/yellow/side
	icon_state = "darkyellow"
	base_icon_state = "darkyellow"

/turf/open/floor/iron/dark/yellow/corner
	icon_state = "darkyellowcorners"
	base_icon_state = "darkyellowcorners"

// Dark + Brown
/turf/open/floor/iron/dark/brown
	icon_state = "darkbrownfull"
	base_icon_state = "darkbrownfull"

/turf/open/floor/iron/dark/brown/side
	icon_state = "darkbrown"
	base_icon_state = "darkbrown"

/turf/open/floor/iron/dark/brown/corner
	icon_state = "darkbrowncorners"
	base_icon_state = "darkbrowncorners"

/turf/open/indestructible/cobble
	name = "cobblestone path"
	desc = "A simple but beautiful path made of various sized stones."
	icon = 'starbloom_modules/aesthetics/floors/icons/floors.dmi'
	icon_state = "cobble"
	baseturfs = /turf/open/indestructible/cobble
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/indestructible/cobble/side
	icon_state = "cobble_side"

/turf/open/indestructible/cobble/corner
	icon_state = "cobble_corner"

