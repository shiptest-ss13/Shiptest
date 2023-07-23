
/**********************Asteroid**************************/

/turf/open/floor/plating/asteroid //floor piece
	gender = PLURAL
	name = "asteroid sand"
	baseturfs = /turf/open/floor/plating/asteroid
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	icon_plating = "asteroid"
	postdig_icon_change = TRUE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	attachment_holes = FALSE
	/// the icon name to be used: for example, asteroid1 - asteroid12 in the icon file
	base_icon_state  = "asteroid"
	/// Base turf type to be created by the tunnel
	var/turf_type = /turf/open/floor/plating/asteroid // is this unused?
	/// Probability floor has a different icon state
	var/floor_variance = 20
	/// The max amount of unique icons, plus one
	var/max_icon_states = 12
	/// Itemstack to drop when dug by a shovel
	var/obj/item/stack/digResult = /obj/item/stack/ore/glass
	/// Whether the turf has been dug or not
	var/dug

/turf/open/floor/plating/asteroid/Initialize(mapload, inherited_virtual_z)
	var/proper_name = name
	. = ..()
	name = proper_name

	if(prob(floor_variance))
		icon_state = "[base_icon_state][rand(0,max_icon_states)]"

/// Drops itemstack when dug and changes icon
/turf/open/floor/plating/asteroid/proc/getDug()
	new digResult(src, 5)
	if(postdig_icon_change)
		if(!postdig_icon)
			icon_plating = "[base_icon_state]_dug"
			icon_state = "[base_icon_state]_dug"
	dug = TRUE

/// If the user can dig the turf
/turf/open/floor/plating/asteroid/proc/can_dig(mob/user)
	if(!dug)
		return TRUE
	if(user)
		to_chat(user, "<span class='warning'>You can't dig here!</span>")

/turf/open/floor/plating/asteroid/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/asteroid/burn_tile()
	return

/turf/open/floor/plating/asteroid/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/asteroid/MakeDry()
	return

/turf/open/floor/plating/asteroid/crush()
	return

/turf/open/floor/plating/asteroid/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(!.)
		if(W.tool_behaviour == TOOL_SHOVEL || W.tool_behaviour == TOOL_MINING)
			if(!can_dig(user))
				return TRUE

			if(!isturf(user.loc))
				return

			balloon_alert(user, "you start digging...")

			if(W.use_tool(src, user, 40, volume=50))
				if(!can_dig(user))
					return TRUE
				getDug()
				SSblackbox.record_feedback("tally", "pick_used_mining", 1, W.type)
				return TRUE

		else if(istype(W, /obj/item/storage/bag/ore))
			for(var/obj/item/stack/ore/O in src)
				SEND_SIGNAL(W, COMSIG_PARENT_ATTACKBY, O)

		else if(istype(W, /obj/item/stack/sheet/mineral/wood) || istype(W, /obj/item/stack/sheet/mineral/sandstone))
			if(!dug)
				return
			var/obj/item/stack/sheet/mineral/M = W
			if (M.get_amount() < 5)
				to_chat(user, "<span class='warning'>You need at least five sheets for that!</span>")
				return
			var/turf/dest_turf = get_turf(src)
			if(locate(/obj/structure/closet/crate/grave) in dest_turf)
				to_chat(user, "<span class='warning'>There is already a grave there!</span>")
				return
			to_chat(user, "<span class='notice'>You start piling the dirt...</span>")
			if(do_after(user,30, target = src))
				if(locate(/obj/structure/closet/crate/grave) in dest_turf)
					return
				if(istype(W, /obj/item/stack/sheet/mineral/wood))
					new /obj/structure/closet/crate/grave(dest_turf)
				else if(istype(W, /obj/item/stack/sheet/mineral/sandstone))
					new /obj/structure/closet/crate/grave/stone(dest_turf)
				M.use(5)
				to_chat(user, "<span class='notice'>You place burial mound on [src].</span>")
			return

/turf/open/floor/plating/asteroid/ex_act(severity, target)
	. = SEND_SIGNAL(src, COMSIG_ATOM_EX_ACT, severity, target)
	contents_explosion(severity, target)

/turf/open/floor/plating/asteroid/lowpressure
	initial_gas_mix = OPENTURF_LOW_PRESSURE
	baseturfs = /turf/open/floor/plating/asteroid/lowpressure
	turf_type = /turf/open/floor/plating/asteroid/lowpressure

/turf/open/floor/plating/asteroid/airless
	initial_gas_mix = AIRLESS_ATMOS
	baseturfs = /turf/open/floor/plating/asteroid/airless
	turf_type = /turf/open/floor/plating/asteroid/airless

