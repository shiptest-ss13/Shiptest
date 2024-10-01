/turf/closed/wall/mineral/cult
	name = "runed metal wall"
	desc = "A cold metal wall engraved with indecipherable symbols. Studying them causes your head to pound."
	icon = 'icons/turf/walls/cult_wall.dmi'
	icon_state = "cult_wall-0"
	base_icon_state = "cult_wall"
	smoothing_flags = SMOOTH_BITMASK
	canSmoothWith = null
	sheet_type = /obj/item/stack/sheet/mineral/hidden/hellstone
	sheet_amount = 1
	girder_type = /obj/structure/girder/cult

	max_integrity = 600

/turf/closed/wall/mineral/cult/Initialize(mapload, inherited_virtual_z)
	new /obj/effect/temp_visual/cult/turf(src)
	. = ..()

/turf/closed/wall/mineral/cult/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	if(istype(AM, /mob/living/simple_animal/hostile/construct/harvester)) //harvesters can go through cult walls, dragging something with
		var/mob/living/simple_animal/hostile/construct/harvester/H = AM
		var/atom/movable/stored_pulling = H.pulling
		if(stored_pulling)
			stored_pulling.setDir(get_dir(stored_pulling.loc, newloc))
			stored_pulling.forceMove(src)
			H.start_pulling(stored_pulling, supress_message = TRUE)

/turf/closed/wall/mineral/cult/artificer
	name = "runed stone wall"
	desc = "A cold stone wall engraved with indecipherable symbols. Studying them causes your head to pound."
	sheet_type = null
	girder_type = null

// no sheets, just a cult effect
/turf/closed/wall/mineral/cult/artificer/create_sheets()
	new /obj/effect/temp_visual/cult/turf(get_turf(src))
	return

/turf/closed/wall/vault
	icon = 'icons/turf/walls.dmi'
	icon_state = "rockvault"

/turf/closed/wall/ice
	icon = 'icons/turf/walls/icedmetal_wall.dmi'
	icon_state = "icedmetal_wall-0"
	base_icon_state = "icedmetal_wall"
	desc = "A wall covered in a thick sheet of ice."
	smoothing_flags = SMOOTH_BITMASK
	canSmoothWith = null
	hardness = 35
	breakdown_duration = 40
	bullet_sizzle = TRUE
	burn_mod = 2

/turf/closed/wall/rust
	name = "rusted wall"
	desc = "A rusted metal wall."
	icon = 'icons/turf/walls/rusty_wall.dmi'
	icon_state = "rusty_wall-0"
	base_icon_state = "rusty_wall"
	smoothing_flags = SMOOTH_BITMASK
	hardness = 45
	max_integrity = 300
	min_dam = 5

/turf/closed/wall/rust/yesdiag
	icon_state = "rusty_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/r_wall/rust
	name = "rusted reinforced wall"
	desc = "A huge chunk of rusted reinforced metal."
	icon = 'icons/turf/walls/rusty_reinforced_wall.dmi'
	icon_state = "rusty_reinforced_wall-0"
	base_icon_state = "rusty_reinforced_wall"
	smoothing_flags = SMOOTH_BITMASK
	hardness = 15
	integrity = 1000
	min_dam = 5

/turf/closed/wall/r_wall/rust/yesdiag
	icon_state = "rusty_reinforced_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/bronze
	name = "clockwork wall"
	desc = "A huge chunk of bronze, decorated like gears and cogs."
	icon = 'icons/turf/walls/clockwork_wall.dmi'
	icon_state = "clockwork_wall-0"
	base_icon_state = "clockwork_wall"
	smoothing_flags = SMOOTH_BITMASK
	sheet_type = /obj/item/stack/tile/bronze
	sheet_amount = 2
	girder_type = /obj/structure/girder/bronze

/turf/closed/wall/bathhouse
	desc = "It's cool to the touch, pleasantly so."
	icon = 'icons/turf/shuttleold.dmi'
	icon_state = "block"
	base_icon_state = "block"
	smoothing_flags = NONE
	canSmoothWith = null
