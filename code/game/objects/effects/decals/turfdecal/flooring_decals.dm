/obj/effect/turf_decal/corner
	layer = TURF_PLATING_DECAL_LAYER
	icon_state = "corner_white"

/obj/effect/turf_decal/corner/Initialize()
	if(SSevents.holidays && SSevents.holidays[APRIL_FOOLS])
		color = "#[random_short_color()]"
	. = ..()

/obj/effect/turf_decal/trimline
	layer = TURF_PLATING_DECAL_LAYER
	icon_state = "trimline_box"

/obj/effect/turf_decal/trimline/Initialize()
	if(SSevents.holidays && SSevents.holidays[APRIL_FOOLS])
		color = "#[random_short_color()]"
	. = ..()

//forgive me for my sins
#define TURF_DECAL_COLOR_HELPER(color_name, tile_color, tile_alpha)		\
	/obj/effect/turf_decal/corner/##color_name {		\
		icon_state = "corner_white";					\
		color = ##tile_color;							\
		alpha = ##tile_alpha;							\
	}													\
	/obj/effect/turf_decal/corner/##color_name/diagonal { \
		icon_state = "corner_white_diagonal";			\
	}													\
	/obj/effect/turf_decal/corner/##color_name/three_quarters { \
		icon_state = "corner_white_three_quarters";		\
	}													\
	/obj/effect/turf_decal/corner/##color_name/full {	\
		icon_state = "corner_white_full";				\
	}													\
	/obj/effect/turf_decal/corner/##color_name/border {	\
		icon_state = "bordercolor";						\
	}													\
	/obj/effect/turf_decal/corner/##color_name/half {	\
		icon_state = "bordercolorhalf";					\
	}													\
	/obj/effect/turf_decal/corner/##color_name/mono {	\
		icon_state = "bordercolormonofull";				\
	}													\
	/obj/effect/turf_decal/corner/##color_name/bordercorner { \
		icon_state = "bordercolorcorner";				\
	}													\
	/obj/effect/turf_decal/corner/##color_name/borderfull { \
		icon_state = "bordercolorfull";					\
	}													\
	/obj/effect/turf_decal/corner/##color_name/bordercee { \
		icon_state = "bordercolorcee";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name {		\
		color = ##tile_color;							\
		alpha = ##tile_alpha							\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/line { \
		icon_state = "trimline";						\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/corner { \
		icon_state = "trimline_corner";					\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/end {	\
		icon_state = "trimline_end";					\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/arrow_cw { \
		icon_state = "trimline_arrow_cw";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/arrow_ccw { \
		icon_state = "trimline_arrow_ccw";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/warning { \
		icon_state = "trimline_warn";					\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/warning { \
		icon_state = "trimline_warn";					\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled { \
		icon_state = "trimline_box_fill";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled/line { \
		icon_state = "trimline_fill";					\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled/corner { \
		icon_state = "trimline_corner_fill";			\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled/end { \
		icon_state = "trimline_end_fill";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled/arrow_cw { \
		icon_state = "trimline_arrow_cw_fill";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled/arrow_ccw { \
		icon_state = "trimline_arrow_ccw_fill";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled/warning { \
		icon_state = "trimline_warn_fill";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled/shrink_cw { \
		icon_state = "trimline_shrink_cw";				\
	}													\
	/obj/effect/turf_decal/trimline/##color_name/filled/shrink_ccw { \
		icon_state = "trimline_shrink_ccw";				\
	}													\
	/obj/effect/turf_decal/spline/plain/##color_name {	\
		color = ##tile_color							\
	}													\
	/obj/effect/turf_decal/spline/fancy/##color_name {	\
		color = ##tile_color							\
	}													\
	/obj/effect/turf_decal/spline/fancy/##color_name/corner {	\
		icon_state = "spline_fancy_corner"				\
	}													\
	/obj/effect/turf_decal/road/line/##color_name {		\
		color = ##tile_color							\
	}													\
	/obj/effect/turf_decal/road/line/edge/##color_name {		\
		color = ##tile_color							\
	}

//opaque
TURF_DECAL_COLOR_HELPER(opaque/neutral, null, 255)
TURF_DECAL_COLOR_HELPER(opaque/black, COLOR_TILE_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/blue, COLOR_BLUE_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/green, COLOR_GREEN_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/lime, COLOR_PALE_GREEN_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/yellow, COLOR_BROWN, 255)
TURF_DECAL_COLOR_HELPER(opaque/beige, COLOR_BEIGE, 255)
TURF_DECAL_COLOR_HELPER(opaque/red, COLOR_RED_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/bar, "#791500", 255)
TURF_DECAL_COLOR_HELPER(opaque/pink, COLOR_PALE_RED_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/purple, COLOR_PURPLE_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/mauve, COLOR_PALE_PURPLE_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/orange, COLOR_DARK_ORANGE, 255)
TURF_DECAL_COLOR_HELPER(opaque/brown, COLOR_DARK_BROWN, 255)
TURF_DECAL_COLOR_HELPER(opaque/white, COLOR_WHITE, 255)
TURF_DECAL_COLOR_HELPER(opaque/grey, COLOR_FLOORTILE_GRAY, 255)
TURF_DECAL_COLOR_HELPER(opaque/lightgrey, "#a8b2b6", 255)
TURF_DECAL_COLOR_HELPER(opaque/bottlegreen, "#57967f", 255)
TURF_DECAL_COLOR_HELPER(opaque/ntblue, "#283674", 255)
TURF_DECAL_COLOR_HELPER(opaque/solgovblue, "#2d2a4e", 255)
TURF_DECAL_COLOR_HELPER(opaque/solgovgold, "#eeac2e", 255)
TURF_DECAL_COLOR_HELPER(opaque/syndiered, "#730622", 255)
TURF_DECAL_COLOR_HELPER(opaque/inteqbrown, "#4b2a18", 255)

//transparent
TURF_DECAL_COLOR_HELPER(transparent/neutral, null, 75)
TURF_DECAL_COLOR_HELPER(transparent/black, COLOR_TILE_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/blue, COLOR_BLUE_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/green, COLOR_GREEN_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/lime, COLOR_PALE_GREEN_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/yellow, COLOR_BROWN, 140)
TURF_DECAL_COLOR_HELPER(transparent/beige, COLOR_BEIGE, 140)
TURF_DECAL_COLOR_HELPER(transparent/red, COLOR_RED_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/bar, "#791500", 130)
TURF_DECAL_COLOR_HELPER(transparent/pink, COLOR_PALE_RED_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/purple, COLOR_PURPLE_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/mauve, COLOR_PALE_PURPLE_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/orange, COLOR_DARK_ORANGE, 140)
TURF_DECAL_COLOR_HELPER(transparent/brown, COLOR_DARK_BROWN, 140)
TURF_DECAL_COLOR_HELPER(transparent/white, COLOR_WHITE, 140)
TURF_DECAL_COLOR_HELPER(transparent/grey, COLOR_FLOORTILE_GRAY, 140)
TURF_DECAL_COLOR_HELPER(transparent/lightgrey, "#a8b2b6", 140)
TURF_DECAL_COLOR_HELPER(transparent/bottlegreen, "#57967f", 140)
TURF_DECAL_COLOR_HELPER(transparent/ntblue, "#283674", 140)
TURF_DECAL_COLOR_HELPER(transparent/solgovblue, "#2d2a4e", 140)
TURF_DECAL_COLOR_HELPER(transparent/solgovgold, "#eeac2e", 140)
TURF_DECAL_COLOR_HELPER(transparent/syndiered, "#730622", 140)
TURF_DECAL_COLOR_HELPER(transparent/inteqbrown, "#4b2a18", 140)

/obj/effect/turf_decal/spline/plain
	icon_state = "spline_plain"
	alpha = 229

/obj/effect/turf_decal/spline/fancy
	icon_state = "spline_fancy"

/obj/effect/turf_decal/spline/fancy/wood
	name = "spline - wood"
	color = "#cb9e04"

/obj/effect/turf_decal/spline/fancy/wood/corner
	icon_state = "spline_fancy_corner"

/obj/effect/turf_decal/spline/fancy/wood/cee
	icon_state = "spline_fancy_cee"

/obj/effect/turf_decal/spline/fancy/wood/three_quarters
	icon_state = "spline_fancy_full"

/obj/effect/turf_decal/industrial/warning
	name = "hazard stripes"
	color = "#d2d53d"
	icon_state = "stripe"

/obj/effect/turf_decal/industrial/warning/corner
	icon_state = "stripecorner"

/obj/effect/turf_decal/industrial/warning/full
	icon_state = "stripefull"


/obj/effect/turf_decal/industrial/warning/cee
	icon_state = "stripecee"

/obj/effect/turf_decal/industrial/warning/fulltile
	icon_state = "stripefulltile"

/obj/effect/turf_decal/industrial/custodial
	name = "custodial stripes"
	icon_state = "stripe"
	color =  "#c900fb"

/obj/effect/turf_decal/industrial/custodial/corner
	icon_state = "stripecorner"

/obj/effect/turf_decal/industrial/custodial/full
	icon_state = "stripefull"

/obj/effect/turf_decal/industrial/custodial/cee
	icon_state = "stripecee"

/obj/effect/turf_decal/industrial/custodial/fulltile
	icon_state = "stripefulltile"

/obj/effect/turf_decal/industrial/fire
	name = "fire safety stripes"
	icon_state = "stripe"
	color = "#c90000"

/obj/effect/turf_decal/industrial/fire/corner
	icon_state = "stripecorner"

/obj/effect/turf_decal/industrial/fire/full
	icon_state = "stripefull"

/obj/effect/turf_decal/industrial/fire/cee
	icon_state = "stripecee"

/obj/effect/turf_decal/industrial/fire/fulltile
	icon_state = "stripefulltile"

/obj/effect/turf_decal/industrial/radiation
	name = "radiation hazard stripes"
	icon_state = "stripe"
	color = "#d2d53d"
	detail_overlay = "overstripe"
	detail_color =  "#c900fb"

/obj/effect/turf_decal/industrial/radiation/corner
	icon_state = "stripecorner"
	detail_overlay = "overstripecorner"

/obj/effect/turf_decal/industrial/radiation/full
	icon_state = "stripefull"
	detail_overlay = "overstripefull"

/obj/effect/turf_decal/industrial/radiation/cee
	icon_state = "stripecee"
	detail_overlay = "overstripecee"

/obj/effect/turf_decal/industrial/radiation/fulltile
	icon_state = "stripefulltile"

/obj/effect/turf_decal/industrial/firstaid
	name = "first aid stripes"
	icon_state = "stripe"
	color =  "#00cd00"

/obj/effect/turf_decal/industrial/firstaid/corner
	icon_state = "stripecorner"

/obj/effect/turf_decal/industrial/firstaid/full
	icon_state = "stripefull"

/obj/effect/turf_decal/industrial/firstaid/cee
	icon_state = "stripecee"

/obj/effect/turf_decal/industrial/firstaid/fulltile
	icon_state = "stripefulltile"

/obj/effect/turf_decal/industrial/defective
	name = "defective machinery stripes"
	icon_state = "stripe"
	color = "#0000fb"

/obj/effect/turf_decal/industrial/defective/corner
	icon_state = "stripecorner"

/obj/effect/turf_decal/industrial/defective/full
	icon_state = "stripefull"

/obj/effect/turf_decal/industrial/defective/cee
	icon_state = "stripecee"

/obj/effect/turf_decal/industrial/defective/fulltile
	icon_state = "stripefulltile"

/obj/effect/turf_decal/industrial/traffic
	name = "traffic hazard stripes"
	icon_state = "stripe"
	color = "#fb9700"

/obj/effect/turf_decal/industrial/traffic/corner
	icon_state = "stripecorner"

/obj/effect/turf_decal/industrial/traffic/full
	icon_state = "stripefull"

/obj/effect/turf_decal/industrial/traffic/cee
	icon_state = "stripecee"

/obj/effect/turf_decal/industrial/traffic/fulltile
	icon_state = "stripefulltile"

/obj/effect/turf_decal/industrial/warning/dust
	name = "hazard stripes"
	icon_state = "warning_dust"

/obj/effect/turf_decal/industrial/warning/dust/corner
	name = "hazard stripes"
	icon_state = "warningcorner_dust"

/obj/effect/turf_decal/industrial/hatch
	name = "hatched marking"
	icon_state = "delivery"
	alpha = 229

/obj/effect/turf_decal/industrial/hatch/yellow
	color = "#cfcf55"

/obj/effect/turf_decal/industrial/hatch/red
	color = COLOR_RED_GRAY

/obj/effect/turf_decal/industrial/hatch/orange
	color = COLOR_DARK_ORANGE

/obj/effect/turf_decal/industrial/hatch/blue
	color = COLOR_BLUE_GRAY

/obj/effect/turf_decal/industrial/shutoff
	name = "shutoff valve marker"
	icon_state = "shutoff"

/obj/effect/turf_decal/industrial/outline
	name = "white outline"
	icon_state = "outline"
	alpha = 229

/obj/effect/turf_decal/industrial/outline/blue
	name = "blue outline"
	color = "#00b8b2"

/obj/effect/turf_decal/industrial/outline/yellow
	name = "yellow outline"
	color = "#cfcf55"

/obj/effect/turf_decal/industrial/outline/grey
	name = "grey outline"
	color = "#808080"

/obj/effect/turf_decal/industrial/outline/red
	name = "red outline"
	color = COLOR_RED_GRAY

/obj/effect/turf_decal/industrial/outline/orange
	name = "orange outline"
	color = COLOR_DARK_ORANGE

/obj/effect/turf_decal/industrial/loading
	name = "loading area"
	icon_state = "loadingarea"
	alpha = 229
	detail_overlay = "loadingarea"

/obj/effect/turf_decal/industrial/loading/red
	detail_color = COLOR_RED_GRAY
	detail_overlay = "loadingarea_stripes"

/obj/effect/turf_decal/industrial/loading/white
	detail_color = COLOR_WHITE
	detail_overlay = "loadingarea_stripes"

/obj/effect/turf_decal/industrial/caution
	icon_state = "caution"
	color = COLOR_YELLOW

/obj/effect/turf_decal/industrial/caution/white
	color = COLOR_WHITE

/obj/effect/turf_decal/industrial/caution/red
	color = COLOR_RED

/obj/effect/turf_decal/industrial/stand_clear
	icon_state = "stand_clear"
	color = COLOR_YELLOW

/obj/effect/turf_decal/industrial/stand_clear/white
	color = COLOR_WHITE

/obj/effect/turf_decal/industrial/stand_clear/red
	color = COLOR_RED

/obj/effect/turf_decal/industrial/caution
	icon_state = "caution"
	color = COLOR_YELLOW

/obj/effect/turf_decal/industrial/caution/white
	color = COLOR_WHITE

/obj/effect/turf_decal/industrial/caution/red
	color = COLOR_RED

/obj/effect/turf_decal/plaque
	name = "plaque"
	icon_state = "plaque"
	icon = 'icons/turf/decals.dmi'

/obj/effect/turf_decal/asteroid
	name = "random asteroid rubble"
	icon_state = "asteroid0"

/obj/effect/turf_decal/asteroid/New()
	icon_state = "asteroid[rand(0,9)]"
	..()

/obj/effect/turf_decal/chapel
	name = "chapel"
	icon_state = "chapel"

/obj/effect/turf_decal/ss13/l1
	name = "L1"
	icon_state = "L1"

/obj/effect/turf_decal/ss13/l2
	name = "L2"
	icon_state = "L2"

/obj/effect/turf_decal/ss13/l3
	name = "L3"
	icon_state = "L3"

/obj/effect/turf_decal/ss13/l4
	name = "L4"
	icon_state = "L4"

/obj/effect/turf_decal/ss13/l5
	name = "L5"
	icon_state = "L5"

/obj/effect/turf_decal/ss13/l6
	name = "L6"
	icon_state = "L6"

/obj/effect/turf_decal/ss13/l7
	name = "L7"
	icon_state = "L7"

/obj/effect/turf_decal/ss13/l8
	name = "L8"
	icon_state = "L8"

/obj/effect/turf_decal/ss13/l9
	name = "L9"
	icon_state = "L9"

/obj/effect/turf_decal/ss13/l10
	name = "L10"
	icon_state = "L10"

/obj/effect/turf_decal/ss13/l11
	name = "L11"
	icon_state = "L11"

/obj/effect/turf_decal/ss13/l12
	name = "L12"
	icon_state = "L12"

/obj/effect/turf_decal/ss13/l13
	name = "L13"
	icon_state = "L13"

/obj/effect/turf_decal/ss13/l14
	name = "L14"
	icon_state = "L14"

/obj/effect/turf_decal/ss13/l15
	name = "L15"
	icon_state = "L15"

/obj/effect/turf_decal/ss13/l16
	name = "L16"
	icon_state = "L16"

/obj/effect/turf_decal/sign
	name = "floor sign"
	icon_state = "white_1"

/obj/effect/turf_decal/sign/two
	icon_state = "white_2"

/obj/effect/turf_decal/sign/a
	icon_state = "white_a"

/obj/effect/turf_decal/sign/b
	icon_state = "white_b"

/obj/effect/turf_decal/sign/c
	icon_state = "white_c"

/obj/effect/turf_decal/sign/d
	icon_state = "white_d"

/obj/effect/turf_decal/sign/ex
	icon_state = "white_ex"

/obj/effect/turf_decal/sign/m
	icon_state = "white_m"

/obj/effect/turf_decal/sign/cmo
	icon_state = "white_cmo"

/obj/effect/turf_decal/sign/v
	icon_state = "white_v"

/obj/effect/turf_decal/sign/p
	icon_state = "white_p"

/obj/effect/turf_decal/solarpanel
	icon_state = "solarpanel"

/obj/effect/turf_decal/snow
	icon = 'icons/turf/overlays.dmi'
	icon_state = "snowfloor"

/obj/effect/turf_decal/floordetail
	color = "#545c68"
	icon_state = "manydot"
	appearance_flags = 0

/obj/effect/turf_decal/floordetail/tiled
	icon_state = "manydot_tiled"

/obj/effect/turf_decal/floordetail/pryhole
	icon_state = "pryhole"

/obj/effect/turf_decal/floordetail/edgedrain
	icon_state = "edge"

/obj/effect/turf_decal/floordetail/traction
	icon_state = "traction"

/obj/effect/turf_decal/ntlogo
	icon_state = "ntlogo"

//Techfloor

/obj/effect/turf_decal/corner_techfloor_gray
	name = "corner techfloorgray"
	icon_state = "corner_techfloor_gray"

/obj/effect/turf_decal/corner_techfloor_gray/diagonal
	name = "corner techfloorgray diagonal"
	icon_state = "corner_techfloor_gray_diagonal"

/obj/effect/turf_decal/corner_techfloor_gray/full
	name = "corner techfloorgray full"
	icon_state = "corner_techfloor_gray_full"

/obj/effect/turf_decal/corner_techfloor_grid
	name = "corner techfloorgrid"
	icon_state = "corner_techfloor_grid"

/obj/effect/turf_decal/corner_techfloor_grid/diagonal
	name = "corner techfloorgrid diagonal"
	icon_state = "corner_techfloor_grid_diagonal"

/obj/effect/turf_decal/corner_techfloor_grid/full
	name = "corner techfloorgrid full"
	icon_state = "corner_techfloor_grid_full"

/obj/effect/turf_decal/corner_steel_grid
	name = "corner steel_grid"
	icon_state = "steel_grid"

/obj/effect/turf_decal/corner_steel_grid/diagonal
	name = "corner tsteel_grid diagonal"
	icon_state = "steel_grid_diagonal"

/obj/effect/turf_decal/corner_steel_grid/full
	name = "corner steel_grid full"
	icon_state = "steel_grid_full"

/obj/effect/turf_decal/borderfloor
	name = "border floor"
	icon_state = "borderfloor_white"
	color = "#545c68"

/obj/effect/turf_decal/borderfloor/corner
	icon_state = "borderfloorcorner_white"

/obj/effect/turf_decal/borderfloor/corner2
	icon_state = "borderfloorcorner2_white"

/obj/effect/turf_decal/borderfloor/full
	icon_state = "borderfloorfull_white"

/obj/effect/turf_decal/borderfloor/cee
	icon_state = "borderfloorcee_white"

/obj/effect/turf_decal/borderfloorblack
	name = "border floor"
	icon_state = "borderfloor_white"
	color = COLOR_ALMOST_BLACK

/obj/effect/turf_decal/borderfloorblack/corner
	icon_state = "borderfloorcorner_white"

/obj/effect/turf_decal/borderfloorblack/corner2
	icon_state = "borderfloorcorner2_white"

/obj/effect/turf_decal/borderfloorblack/full
	icon_state = "borderfloorfull_white"

/obj/effect/turf_decal/borderfloorblack/cee
	icon_state = "borderfloorcee_white"

/obj/effect/turf_decal/borderfloorwhite
	name = "border floor"
	icon_state = "borderfloor_white"

/obj/effect/turf_decal/borderfloorwhite/corner
	icon_state = "borderfloorcorner_white"

/obj/effect/turf_decal/borderfloorwhite/corner2
	icon_state = "borderfloorcorner2_white"

/obj/effect/turf_decal/borderfloorwhite/full
	icon_state = "borderfloorfull_white"

/obj/effect/turf_decal/borderfloorwhite/cee
	icon_state = "borderfloorcee_white"

/obj/effect/turf_decal/steeldecal
	name = "steel decal"
	icon_state = "steel_decals1"
	color = "#545c68"

/obj/effect/turf_decal/steeldecal/steel_decals1
	icon_state = "steel_decals1"

/obj/effect/turf_decal/steeldecal/steel_decals2
	icon_state = "steel_decals2"

/obj/effect/turf_decal/steeldecal/steel_decals3
	icon_state = "steel_decals3"

/obj/effect/turf_decal/steeldecal/steel_decals4
	icon_state = "steel_decals4"

/obj/effect/turf_decal/steeldecal/steel_decals6
	icon_state = "steel_decals6"

/obj/effect/turf_decal/steeldecal/steel_decals7
	icon_state = "steel_decals7"

/obj/effect/turf_decal/steeldecal/steel_decals8
	icon_state = "steel_decals8"

/obj/effect/turf_decal/steeldecal/steel_decals9
	icon_state = "steel_decals9"

/obj/effect/turf_decal/steeldecal/steel_decals10
	icon_state = "steel_decals10"

/obj/effect/turf_decal/steeldecal/steel_decals_central1
	icon_state = "steel_decals_central1"

/obj/effect/turf_decal/steeldecal/steel_decals_central2
	icon_state = "steel_decals_central2"

/obj/effect/turf_decal/steeldecal/steel_decals_central3
	icon_state = "steel_decals_central3"

/obj/effect/turf_decal/steeldecal/steel_decals_central4
	icon_state = "steel_decals_central4"

/obj/effect/turf_decal/steeldecal/steel_decals_central5
	icon_state = "steel_decals_central5"

/obj/effect/turf_decal/steeldecal/steel_decals_central6
	icon_state = "steel_decals_central6"

/obj/effect/turf_decal/steeldecal/steel_decals_central7
	icon_state = "steel_decals_central7"

/obj/effect/turf_decal/techfloor
	name = "techfloor edges"
	icon_state = "techfloor_edges"

/obj/effect/turf_decal/techfloor/corner
	name = "techfloor corner"
	icon_state = "techfloor_corners"

/obj/effect/turf_decal/techfloor/orange
	name = "techfloor edges"
	icon_state = "techfloororange_edges"

/obj/effect/turf_decal/techfloor/orange/corner
	name = "techfloor corner"
	icon_state = "techfloororange_corners"

/obj/effect/turf_decal/techfloor/hole
	name = "hole left"
	icon_state = "techfloor_hole_left"

/obj/effect/turf_decal/techfloor/hole/right
	name = "hole right"
	icon_state = "techfloor_hole_right"

/obj/effect/turf_decal/stoneborder
	name = "stone border"
	icon_state = "stoneborder"

/obj/effect/turf_decal/stoneborder/corner
	icon_state = "stoneborder_c"

/obj/effect/turf_decal/rechargefloor
	icon_state = "recharge_floor"

/obj/effect/turf_decal/solgov //Credit to baystation for these sprites!
	alpha = 230
	icon = 'icons/obj/solgov_floor.dmi'
	icon_state = "center"

/obj/effect/turf_decal/road
	name = "roal decal"
	icon_state = "road"
	alpha = 180

/obj/effect/turf_decal/road/edge
	icon_state = "road_edge"

/obj/effect/turf_decal/road/stripes
	icon_state = "road_stripes"

/obj/effect/turf_decal/road/stop
	icon_state = "road_stop"

/obj/effect/turf_decal/road/slow
	icon_state = "road_slow"

/obj/effect/turf_decal/road/line
	icon_state = "road_line"

/obj/effect/turf_decal/road/line/edge
	icon_state = "road_line_edge"


/obj/effect/turf_decal/minutemen
	name = "minutemen logo"
	icon_state = "mm_edge"

/obj/effect/turf_decal/minutemen/corner
	icon_state = "mm_corner"

/obj/effect/turf_decal/minutemen/edge
	icon_state = "mm_edge"

/obj/effect/turf_decal/minutemen/middle
	icon_state = "mm_middle"
