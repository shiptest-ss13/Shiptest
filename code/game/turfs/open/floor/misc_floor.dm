/turf/open/floor/goonplaque
	name = "commemorative plaque"
	icon_state = "plaque"
	desc = "\"This is a plaque in honour of our comrades on the G4407 Stations. Hopefully TG4407 model can live up to your fame and fortune.\" Scratched in beneath that is a crude image of a meteor and a spaceman. The spaceman is laughing. The meteor is exploding."
	floor_tile = /obj/item/stack/tile/plasteel
	tiled_dirt = FALSE

/turf/open/floor/vault
	icon_state = "rockvault"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/vault/airless
	initial_gas_mix = AIRLESS_ATMOS

//Circuit flooring, glows a little
/turf/open/floor/circuit
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit"
	var/icon_normal = "bcircuit"
	light_color = LIGHT_COLOR_CYAN
	floor_tile = /obj/item/stack/tile/circuit
	var/on = TRUE

/turf/open/floor/circuit/Initialize(mapload, inherited_virtual_z)
	SSmapping.nuke_tiles += src
	update_appearance()
	. = ..()

/turf/open/floor/circuit/Destroy()
	SSmapping.nuke_tiles -= src
	return ..()

/turf/open/floor/circuit/update_appearance(updates)
	. = ..()
	if(!on)
		set_light(0)
		return

	set_light_color(LAZYLEN(SSmapping.nuke_threats) ? LIGHT_COLOR_FLARE : initial(light_color))
	set_light(1.4, 0.5)

/turf/open/floor/circuit/update_icon_state()
	icon_state = on ? (LAZYLEN(SSmapping.nuke_threats) ? "rcircuitanim" : icon_normal) : "[icon_normal]off"
	return ..()

/turf/open/floor/circuit/off
	icon_state = "bcircuitoff"
	on = FALSE

/turf/open/floor/circuit/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/circuit/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/circuit/telecomms/mainframe
	name = "mainframe base"

/turf/open/floor/circuit/telecomms/server
	name = "server base"

/turf/open/floor/circuit/green
	icon_state = "gcircuit"
	icon_normal = "gcircuit"
	light_color = LIGHT_COLOR_GREEN
	floor_tile = /obj/item/stack/tile/circuit/green

/turf/open/floor/circuit/green/off
	icon_state = "gcircuitoff"
	on = FALSE

/turf/open/floor/circuit/green/anim
	icon_state = "gcircuitanim"
	icon_normal = "gcircuitanim"
	floor_tile = /obj/item/stack/tile/circuit/green/anim

/turf/open/floor/circuit/green/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/circuit/green/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/circuit/green/telecomms/mainframe
	name = "mainframe base"

/turf/open/floor/circuit/red
	icon_state = "rcircuit"
	icon_normal = "rcircuit"
	light_color = LIGHT_COLOR_FLARE
	floor_tile = /obj/item/stack/tile/circuit/red

/turf/open/floor/circuit/red/off
	icon_state = "rcircuitoff"
	on = FALSE

/turf/open/floor/circuit/red/anim
	icon_state = "rcircuitanim"
	icon_normal = "rcircuitanim"
	floor_tile = /obj/item/stack/tile/circuit/red/anim

/turf/open/floor/circuit/red/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/circuit/red/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/pod
	name = "pod floor"
	icon_state = "podfloor"
	floor_tile = /obj/item/stack/tile/pod

/turf/open/floor/pod/light
	icon_state = "podfloor_light"
	floor_tile = /obj/item/stack/tile/pod/light
/turf/open/floor/pod/light/external
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/pod/light/external/handle_decompression_floor_rip(sum)
	return

/turf/open/floor/pod/dark
	icon_state = "podfloor_dark"
	floor_tile = /obj/item/stack/tile/pod/dark


/turf/open/floor/noslip
	name = "high-traction floor"
	icon_state = "noslip"
	floor_tile = /obj/item/stack/tile/noslip
	broken_states = list("noslip-damaged1","noslip-damaged2","noslip-damaged3")
	burnt_states = list("noslip-scorched1","noslip-scorched2")
	slowdown = -0.3

/turf/open/floor/noslip/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/bronze
	name = "bronze floor"
	desc = "Some heavy bronze tiles."
	icon = 'icons/obj/clockwork_objects.dmi'
	icon_state = "clockwork_floor"
	floor_tile = /obj/item/stack/tile/bronze

/turf/open/floor/white
	name = "white floor"
	desc = "A tile in a pure white color."
	icon_state = "pure_white"

/turf/open/floor/black
	name = "black floor"
	icon_state = "black"

/turf/open/floor/plastic
	name = "plastic floor"
	desc = "Cheap, lightweight flooring. Melts easily."
	icon_state = "plastic"
	thermal_conductivity = 0.1
	heat_capacity = 900
	floor_tile = /obj/item/stack/tile/plastic
	broken_states = list("plastic-damaged1","plastic-damaged2")

/turf/open/floor/eighties
	name = "retro floor"
	desc = "This one takes you back."
	icon_state = "eighties"
	floor_tile = /obj/item/stack/tile/eighties
	broken_states = list("damaged")

/turf/open/floor/plating/rust
	name = "rusted plating"
	desc = "Corrupted steel."
	icon_state = "plating_rust"

/turf/open/floor/plating/rust/plasma
	initial_gas_mix = "plasma=104;TEMP=293.15"

/turf/open/floor/plating/rust/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plasteel/telecomms_floor
	icon_state = "tcomms"
	base_icon_state = "tcomms"
	icon = 'icons/turf/floors/misc.dmi'
	color = null
/turf/open/floor/plasteel/telecomms_floor/tatmos
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/plasteel/telecomms_floor/airless
	initial_gas_mix = AIRLESS_ATMOS


//ship turfs
/turf/open/floor/ship
	name = "Ship Plating"
	desc = "Report a bug if you see this."

/turf/open/floor/ship/dirt
	gender = PLURAL
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon = 'icons/turf/planetary/jungle.dmi'
	icon_state = "dirt"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	var/ore_type = /obj/item/stack/ore/glass
	var/turfverb = "dig up"
	baseturfs = /turf/open/floor/plating

/turf/open/floor/ship/dirt/attackby(obj/item/C, mob/user, params)
	if((C.tool_behaviour == TOOL_SHOVEL) && params)
		new ore_type(src, 2)
		user.visible_message(span_notice("[user] digs up [src]."), span_notice("You [turfverb] [src]."))
		playsound(src, 'sound/effects/shovel_dig.ogg', 50, TRUE)
		make_plating()
	if(..())
		return

/turf/open/floor/ship/dirt/dark
	icon_state = "greenerdirt"

/turf/open/floor/grass/ship
	name = "grass"
	desc = "A patch of grass."
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_GRASS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_GRASS)
	MAP_SWITCH(pixel_x = 0, pixel_x = -19)
	MAP_SWITCH(pixel_y = 0, pixel_y = -19)
	layer = HIGH_TURF_LAYER
	icon_state = "grass-255"
	base_icon_state = "grass"
	icon = 'icons/turf/floors/grass.dmi'
	var/smooth_icon = 'icons/turf/floors/grass.dmi'
	baseturfs = /turf/open/floor/ship/dirt

/turf/open/floor/grass/ship/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = smooth_icon

/turf/open/floor/grass/ship/jungle
	name = "jungle grass"
	desc = "Greener on the other side."
	icon_state = "grass-255"
	base_icon_state = "grass"
	baseturfs = /turf/open/floor/ship/dirt/dark
	icon = 'icons/turf/floors/junglegrass.dmi'
	smooth_icon = 'icons/turf/floors/junglegrass.dmi'

/turf/open/floor/plating/ship/water
	name = "water"
	desc = "Shallow water."
	icon_state = "riverwater_motion"
	baseturfs = /turf/open/floor/ship/dirt
	slowdown = 1
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

	var/datum/reagent/reagent_to_extract = /datum/reagent/water
	var/extracted_reagent_visible_name = "water"

/turf/open/floor/plating/ship/water/attackby(obj/item/tool, mob/user, params)
	if(!reagent_to_extract)
		return ..()
	var/obj/item/reagent_containers/glass/container = tool
	if(!istype(tool, /obj/item/reagent_containers))
		return ..()
	if(container.reagents.total_volume >= container.volume)
		to_chat(user, span_danger("[container] is full."))
		return
	container.reagents.add_reagent(reagent_to_extract, rand(5, 10))
	user.visible_message(span_notice("[user] scoops [extracted_reagent_visible_name] from the [src] with \the [container]."), span_notice("You scoop out [extracted_reagent_visible_name] from the [src] using \the [container]."))
	return TRUE

/turf/open/floor/plating/ship/water/can_have_cabling()
	return FALSE

/turf/open/floor/plating/ship/water/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 3)
	return FALSE

/turf/open/floor/plating/ship/water/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, span_notice("You build a floor."))
			PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return TRUE
	return FALSE

/turf/open/floor/plating/ship/water/beach
	color = COLOR_CYAN

/turf/open/floor/plating/ship/water/beach/deep
	color = "#0099ff"

/turf/open/floor/plating/ship/water/tar
	name = "tar pit"
	desc = "Shallow tar. Will slow you down significantly. You could use a beaker to scoop some out."
	color = "#222424"
	slowdown = 2
	reagent_to_extract = /datum/reagent/asphalt
	extracted_reagent_visible_name = "tar"
