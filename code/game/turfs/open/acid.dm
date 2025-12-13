/turf/open/water/acid
	name = "acid lake"
	desc = "A lake of acid."
	icon = 'icons/turf/floors/ws_floors.dmi'
	icon_state = "acid"
	baseturfs = /turf/open/water/acid
	slowdown = 2

	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_SLIME_LAMP
	bullet_bounce_sound = 'sound/items/welder2.ogg'

	planetary_atmos = FALSE
	footstep = FOOTSTEP_LAVA
	barefootstep = FOOTSTEP_LAVA
	clawfootstep = FOOTSTEP_LAVA
	heavyfootstep = FOOTSTEP_LAVA

	reagent_to_extract = /datum/reagent/toxin/acid
	extracted_reagent_visible_name = "acid"

/turf/open/water/acid/CanAllowThrough(atom/movable/passing_atom, turf/target)
	if(ishostile(passing_atom))
		return FALSE
	return ..()

/turf/open/water/acid/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/open/water/acid/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/water/acid/acid_act(acidpwr, acid_volume)
	return

/turf/open/water/acid/MakeDry(wet_setting = TURF_WET_WATER)
	return

/turf/open/water/acid/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/water/acid/Entered(atom/movable/AM)
	. = ..()
	if(melt_stuff(AM))
		START_PROCESSING(SSobj, src)

/turf/open/water/acid/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(melt_stuff(AM))
		START_PROCESSING(SSobj, src)

/turf/open/water/acid/process(seconds_per_tick)
	if(!melt_stuff())
		STOP_PROCESSING(SSobj, src)

/turf/open/water/acid/singularity_act()
	return

/turf/open/water/acid/singularity_pull(S, current_size)
	return

/turf/open/water/acid/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "basalt"
	return TRUE

/turf/open/water/acid/proc/is_safe_to_cross()
	return HAS_TRAIT(src, TRAIT_ACID_STOPPED)


/turf/open/water/acid/proc/melt_stuff(thing_to_melt)
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
			object_to_melt.acid_act(10, 1)

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

/turf/open/water/acid/whitesands
	planetary_atmos = TRUE
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/water/acid/waste
	planetary_atmos = TRUE
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
