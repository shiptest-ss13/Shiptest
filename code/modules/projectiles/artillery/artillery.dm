#define get_dist_euclide_square(A, B) (A && B ? A.z == B.z ? (A.x - B.x)**2 + (A.y - B.y)**2 : INFINITY : INFINITY)
#define get_dist_euclide(A, B) (sqrt(get_dist_euclide_square(A, B)))


/obj/item/binoculars/rangefinder
	name = "rangefinder"
	desc = "A pair of binoculars, with a laser targeting function that will tell you the gps location where you point it."
	icon_state = "rangefinder"
	item_state = "binoculars"


/obj/item/binoculars/rangefinder/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	var/turf/targloc = get_turf(target)

	var/datum/virtual_level/our_vlevel = get_virtual_level()
	if(!our_vlevel)
		return
	var/list/coords = our_vlevel.get_relative_coords(targloc)

	to_chat(user, span_notice("COORDINATES: LONGITUDE [coords[1]]. LATITUDE [coords[2]]."))
	playsound(src, 'sound/machines/artillery/binoctarget.ogg', 35)


/obj/machinery/artillery
	name = "howitzer"
	desc = "A manual, crew-operated and towable howitzer, will rain down shells on any of your foes."
	icon = 'icons/obj/machines/howitzer.dmi'
	icon_state = "howitzer_deployed"
	//layers above
	layer = ABOVE_MOB_LAYER
	var/icon_undeployed = "howitzer"
	var/icon_deployed = "howitzer_deployed"
	var/fire_sound = 'sound/machines/artillery/howitzer_fire.ogg'
	var/reload_sound = 'sound/machines/artillery/tat36_reload.ogg'
	var/fall_sound = 'sound/machines/artillery/howitzer_whistle.ogg'
	atom_integrity = 400
	max_integrity = 400

	///probably shouldnt have this towed around everywhere
	drag_slowdown = 1.5

	can_be_unanchored = TRUE
	pixel_x = -16
	anchored = TRUE // You can move this.


	/// Number of turfs to offset from target by 1
	var/offset_per_turfs = 15
	///Minimum range to fire
	var/minimum_range = 15
	/// Constant spread on target
	var/spread = 1
	/// Max spread on target
	var/max_spread = 2
	/// Used for deconstruction and aiming sanity
	var/firing = 0
	///Time it takes for the mortar to cool off to fire
	var/cool_off_time = 10 SECONDS
	///Time to load a shell
	var/reload_time = 1 SECONDS
	var/target_x
	var/target_y

	/// What type of shells can we use?
	var/list/allowed_shells = list(
		/obj/item/mortal_shell/howitzer,
		/obj/item/mortal_shell/howitzer/incendiary,
		/obj/item/mortal_shell/howitzer/he,
		/obj/item/mortal_shell/howitzer/flare,
		/obj/item/mortal_shell/howitzer/smoke,
		/obj/item/mortal_shell/howitzer/airburst,
		/obj/item/mortal_shell/flare,
	)

/obj/machinery/artillery/wrench_act(mob/user, obj/item/tool)
	. = ..()
	if(!can_be_unanchored)
		return FALSE
	switch(anchored)
		if(FALSE)
			if(!isfloorturf(loc))
				to_chat(user, span_warning("A floor must be present to secure [src]!"))

			to_chat(user, span_notice("You start securing [src]..."))
			if(tool.use_tool(src, user, 8 SECONDS, volume=100))
				to_chat(user, span_notice("You secure [src]."))
				icon_state = icon_deployed
				set_anchored(TRUE)
			return TRUE
		if(TRUE)
			to_chat(user, span_notice("You start unsecuring [src]..."))
			if(tool.use_tool(src, user, 8 SECONDS, volume=100))
				to_chat(user, span_notice("You unsecure [src]."))
				icon_state = icon_undeployed
				set_anchored(FALSE)
			return TRUE


/obj/machinery/artillery/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	var/old_x = target_x
	var/old_y = target_y
	var/inputed

	inputed = input(usr, "Set target X", "Coords", target_x) as num
	if(!inputed)
		return
	target_x = inputed
	inputed = input(usr, "Set target Y", "Coords", target_y) as num
	if(!inputed)
		return
	target_y = inputed

	var/datum/virtual_level/our_vlevel = get_virtual_level()
	if(!our_vlevel)
		return

	var/datum/overmap/our_overmap_object = get_overmap_location()
	var/real_x = our_vlevel.low_x + target_x - 1
	var/real_y = our_vlevel.low_y + target_y - 1

	var/turf/target_turf = locate(real_x, real_y, z)
	var/list/our_coords = our_vlevel.get_relative_coords(target_turf)

	//Check if we're not in space or 0g, basically
	if(istype(our_overmap_object, /datum/overmap/dynamic) || istype(our_overmap_object, /datum/overmap/ship))
		var/datum/overmap/dynamic/our_dynamic_object
		var/do_not_fire = FALSE
		//get thing this is docked to
		if(istype(our_overmap_object, /datum/overmap/ship))
			our_dynamic_object = our_overmap_object.docked_to
			if(!(istype(our_overmap_object.docked_to, /datum/overmap/static_object) || istype(our_overmap_object.docked_to, /datum/overmap/outpost)))
				do_not_fire = TRUE
		else
			our_dynamic_object = our_overmap_object
		if(our_dynamic_object)
			if(is_type_in_list(our_overmap_object, list(/datum/planet_type/asteroid, /datum/planet_type/spaceruin, /datum/overmap/dynamic/empty)))
				do_not_fire = TRUE
		if(do_not_fire)
			user.balloon_alert(user, "not in 0g!")
			to_chat(user, span_danger("How are you going to fire this in 0g..?"))
			return

	if(!target_turf)
		user.balloon_alert(user, "invalid location.")
		to_chat(user, span_danger("Invalid location."))
		target_x = old_x
		target_y = old_y

		return

	if(get_dist(loc, target_turf) < minimum_range)
		user.balloon_alert(user, "the target is too close to the gun.")
		to_chat(user, span_danger("The target is too close to the gun."))
		target_x = old_x
		target_y = old_y
		return

	if(!isturf(target_turf) || isindestructiblewall(target_turf))
		user.balloon_alert(user, "you cannot fire the gun to this target.")
		to_chat(user, span_danger("You cannot fire the gun to this target."))
		target_x = old_x
		target_y = old_y
		return

	if(!target_turf.virtual_z() == virtual_z())
		user.balloon_alert(user, "you cannot fire the gun to this target.")
		to_chat(user, span_danger("You cannot fire the gun to this target."))
		target_x = old_x
		target_y = old_y
		return

	to_chat(user, span_notice("TARGET SET: LONGITUDE [our_coords[1]]. LATITUDE [our_coords[2]]."))

/obj/machinery/artillery/attackby(obj/item/potential_shell, mob/user, params)
	. = ..()

	if(!anchored)
		user.balloon_alert(user, "anchor it first!")
		to_chat(user, span_danger("Anchor [src] first!"))
		return

	if(isnull(target_x) || isnull(target_y))
		to_chat(user, span_danger("Please set coordinates before firing."))
		return

	if(firing)
		user.balloon_alert(user, "the barrel is steaming hot. wait till it cools off")
		to_chat(user, span_danger("The barrel is steaming hot. Wait till it cools off!"))
		return

	if(istype(potential_shell, /obj/item/mortal_shell))
		var/obj/item/mortal_shell/mortar_shell = potential_shell
		if(!istype(mortar_shell))
			return

		if(!(potential_shell.type in allowed_shells))
			user.balloon_alert(user, "this shell doesn't fit")
			to_chat(user, span_danger("This shell doesn't fit!"))
			return

		user.visible_message(span_notice("[user] starts loading [mortar_shell] into [src]."),
		span_notice("You start loading [mortar_shell] into [src]."))
		playsound(loc, reload_sound, 50, 1)
		if(!do_after(user, reload_time, src, NONE))
			return

		pre_fire(mortar_shell, user, params)

/obj/machinery/artillery/proc/check_valid_turf(turf/checked_turf)
	if(!checked_turf)
		return FALSE

	if(get_dist(loc, checked_turf) < minimum_range)
		return FALSE

	if(!isturf(checked_turf) || isindestructiblewall(checked_turf))
		return FALSE

	if(!checked_turf.virtual_z() == virtual_z())
		return FALSE
	return TRUE

/obj/machinery/artillery/proc/perform_firing_visuals()
	SHOULD_NOT_SLEEP(TRUE)
	return

//Calcuate the final location before firing.
/obj/machinery/artillery/proc/pre_fire(obj/item/mortal_shell/mortar_shell, mob/user, params)
	var/datum/virtual_level/our_vlevel = get_virtual_level()

	var/real_x = our_vlevel.low_x + target_x - 1
	var/real_y = our_vlevel.low_y + target_y - 1

	var/turf/target_turf = locate(real_x, real_y, z)

	if(!target_turf || !check_valid_turf(target_turf))
		user.balloon_alert(user, "invalid location.")
		to_chat(user, span_danger("Invalid location. Please set valid coordinates"))

	var/max_offset = round(abs((get_dist_euclide(src,target_turf)))/offset_per_turfs)
	var/firing_spread = max_offset + spread
	if(firing_spread > max_spread)
		firing_spread = max_spread

	var/list/turf_list = list()
	for(var/turf/spread_turf in RANGE_TURFS(firing_spread, target_turf))
		if(!check_valid_turf(spread_turf))
			continue
		turf_list += spread_turf
	var/turf/impact_turf = pick(turf_list)
	mortar_shell.forceMove(src)
	begin_fire(impact_turf, mortar_shell)


///Start firing the gun on target and increase tally
/obj/machinery/artillery/proc/begin_fire(atom/target, obj/item/mortal_shell/arty_shell)
	firing = TRUE
	for(var/mob/M in GLOB.player_list)
		if(get_dist(M , src) <= 7)
			shake_camera(M, 1, 1)

	playsound(loc, fire_sound, 50, 1)
	flick(icon_state + "_fire", src)
	var/obj/projectile/shell = new arty_shell.ammo_type(get_turf(src))

	var/shell_range = min(get_dist_euclide(src, target), shell.range)

	shell.preparePixelProjectile(get_step(src, pick(GLOB.alldirs)), get_turf(src))
	shell.firer = src
	shell.range = shell_range
	shell.fire(Get_Angle(src,target))

	perform_firing_visuals()
	qdel(arty_shell)

	var/fall_time = ((shell_range * (shell.speed/20)) SECONDS) - 1.5 SECONDS
	//prevent runtime
	fall_time = max(fall_time, 1.5 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(falling), target, shell), fall_time)
	addtimer(VARSET_CALLBACK(src, firing, FALSE), cool_off_time)

///Begins fall animation for projectile and plays fall sound
/obj/machinery/artillery/proc/falling(turf/T, obj/projectile/shell)
	flick(shell.icon_state + "_falling", shell)
	shell.icon_state = shell.icon_state + "_falling"
	playsound(T, fall_sound, 75, 1)

/obj/machinery/artillery/mortar
	name = "mortar"
	desc = "A manual, crew-operated mortar system intended to rain down shells on anything it's aimed at. Less accurate than a proper artillery cannon, but still useful neverless. Needs to be set down first to fire."
	icon = 'icons/obj/machines/mortar.dmi'
	icon_state = "mortar_deployed"
	atom_integrity = 250
	max_integrity = 250
	fire_sound = 'sound/machines/artillery/mortar_fire.ogg'
	reload_sound = 'sound/machines/artillery/mortar_reload.ogg'
	///32x32 sprite
	pixel_x = 0
	max_spread = 5
	cool_off_time = 1 SECONDS
	reload_time = 0.5 SECONDS
	/// Prevents the standard behavior
	can_be_unanchored = FALSE
	///Ditto
	anchored = TRUE

	/// What gets spawned if the object is undeployed
	var/obj/spawned_on_undeploy = /obj/item/deployable_mortar_folded
	/// How long it takes for a wrench user to undeploy the object
	var/undeploy_time = 5 SECONDS

	allowed_shells = list(
		/obj/item/mortal_shell/he,
		/obj/item/mortal_shell/incendiary,
		/obj/item/mortal_shell/smoke,
		/obj/item/mortal_shell/flare,
		/obj/item/mortal_shell/airburst,
	)

/obj/machinery/artillery/mortar/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl+Click on a tile to deploy. Once deployed, you can drag the mortar onto yourself to undeploy.")

/obj/machinery/artillery/mortar/MouseDrop(atom/over_object)
	. = ..()
	var/mob/living/user = usr
	if(!istype(user) || user.incapacitated() || !Adjacent(user))
		return

	if(over_object == user)
		to_chat(user, "<span class='notice'>You start undeploying [src]...</span>")
		user.balloon_alert(user, "undeploying...")
		if(!do_after(user, undeploy_time))
			return
		var/obj/undeployed_object = new spawned_on_undeploy(src)
		//Keeps the health the same even if you redeploy the gun
		undeployed_object.modify_max_integrity(max_integrity)
		user.put_in_hands(undeployed_object)
		qdel(src)

/obj/item/deployable_mortar_folded
	name = "folded mortar"
	desc = "A manual, crew-operated mortar system intended to rain down shells on anything it's aimed at. Less accurate than a proper artillery cannon, but still useful neverless. Needs to be set down first to fire."
	icon = 'icons/obj/machines/mortar.dmi'
	icon_state = "mortar"
	max_integrity = 250
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

/obj/item/deployable_mortar_folded/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl+Click on a tile to deploy. Once deployed, you can drag the mortar onto yourself to undeploy.")

/obj/item/deployable_mortar_folded/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, 5 SECONDS, /obj/machinery/artillery/mortar, delete_on_use = TRUE)


/obj/machinery/artillery/vls
	name = "\improper missile launch tube"
	desc = "A tube covered with a hatch, letting out guided missles upon being fired."
	icon = 'icons/obj/machines/vls.dmi'
	icon_state = "vls_deployed"
	atom_integrity = 1000
	max_integrity = 1000
	fire_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	fall_sound = 'sound/machines/artillery/rocket_whistle.ogg'
	reload_sound = 'sound/machines/artillery/tat36_reload.ogg'
	//meant to be under the player
	layer = BELOW_OBJ_LAYER
	reload_time = 2 SECONDS
	///32x32 sprite
	pixel_x = 0
	max_spread = 0
	cool_off_time = 2 SECONDS
	/// stationary
	can_be_unanchored = FALSE
	///stationary
	anchored = TRUE

	allowed_shells = list(
		/obj/item/mortal_shell/rocket/he,
		/obj/item/mortal_shell/rocket/incendiary,
	)
