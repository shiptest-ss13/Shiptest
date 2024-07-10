/turf/open/acid
	name = "acid lake"
	icon = 'icons/turf/floors/ws_floors.dmi'
	icon_state = "acid"
	gender = PLURAL
	baseturfs = /turf/open/acid
	slowdown = 2

	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_SLIME_LAMP
	bullet_bounce_sound = 'sound/items/welder2.ogg'

	footstep = FOOTSTEP_LAVA
	barefootstep = FOOTSTEP_LAVA
	clawfootstep = FOOTSTEP_LAVA
	heavyfootstep = FOOTSTEP_LAVA

/turf/open/acid/CanAllowThrough(atom/movable/passing_atom, turf/target)
	if(ishostile(passing_atom))
		return FALSE
	return ..()

/turf/open/acid/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/open/acid/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/acid/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/acid/acid_act(acidpwr, acid_volume)
	return

/turf/open/acid/MakeDry(wet_setting = TURF_WET_WATER)
	return

/turf/open/acid/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/acid/Entered(atom/movable/AM)
	. = ..()
	if(melt_stuff(AM))
		START_PROCESSING(SSobj, src)

/turf/open/acid/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(melt_stuff(AM))
		START_PROCESSING(SSobj, src)

/turf/open/acid/process()
	if(!melt_stuff())
		STOP_PROCESSING(SSobj, src)

/turf/open/acid/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 3)
	return FALSE

/turf/open/acid/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, "<span class='notice'>You build a floor.</span>")
			PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return TRUE
	return FALSE

/turf/open/acid/singularity_act()
	return

/turf/open/acid/singularity_pull(S, current_size)
	return

/turf/open/acid/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "basalt"
	return TRUE

/turf/open/acid/attackby(obj/item/C, mob/user, params)
	..()
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/lattice/H = locate(/obj/structure/lattice, src)
		if(H)
			to_chat(user, "<span class='warning'>There is already a lattice here!</span>")
			return
		if(R.use(2))
			to_chat(user, "<span class='notice'>You construct a catwalk.</span>")
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			new /obj/structure/lattice/catwalk(locate(x, y, z))
		else
			to_chat(user, "<span class='warning'>You need one rod to build a lattice.</span>")
		return

/turf/open/acid/proc/is_safe_to_cross()
	//if anything matching this typecache is found in the lava, we don't burn things
	var/static/list/acid_safeties_typecache = typecacheof(list(/obj/structure/catwalk, /obj/structure/stone_tile, /obj/structure/lattice/))
	var/list/found_safeties = typecache_filter_list(contents, acid_safeties_typecache)
	for(var/obj/structure/stone_tile/stone_tile in found_safeties)
		if(stone_tile.fallen)
			LAZYREMOVE(found_safeties, stone_tile)
	return LAZYLEN(found_safeties)


/turf/open/acid/proc/melt_stuff(thing_to_melt)
	if(is_safe_to_cross())
		return FALSE
	. = FALSE
	var/thing_to_check = src
	if (thing_to_melt)
		thing_to_check = list(thing_to_melt)
	for(var/thing in thing_to_check)
		if(isobj(thing))
			var/obj/object_to_melt = thing
			if((object_to_melt.resistance_flags & (ACID_PROOF|INDESTRUCTIBLE)) || object_to_melt.throwing)
				continue
			. = TRUE
			if((object_to_melt.acid_level))
				continue
			if(object_to_melt.resistance_flags & UNACIDABLE)
				object_to_melt.resistance_flags &= ~UNACIDABLE
			if(object_to_melt.armor.acid == 100) //acid proof armor will probably be acid proof
				continue
			object_to_melt.acid_act(10, 20)

		else if (isliving(thing))
			. = TRUE
			var/mob/living/L = thing
			if(L.movement_type & FLYING)
				continue	//YOU'RE FLYING OVER IT
			var/buckle_check = L.buckling
			if(!buckle_check)
				buckle_check = L.buckled
			if(isobj(buckle_check))
				var/obj/O = buckle_check
				if(O.resistance_flags & LAVA_PROOF)
					continue
			else if(isliving(buckle_check))
				var/mob/living/live = buckle_check
				if("acid" in live.weather_immunities)
					continue

			if(iscarbon(L))
				var/mob/living/carbon/C = L
				var/obj/item/clothing/S = C.get_item_by_slot(ITEM_SLOT_OCLOTHING)
				var/obj/item/clothing/H = C.get_item_by_slot(ITEM_SLOT_HEAD)

				if(S && H && S.armor.acid == 100 && H.armor.acid == 100)
					return

			if("acid" in L.weather_immunities)
				continue

			L.adjustFireLoss(20)
			if(L) //mobs turning into object corpses could get deleted here.
				L.acid_act(50, 100)

/turf/open/acid/whitesands
	planetary_atmos = TRUE
	initial_gas_mix = WHITESANDS_ATMOS
