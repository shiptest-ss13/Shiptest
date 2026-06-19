/turf/open/water
	gender = PLURAL
	name = "water"
	desc = "Shallow water."
	icon = 'icons/turf/floors.dmi'
	icon_state = "water"
	baseturfs = /turf/open/water
	planetary_atmos = TRUE
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.
	layer = WATER_TURF_LAYER

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

	///The transparency of the immerse element's overlay
	var/immerse_overlay_alpha = 180
	///Icon state to use for the immersion mask
	var/immerse_overlay = "immerse"
	/// Fishing element for this specific water tile
	var/datum/fish_source/fishing_datum = /datum/fish_source/ocean
	/// Whether the immerse element has been added yet or not
	var/immerse_added = FALSE
	/**
	* Variables used for the swimming tile element. If TRUE, we pass these values to the element.
	* - is_swimming_tile: Whether or not we add the element to this tile.
	* - stamina_entry_cost: how much stamina it costs to enter the swimming tile, and for each move into a tile
	* - ticking_oxy_damage: How much oxygen is lost per tick when drowning in water. Also determines how many breathes are lost.
	* - exhaust_swimmer_prob: The likelihood that someone suffers stamina damage when entering a swimming tile.
	*/
	var/is_swimming_tile = FALSE
	var/stamina_entry_cost = 7
	var/ticking_oxy_damage = 2
	var/exhaust_swimmer_prob = 30

	var/datum/reagent/reagent_to_extract = /datum/reagent/water
	var/extracted_reagent_visible_name = "water"

/turf/open/water/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON, PROC_REF(on_atom_inited))
	AddElement(/datum/element/watery_tile)
	if(!isnull(fishing_datum))
		AddElement(/datum/element/lazy_fishing_spot, fishing_datum)
	//ADD_TRAIT(src, TRAIT_CATCH_AND_RELEASE, INNATE_TRAIT)

///We lazily add the immerse element when something is spawned or crosses this turf and not before.
/turf/open/water/proc/on_atom_inited(datum/source, atom/movable/movable)
	SIGNAL_HANDLER
	UnregisterSignal(src, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON)
	make_immersed(movable)

/**
 * turf/Initialize() calls Entered on its contents too, however
 * we need to wait for movables that still need to be initialized
 * before we add the immerse element.
 */
/turf/open/water/Entered(atom/movable/arrived)
	. = ..()
	make_immersed(arrived)

///Makes this turf immersable, return true if we actually did anything so child procs don't have to repeat our checks
/turf/open/water/proc/make_immersed(atom/movable/triggering_atom)
	if(immerse_added || is_type_in_typecache(triggering_atom, GLOB.immerse_ignored_movable))
		return FALSE
	AddElement(/datum/element/immerse, immerse_overlay, immerse_overlay_alpha)
	immerse_added = TRUE
	if(is_swimming_tile)
		AddElement(/datum/element/swimming_tile, stamina_entry_cost, ticking_oxy_damage, exhaust_swimmer_prob)
	return TRUE

/turf/open/water/Destroy()
	UnregisterSignal(src, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON)
	return ..()

/turf/open/water/Initialize(mapload, inherited_virtual_z)
	. = ..()
	var/area/overmap_encounter/selected_area = get_area(src)
	if(!istype(selected_area))
		return

	RegisterSignal(src, COMSIG_OVERMAPTURF_UPDATE_LIGHT, PROC_REF(get_light))
	if(istype(selected_area))
		light_range = selected_area.light_range
		light_range = selected_area.light_range
		light_power = selected_area.light_power
		update_light()

/turf/open/water/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_OVERMAPTURF_UPDATE_LIGHT)

/turf/open/water/examine(mob/user)
	. = ..()
	if(reagent_to_extract)
		. += span_notice("You could probably scoop some of the [extracted_reagent_visible_name] if you had a beaker...")

/turf/open/water/attackby(obj/item/_item, mob/user, params)
	if(istype(_item, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = _item
		var/obj/structure/lattice/H = locate(/obj/structure/lattice, src)
		if(H)
			to_chat(user, span_warning("There is already a lattice here!"))
			return
		if(R.use(2))
			to_chat(user, span_notice("You construct a catwalk."))
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			new /obj/structure/lattice/catwalk(locate(x, y, z))
		else
			to_chat(user, span_warning("You need one rod to build a lattice."))
		return
	if(istype(_item, /obj/item/fish))
		to_chat(user, span_notice("You toss the [_item.name] into the [name]."))
		playsound(_item, "sound/effects/bigsplash.ogg", 90)
		qdel(_item)
	if(istype(_item, /obj/item/reagent_containers/glass))
		extract_reagents(_item,user,params)

	. = ..()

/turf/open/water/proc/extract_reagents(obj/item/reagent_containers/glass/container, mob/user, params)
	if(!reagent_to_extract)
		return FALSE
	if(!container.is_refillable())
		to_chat(user, span_danger("\The [container]'s cap is on! Take it off first."))
		return FALSE
	if(container.reagents.total_volume >= container.volume)
		to_chat(user, span_danger("\The [container] is full."))
		return FALSE
	container.reagents.add_reagent(reagent_to_extract, rand(5, 10))
	user.visible_message(span_notice("[user] scoops [extracted_reagent_visible_name] from the [src] with \the [container]."), span_notice("You scoop out [extracted_reagent_visible_name] from the [src] using \the [container]."))
	return TRUE

/turf/open/water/can_have_cabling()
	return FALSE

/turf/open/water/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 3)
	return FALSE

/turf/open/water/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, span_notice("You build a floor."))
			PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return TRUE
	return FALSE

/turf/open/water/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent) //water? wet? not in this economy.
	return

/turf/open/water/proc/get_light(obj/item/source, target_light, target_power, target_color,)
	light_range = target_light
	light_power = target_power
	light_color = target_color
	update_light()

/turf/open/water/jungle
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY
	color = "#617B64"
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/water/jungle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lazy_fishing_spot, FISHING_SPOT_PRESET_JUNGLE)

/turf/open/water/beach
	color = "#41a3ff"
	light_range = 2
	light_power = 0.80
	light_color = LIGHT_COLOR_BLUE
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS

/turf/open/water/beach/underground
	light_range = 0

/turf/open/water/beach/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lazy_fishing_spot, FISHING_SPOT_PRESET_BEACH)

/turf/open/water/beach/deep
	color = "#4566ad"
	light_color = LIGHT_COLOR_DARK_BLUE
	immerse_overlay = "immerse_deep"
	is_swimming_tile = TRUE

/turf/open/water/beach/deep/outpost
	color = "#22423b"
	light_color = "#97442f"
	initial_gas_mix = "o2=22;n2=82;TEMP=305"
	light_range = 2
	light_power = 0.90
	is_swimming_tile = TRUE
	immerse_overlay_alpha = 210
	stamina_entry_cost = 20

/turf/open/water/tar
	name = "tar pit"
	desc = "Shallow tar. Will slow you down significantly."
	color = "#574747"
	light_range = 0
	slowdown = 2
	fishing_datum = null
	reagent_to_extract = /datum/reagent/asphalt
	extracted_reagent_visible_name = "tar"
	immerse_overlay_alpha = 240

/turf/open/water/whitesands
	name = "sulfuric acid pool"
	desc = "Shallow sulfuric acid. It isn't the best ideas to step in this, but you are able to without many short term consequnces."
	baseturfs = /turf/open/water/whitesands
	planetary_atmos = TRUE
	color = "#57ffd5"

	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

	reagent_to_extract = /datum/reagent/toxin/acid
	extracted_reagent_visible_name = "acid"
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

	var/particle_to_spawn = /particles/smoke/steam/vent/high
	var/obj/effect/particle_holder/part_hold

/turf/open/water/whitesands/Initialize()
	. = ..()
	if(prob(5))
		part_hold = new(get_turf(src))
		part_hold.layer = EDGED_TURF_LAYER
		part_hold.particles = new particle_to_spawn()
		underlays.Cut()

/turf/open/water/whitesands/Destroy()
	. = ..()
	QDEL_NULL(part_hold)

/turf/open/water/oasis
	name = "freshwater"
	desc = "Nice and warm freshwater. Drinkable and bathable, it is highly valuable in scarce locations"
	baseturfs = /turf/open/water/oasis
	planetary_atmos = TRUE
	color = "#8ac7e6"
	light_range = 2
	light_power = 0.80
	light_color = "#9cdeff"

	var/particle_to_spawn = /particles/smoke/steam/vent/low
	var/obj/effect/particle_holder/part_hold

/turf/open/water/oasis/Initialize()
	. = ..()
	part_hold = new(get_turf(src))
	part_hold.layer = EDGED_TURF_LAYER
	part_hold.particles = new particle_to_spawn()
	underlays.Cut()

/turf/open/water/oasis/Destroy()
	. = ..()
	QDEL_NULL(part_hold)
