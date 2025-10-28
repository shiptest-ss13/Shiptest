/* In this file:
 * Wood floor
 * Grass floor
 * Fake Basalt
 * Carpet floor
 * Fake pits
 * Fake space
 */

/turf/open/floor/wood
	desc = "Stylish dark wood."
	icon_state = "wood"
	icon = 'icons/turf/wood.dmi'
	floor_tile = /obj/item/stack/tile/wood
	broken_states = list("wood-broken", "wood-broken2", "wood-broken3", "wood-broken4", "wood-broken5", "wood-broken6", "wood-broken7")
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	color = WOOD_COLOR_GENERIC
	flammability = 3

/turf/open/floor/wood/mahogany
	color = WOOD_COLOR_RICH

/turf/open/floor/wood/maple
	color = WOOD_COLOR_PALE

/turf/open/floor/wood/ebony
	color = WOOD_COLOR_BLACK

/turf/open/floor/wood/walnut
	color = WOOD_COLOR_CHOCOLATE

/turf/open/floor/wood/bamboo
	color = WOOD_COLOR_PALE2

/turf/open/floor/wood/birch
	color = WOOD_COLOR_PALE3

/turf/open/floor/wood/yew
	color = WOOD_COLOR_YELLOW

/turf/open/floor/wood/examine(mob/user)
	. = ..()
	. += span_notice("There's a few <b>screws</b> and a <b>small crack</b> visible.")

/turf/open/floor/wood/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	return pry_tile(I, user) ? TRUE : FALSE

/turf/open/floor/wood/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	if(T.turf_type == type)
		return
	var/obj/item/tool = user.is_holding_item_of_type(/obj/item/screwdriver)
	if(!tool)
		tool = user.is_holding_item_of_type(/obj/item/crowbar)
	if(!tool)
		return
	var/turf/open/floor/plating/P = pry_tile(tool, user, TRUE)
	if(!istype(P))
		return
	P.attackby(T, user, params)

/turf/open/floor/wood/pry_tile(obj/item/C, mob/user, silent = FALSE)
	C.play_tool_sound(src, 80)
	return remove_tile(user, silent, (C.tool_behaviour == TOOL_SCREWDRIVER))

/turf/open/floor/wood/remove_tile(mob/user, silent = FALSE, make_tile = TRUE)
	if(broken || burnt)
		broken = 0
		burnt = 0
		if(user && !silent)
			to_chat(user, span_notice("You remove the broken planks."))
	else
		if(make_tile)
			if(user && !silent)
				to_chat(user, span_notice("You unscrew the planks."))
			if(floor_tile)
				new floor_tile(src)
		else
			if(user && !silent)
				to_chat(user, span_notice("You forcefully pry off the planks, destroying them in the process."))
	return make_plating()

/turf/open/floor/wood/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/grass
	name = "grass patch"
	desc = "You can't tell if this is real grass or just cheap plastic imitation."
	icon_state = "grass0"
	floor_tile = /obj/item/stack/tile/grass
	broken_states = list("sand")
	flags_1 = NONE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	var/ore_type = /obj/item/stack/ore/glass
	var/turfverb = "uproot"
	tiled_dirt = FALSE
	flammability = 2 // california simulator

/turf/open/floor/grass/Initialize(mapload, inherited_virtual_z)
	. = ..()
	spawniconchange()

/turf/open/floor/grass/proc/spawniconchange()
	icon_state = "grass[rand(0,3)]"

/turf/open/floor/grass/attackby(obj/item/C, mob/user, params)
	if((C.tool_behaviour == TOOL_SHOVEL) && params)
		new ore_type(src, 2)
		user.visible_message(span_notice("[user] digs up [src]."), span_notice("You [turfverb] [src]."))
		playsound(src, 'sound/effects/shovel_dig.ogg', 50, TRUE)
		make_plating()
	if(..())
		return

/turf/open/floor/grass/fairy //like grass but fae-er
	name = "fairygrass patch"
	desc = "Something about this grass makes you want to frolic. Or get high."
	icon_state = "fairygrass0"
	floor_tile = /obj/item/stack/tile/fairygrass
	light_range = 2
	light_power = 0.80
	light_color = COLOR_BLUE_LIGHT

/turf/open/floor/grass/fairy/spawniconchange()
	icon_state = "fairygrass[rand(0,3)]"

/turf/open/floor/grass/fairy/beach
	baseturfs = /turf/open/floor/plating/asteroid/sand
	planetary_atmos = TRUE

/turf/open/floor/grass/snow
	gender = PLURAL
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	desc = "Looks cold."
	icon_state = "snow"
	broken_states = list("snow_dug")
	ore_type = /obj/item/stack/sheet/mineral/snow
	planetary_atmos = TRUE
	floor_tile = null
	initial_gas_mix = FROZEN_ATMOS
	slowdown = 2
	bullet_sizzle = TRUE
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_ASTEROID
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	flammability = -5 // absolutely not

/turf/open/floor/grass/snow/spawniconchange()
	return

/turf/open/floor/grass/snow/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/grass/snow/crowbar_act(mob/living/user, obj/item/I)
	return

/turf/open/floor/grass/snow/safe
	slowdown = 1.5
	planetary_atmos = FALSE


/turf/open/floor/grass/fakebasalt //Heart is not a real planeteer power
	name = "aesthetic volcanic flooring"
	desc = "Safely recreated turf for your hellplanet-scaping."
	icon = 'icons/turf/floors.dmi'
	icon_state = "basalt"
	floor_tile = /obj/item/stack/tile/basalt
	ore_type = /obj/item/stack/ore/glass/basalt
	turfverb = "dig up"
	slowdown = 0
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_ASTEROID
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/carpet
	name = "carpet"
	desc = "Soft velvet carpeting. Feels good between your toes."
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "carpet-255"
	base_icon_state = "carpet"
	floor_tile = /obj/item/stack/tile/carpet
	broken_states = list("damaged")
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET)
	canSmoothWith = list(SMOOTH_GROUP_CARPET)
	flags_1 = NONE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET_BAREFOOT
	clawfootstep = FOOTSTEP_CARPET_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	flammability = 5

/turf/open/floor/carpet/examine(mob/user)
	. = ..()
	. += span_notice("There's a <b>small crack</b> on the edge of it.")

/turf/open/floor/carpet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	update_appearance()

/turf/open/floor/carpet/update_icon()
	. = ..()
	if(!..())
		return 0
	if(!broken && !burnt)
		if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
			QUEUE_SMOOTH(src)
	else
		make_plating()
		if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
			QUEUE_SMOOTH_NEIGHBORS(src)

///Carpet variant for mapping aid, functionally the same as parent after smoothing.
/turf/open/floor/carpet/lone
	icon_state = "carpet-0"

/turf/open/floor/carpet/red_gold
	icon = 'icons/turf/floors/carpet_red_gold.dmi'
	icon_state = "carpet_red_gold-255"
	base_icon_state = "carpet_red_gold"
	floor_tile = /obj/item/stack/tile/carpet/red_gold
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_RED_GOLD)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_RED_GOLD)

/turf/open/floor/carpet/black
	icon = 'icons/turf/floors/carpet_black.dmi'
	icon_state = "carpet_black-255"
	base_icon_state = "carpet_black"
	floor_tile = /obj/item/stack/tile/carpet/black
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_BLACK)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_BLACK)

/turf/open/floor/carpet/blue
	icon = 'icons/turf/floors/carpet_blue.dmi'
	icon_state = "carpet_blue-255"
	base_icon_state = "carpet_blue"
	floor_tile = /obj/item/stack/tile/carpet/blue
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_BLUE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_BLUE)

/turf/open/floor/carpet/cyan
	icon = 'icons/turf/floors/carpet_cyan.dmi'
	icon_state = "carpet_cyan-255"
	base_icon_state = "carpet_cyan"
	floor_tile = /obj/item/stack/tile/carpet/cyan
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_CYAN)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_CYAN)

/turf/open/floor/carpet/green
	icon = 'icons/turf/floors/carpet_green.dmi'
	icon_state = "carpet_green-255"
	base_icon_state = "carpet_green"
	floor_tile = /obj/item/stack/tile/carpet/green
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_GREEN)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_GREEN)

/turf/open/floor/carpet/orange
	icon = 'icons/turf/floors/carpet_orange.dmi'
	icon_state = "carpet_orange-255"
	base_icon_state = "carpet_orange"
	floor_tile = /obj/item/stack/tile/carpet/orange
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_ORANGE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_ORANGE)

/turf/open/floor/carpet/purple
	icon = 'icons/turf/floors/carpet_purple.dmi'
	icon_state = "carpet_purple-255"
	base_icon_state = "carpet_purple"
	floor_tile = /obj/item/stack/tile/carpet/purple
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_PURPLE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_PURPLE)

/turf/open/floor/carpet/red
	icon = 'icons/turf/floors/carpet_red.dmi'
	icon_state = "carpet_red-255"
	base_icon_state = "carpet_red"
	floor_tile = /obj/item/stack/tile/carpet/red
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_RED)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_RED)

/turf/open/floor/carpet/royalblack
	icon = 'icons/turf/floors/carpet_royalblack.dmi'
	icon_state = "carpet_royalblack-255"
	base_icon_state = "carpet_royalblack"
	floor_tile = /obj/item/stack/tile/carpet/royalblack
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_ROYAL_BLACK)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_ROYAL_BLACK)

/turf/open/floor/carpet/royalblue
	icon = 'icons/turf/floors/carpet_royalblue.dmi'
	icon_state = "carpet_royalblue-255"
	base_icon_state = "carpet_royalblue"
	floor_tile = /obj/item/stack/tile/carpet/royalblue
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_ROYAL_BLUE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_ROYAL_BLUE)

/turf/open/floor/carpet/executive
	name = "executive carpet"
	icon = 'icons/turf/floors/carpet_executive.dmi'
	icon_state = "executive_carpet-255"
	base_icon_state = "executive_carpet"
	floor_tile = /obj/item/stack/tile/carpet/executive
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_EXECUTIVE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_EXECUTIVE)

/turf/open/floor/carpet/stellar
	name = "stellar carpet"
	icon = 'icons/turf/floors/carpet_stellar.dmi'
	icon_state = "stellar_carpet-255"
	base_icon_state = "stellar_carpet"
	floor_tile = /obj/item/stack/tile/carpet/stellar
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_STELLAR)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_STELLAR)

/turf/open/floor/carpet/donk
	name = "Donk Co. carpet"
	icon = 'icons/turf/floors/carpet_donk.dmi'
	icon_state = "donk_carpet-255"
	base_icon_state = "donk_carpet"
	floor_tile = /obj/item/stack/tile/carpet/donk
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_DONK)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_DONK)

/turf/open/floor/carpet/nanoweave
	name = "nanoweave carpet"
	desc = "A padded piece of plasteel plating, used to make space-based installations a feel little less soulless."
	icon = 'icons/turf/floors/nanoweave_dark.dmi'
	icon_state = "icon-255" //no i am not renaming like 40 tile states 5 times over
	base_icon_state = "icon" //god hates you - Zeta
	floor_tile = /obj/item/stack/tile/carpet/nanoweave
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_NWDARK)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_NWDARK)

/turf/open/floor/carpet/nanoweave/red
	name = "nanoweave carpet (red)"
	icon = 'icons/turf/floors/nanoweave_red.dmi' //the good part of being a lazy dickwad is that i dont need to redefine icon_state and base_icon_state 5 times over
	floor_tile = /obj/item/stack/tile/carpet/nanoweave/red
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_NWRED)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_NWRED)

/turf/open/floor/carpet/nanoweave/beige //this one is good for varediting to cool colors
	name = "nanoweave carpet (beige)"
	icon = 'icons/turf/floors/nanoweave_beige.dmi'
	floor_tile = /obj/item/stack/tile/carpet/nanoweave/beige
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_NWBEIGE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_NWBEIGE)

/turf/open/floor/carpet/nanoweave/blue
	name = "nanoweave carpet (blue)"
	icon = 'icons/turf/floors/nanoweave_blue.dmi'
	floor_tile = /obj/item/stack/tile/carpet/nanoweave/blue
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_NWBLUE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_NWBLUE)

/turf/open/floor/carpet/nanoweave/purple
	name = "nanoweave carpet (purple)"
	icon = 'icons/turf/floors/nanoweave_purple.dmi'
	floor_tile = /obj/item/stack/tile/carpet/nanoweave/purple
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_NWPURPLE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_NWPURPLE)

/turf/open/floor/carpet/nanoweave/orange
	name = "nanoweave carpet (orange)"
	icon = 'icons/turf/floors/nanoweave_orange.dmi'
	floor_tile = /obj/item/stack/tile/carpet/nanoweave/orange
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_NWORANGE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_NWORANGE)

//*****Airless versions of most of the above.*****
/turf/open/floor/carpet/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/black/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/blue/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/cyan/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/green/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/orange/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/purple/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/red/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/royalblack/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/royalblue/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/carpet/blue/plasma
	initial_gas_mix = ATMOS_TANK_PLASMAHALF

/turf/open/floor/carpet/narsie_act(force, ignore_mobs, probability = 20)
	. = (force || prob(probability))
	var/individual_chance
	for(var/atom/movable/movable_contents as anything in src)
		individual_chance = ismob(movable_contents) ? !ignore_mobs : .
		if(individual_chance)
			movable_contents.narsie_act()

/turf/open/floor/carpet/break_tile()
	broken = TRUE
	update_appearance()

/turf/open/floor/carpet/burn_tile()
	burnt = TRUE
	update_appearance()

/turf/open/floor/carpet/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE


/turf/open/floor/fakepit
	desc = "A clever illusion designed to look like a bottomless pit."
	icon = 'icons/turf/floors/chasms.dmi'
	icon_state = "chasms-0"
	base_icon_state = "chasms"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_TURF_CHASM)
	canSmoothWith = list(SMOOTH_GROUP_TURF_CHASM)
	tiled_dirt = FALSE

/turf/open/floor/fakepit/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "basalt"
	return TRUE

/turf/open/floor/fakespace
	icon = 'icons/turf/space.dmi'
	icon_state = "0"
	floor_tile = /obj/item/stack/tile/fakespace
	broken_states = list("damaged")
	plane = PLANE_SPACE
	tiled_dirt = FALSE

/turf/open/floor/fakespace/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = SPACE_ICON_STATE

/turf/open/floor/fakespace/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/space.dmi'
	underlay_appearance.icon_state = SPACE_ICON_STATE
	underlay_appearance.plane = PLANE_SPACE
	return TRUE
