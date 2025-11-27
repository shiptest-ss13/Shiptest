
/obj
	animate_movement = SLIDE_STEPS
	speech_span = SPAN_ROBOT

	bad_type = /obj
	var/obj_flags = CAN_BE_HIT
	var/set_obj_flags // ONLY FOR MAPPING: Sets flags from a string list, handled in Initialize. Usage: set_obj_flags = "EMAGGED;!CAN_BE_HIT" to set EMAGGED and clear CAN_BE_HIT.

	var/damtype = BRUTE
	var/force = 0
	var/armour_penetration = 0


	/// How good a given object is at causing wounds on carbons. Higher values equal better shots at creating serious wounds.
	var/wound_bonus = 0
	/// If this attacks a human with no wound armor on the affected body part, add this to the wound mod. Some attacks may be significantly worse at wounding if there's even a slight layer of armor to absorb some of it vs bare flesh
	var/bare_wound_bonus = 0

	var/acid_level = 0 //how much acid is on that obj

	var/persistence_replacement //have something WAY too amazing to live to the next round? Set a new path here. Overuse of this var will make me upset.

	/// A multiplier to an objecet's force when used against a stucture, vechicle, machine, or robot.
	var/demolition_mod = 1

	// Access levels, used in modules\jobs\access.dm
	var/list/req_access
	var/req_access_txt = "0"
	var/list/req_one_access
	var/req_one_access_txt = "0"
	// If the object resides in a ship area, determines if the object also requires the ID to have access to the ship
	var/req_ship_access = FALSE
	/// Custom fire overlay icon
	var/custom_fire_overlay

	var/renamedByPlayer = FALSE //set when a player uses a pen on a renamable object

	var/drag_slowdown // Amont of multiplicative slowdown applied if pulled. >1 makes you slower, <1 makes you faster.

	vis_flags = VIS_INHERIT_PLANE //when this be added to vis_contents of something it inherit something.plane, important for visualisation of obj in openspace.

	var/obj/effect/abstract/particle_holder/burning_particles

	FASTDMM_PROP(\
		pinned_vars = list("name", "dir")\
	)

/obj/vv_edit_var(vname, vval)
	if(vname == NAMEOF(src, obj_flags))
		if ((obj_flags & DANGEROUS_POSSESSION) && !(vval & DANGEROUS_POSSESSION))
			return FALSE
	return ..()

/obj/Initialize(mapload)
	. = ..() //Do this after, else mat datums is mad.

	if (set_obj_flags)
		var/flagslist = splittext(set_obj_flags,";")
		var/list/string_to_objflag = GLOB.bitfields["obj_flags"]
		for (var/flag in flagslist)
			if(flag[1] == "!")
				flag = copytext(flag, length(flag[1]) + 1) // Get all but the initial !
				obj_flags &= ~string_to_objflag[flag]
			else
				obj_flags |= string_to_objflag[flag]
	if((obj_flags & ON_BLUEPRINTS) && isturf(loc) && mapload)
		var/turf/T = loc
		T.add_blueprints(src)
	if(obj_flags & ELEVATED_SURFACE)
		var/static/list/loc_connections = list(
			COMSIG_TURF_OPEN_FLAME = PROC_REF(on_open_flame),
		)
		AddElement(/datum/element/connect_loc, loc_connections)

/obj/Destroy(force=FALSE)
	if(!ismachinery(src))
		STOP_PROCESSING(SSobj, src) // TODO: Have a processing bitflag to reduce on unnecessary loops through the processing lists
	SStgui.close_uis(src)
	if(burning_particles)
		QDEL_NULL(burning_particles)
	return ..()


/obj/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, gentle = FALSE, quickstart = TRUE)
	. = ..()
	if(obj_flags & FROZEN)
		visible_message(span_danger("[src] shatters into a million pieces!"))
		qdel(src)


/obj/assume_air(datum/gas_mixture/giver)
	if(loc)
		return loc.assume_air(giver)
	else
		return null

/obj/assume_air_moles(datum/gas_mixture/giver, moles)
	if(loc)
		return loc.assume_air_moles(giver, moles)
	else
		return null

/obj/assume_air_ratio(datum/gas_mixture/giver, ratio)
	if(loc)
		return loc.assume_air_ratio(giver, ratio)
	else
		return null

/obj/transfer_air(datum/gas_mixture/taker, moles)
	if(loc)
		return loc.transfer_air(taker, moles)
	else
		return null

/obj/transfer_air_ratio(datum/gas_mixture/taker, ratio)
	if(loc)
		return loc.transfer_air_ratio(taker, ratio)
	else
		return null

/obj/remove_air(amount)
	if(loc)
		return loc.remove_air(amount)
	else
		return null

/obj/remove_air_ratio(ratio)
	if(loc)
		return loc.remove_air_ratio(ratio)
	else
		return null

/obj/return_air()
	if(loc)
		return loc.return_air()
	else
		return null

/obj/proc/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
	//Return: (NONSTANDARD)
	//		null if object handles breathing logic for lifeform
	//		datum/air_group to tell lifeform to process using that breath return
	//DEFAULT: Take air from turf to give to have mob process

	if(breath_request>0)
		var/datum/gas_mixture/environment = return_air()
		return remove_air_ratio(BREATH_VOLUME / environment.return_volume())
	else
		return null

/obj/proc/updateUsrDialog()
	if((obj_flags & IN_USE) && !(obj_flags & USES_TGUI))
		var/is_in_use = FALSE
		var/list/nearby = viewers(1, src)
		for(var/mob/M in nearby)
			if ((M.client && M.machine == src))
				is_in_use = TRUE
				ui_interact(M)
		if(issilicon(usr) || isAdminGhostAI(usr))
			if (!(usr in nearby))
				if (usr.client && usr.machine==src) // && M.machine == src is omitted because if we triggered this by using the dialog, it doesn't matter if our machine changed in between triggering it and this - the dialog is probably still supposed to refresh.
					is_in_use = TRUE
					ui_interact(usr)

		// check for TK users

		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(!(usr in nearby))
				if(usr.client && usr.machine==src)
					if(H.dna.check_mutation(TK))
						is_in_use = TRUE
						ui_interact(usr)
		if (is_in_use)
			obj_flags |= IN_USE
		else
			obj_flags &= ~IN_USE

/obj/proc/updateDialog(update_viewers = TRUE,update_ais = TRUE)
	// Check that people are actually using the machine. If not, don't update anymore.
	if(obj_flags & IN_USE)
		var/is_in_use = FALSE
		if(update_viewers)
			for(var/mob/M in viewers(1, src))
				if ((M.client && M.machine == src))
					is_in_use = TRUE
					src.interact(M)
		var/ai_in_use = FALSE
		if(update_ais)
			ai_in_use = AutoUpdateAI(src)

		if(update_viewers && update_ais) //State change is sure only if we check both
			if(!ai_in_use && !is_in_use)
				obj_flags &= ~IN_USE


/obj/attack_ghost(mob/user)
	. = ..()
	if(.)
		return
	ui_interact(user)

/mob/proc/unset_machine()
	SIGNAL_HANDLER
	if(!machine)
		return
	UnregisterSignal(machine, COMSIG_PARENT_QDELETING)
	machine.on_unset_machine(src)
	machine = null

//called when the user unsets the machine.
/atom/movable/proc/on_unset_machine(mob/user)
	return

/mob/proc/set_machine(obj/O)
	if(QDELETED(src) || QDELETED(O))
		return
	if(machine)
		unset_machine()
	machine = O
	RegisterSignal(O, COMSIG_PARENT_QDELETING, PROC_REF(unset_machine))
	if(istype(O))
		O.obj_flags |= IN_USE

/obj/item/proc/updateSelfDialog()
	var/mob/M = src.loc
	if(istype(M) && M.client && M.machine == src)
		src.attack_self(M)

/obj/singularity_pull(S, current_size)
	..()
	if(!anchored || current_size >= STAGE_FIVE)
		step_towards(src,S)

/obj/get_dumping_location(datum/component/storage/source,mob/user)
	return get_turf(src)

/**
 * This proc is used for telling whether something can pass by this object in a given direction, for use by the pathfinding system.
 *
 * Trying to generate one long path across the station will call this proc on every single object on every single tile that we're seeing if we can move through, likely
 * multiple times per tile since we're likely checking if we can access said tile from multiple directions, so keep these as lightweight as possible.
 *
 * Arguments:
 * * ID- An ID card representing what access we have (and thus if we can open things like airlocks or windows to pass through them). The ID card's physical location does not matter, just the reference
 * * to_dir- What direction we're trying to move in, relevant for things like directional windows that only block movement in certain directions
 * * requester- The movable we're checking pass flags for, if we're making any such checks
 **/
/obj/proc/CanAStarPass(obj/item/card/id/ID, to_dir, atom/movable/requester)
	if(istype(requester) && (requester.pass_flags & pass_flags_self))
		return TRUE
	. = !density

/obj/proc/check_uplink_validity()
	return 1

/obj/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---")
	VV_DROPDOWN_OPTION(VV_HK_MASS_DEL_TYPE, "Delete all of type")
	VV_DROPDOWN_OPTION(VV_HK_OSAY, "Object Say")
	VV_DROPDOWN_OPTION(VV_HK_ARMOR_MOD, "Modify armor values")

/obj/vv_do_topic(list/href_list)
	if(!(. = ..()))
		return
	if(href_list[VV_HK_OSAY])
		if(check_rights(R_FUN, FALSE))
			usr.client.object_say(src)
	if(href_list[VV_HK_ARMOR_MOD])
		var/list/pickerlist = list()
		var/list/armorlist = armor.getList()

		for (var/i in armorlist)
			pickerlist += list(list("value" = armorlist[i], "name" = i))

		var/list/result = presentpicker(usr, "Modify armor", "Modify armor: [src]", Button1="Save", Button2 = "Cancel", Timeout=FALSE, inputtype = "text", values = pickerlist)

		if (islist(result))
			if (result["button"] != 2) // If the user pressed the cancel button
				// text2num conveniently returns a null on invalid values
				armor = armor.setRating(
					melee = text2num(result["values"]["melee"]),
					bullet = text2num(result["values"]["bullet"]),
					laser = text2num(result["values"]["laser"]),
					energy = text2num(result["values"]["energy"]),
					bomb = text2num(result["values"]["bomb"]),
					bio = text2num(result["values"]["bio"]),
					rad = text2num(result["values"]["rad"]),
					fire = text2num(result["values"]["fire"]),
					acid = text2num(result["values"]["acid"])
				)
				log_admin("[key_name(usr)] modified the armor on [src] ([type]) to melee: [armor.melee], bullet: [armor.bullet], laser: [armor.laser], energy: [armor.energy], bomb: [armor.bomb], bio: [armor.bio], rad: [armor.rad], fire: [armor.fire], acid: [armor.acid]")
				message_admins(span_notice("[key_name_admin(usr)] modified the armor on [src] ([type]) to melee: [armor.melee], bullet: [armor.bullet], laser: [armor.laser], energy: [armor.energy], bomb: [armor.bomb], bio: [armor.bio], rad: [armor.rad], fire: [armor.fire], acid: [armor.acid]"))
	if(href_list[VV_HK_MASS_DEL_TYPE])
		if(check_rights(R_DEBUG|R_SERVER))
			var/action_type = alert("Strict type ([type]) or type and all subtypes?",,"Strict type","Type and subtypes","Cancel")
			if(action_type == "Cancel" || !action_type)
				return

			if(alert("Are you really sure you want to delete all objects of type [type]?",,"Yes","No") != "Yes")
				return

			if(alert("Second confirmation required. Delete?",,"Yes","No") != "Yes")
				return

			var/O_type = type
			switch(action_type)
				if("Strict type")
					var/i = 0
					for(var/obj/Obj in world)
						if(Obj.type == O_type)
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No objects of this type exist")
						return
					log_admin("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted) ")
					message_admins(span_notice("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted) "))
				if("Type and subtypes")
					var/i = 0
					for(var/obj/Obj in world)
						if(istype(Obj,O_type))
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No objects of this type exist")
						return
					log_admin("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted) ")
					message_admins(span_notice("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted) "))

/obj/examine(mob/user)
	. = ..()
	if(obj_flags & UNIQUE_RENAME)
		. += span_notice("Use a pen on it to rename it or change its description.")

/obj/deconstruct_act(mob/living/user, obj/item/I)
	if(resistance_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("[src] cannot be deconstructed!"))
		return TRUE
	return ..()

/obj/analyzer_act(mob/living/user, obj/item/I)
	if(atmosanalyzer_scan(user, src))
		return TRUE
	return ..()

/obj/proc/plunger_act(obj/item/plunger/P, mob/living/user)
	return

/obj/proc/on_open_flame(datum/source, flame_heat)
	return BLOCK_TURF_IGNITION

// Should move all contained objects to it's location.
/obj/proc/dump_contents()
	CRASH("Unimplemented.")

/obj/handle_ricochet(obj/projectile/P)
	. = ..()
	if(. && receive_ricochet_damage_coeff)
		take_damage(P.damage * receive_ricochet_damage_coeff, P.damage_type, P.flag, 0, turn(P.dir, 180), P.armour_penetration) // pass along receive_ricochet_damage_coeff damage to the structure for the ricochet

/obj/update_overlays()
	. = ..()
	if(acid_level)
		. += GLOB.acid_overlay
	if(resistance_flags & ON_FIRE)
		. += custom_fire_overlay ? custom_fire_overlay : GLOB.fire_overlay

/// Handles exposing an object to reagents.
/obj/expose_reagents(list/reagents, datum/reagents/source, method=TOUCH, volume_modifier=1, show_message=TRUE)
	if((. = ..()) & COMPONENT_NO_EXPOSE_REAGENTS)
		return

	for(var/reagent in reagents)
		var/datum/reagent/R = reagent
		. |= R.expose_obj(src, reagents[R])

/**
* For returning special data when the object is saved
*For example, or silos will return a list of their materials which will be dumped on top of them
*Can be customised if you have something that contains something you want saved
*If you put an incorrect format it will break outputting, so don't use this if you don't know what you are doing
* NOTE: Contents is automatically saved, so if you store your things in the contents var, don't worry about this
* ====Output Format Examples====:
* ===Single Object===
*	"/obj/item/folder/blue"
* ===Multiple Objects===
*	"/obj/item/folder/blue,\n
*	/obj/item/folder/red"
* ===Single Object with metadata===
*	"/obj/item/folder/blue{\n
*	\tdir = 8;\n
*	\tname = "special folder"\n
*	\t}"
* ===Multiple Objects with metadata===
*	"/obj/item/folder/blue{\n
*	\tdir = 8;\n
*	\tname = "special folder"\n
*	\t},\n
*	/obj/item/folder/red"
* ====How to save easily====:
*	return "[thing.type][generate_tgm_metadata(thing)]"
* Where thing is the additional thing you want to same (For example ores inside an ORM)
* Just add ,\n between each thing
* generate_tgm_metadata(thing) handles everything inside the {} for you
**/
/obj/proc/on_object_saved(depth = 0)
	return ""
