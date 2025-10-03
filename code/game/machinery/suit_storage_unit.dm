#define BASE_UV_CYCLES 7

#define LOCKED_SSU_HELPER(unit_type)						\
	/obj/machinery/suit_storage_unit/##unit_type/locked {	\
		locked = TRUE;										\
	}

// SUIT STORAGE UNIT /////////////////
/obj/machinery/suit_storage_unit
	name = "suit storage unit"
	desc = "A commercial unit made to hold and decontaminate irradiated equipment. It comes with a built-in UV cauterization mechanism. A small warning label advises that organic matter should not be placed into the unit."
	icon = 'icons/obj/machines/suit_storage.dmi'
	icon_state = "ssu_classic"
	base_icon_state = "ssu_classic"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	max_integrity = 250
	circuit = /obj/item/circuitboard/machine/suit_storage_unit

	var/obj/item/clothing/suit/space/suit = null
	var/obj/item/clothing/head/helmet/space/helmet = null
	var/obj/item/clothing/mask/mask = null
	var/obj/item/mod/control/mod = null
	var/obj/item/storage = null
								// if you add more storage slots, update cook() to clear their radiation too.

	/// What type of spacesuit the unit starts with when spawned.
	var/suit_type = null
	/// What type of space helmet the unit starts with when spawned.
	var/helmet_type = null
	/// What type of breathmask the unit starts with when spawned.
	var/mask_type = null
	/// What type of additional item the unit starts with when spawned.
	var/storage_type = null
	/// What type of MOD the unit starts with when spawned.
	var/mod_type = null

	state_open = FALSE
	/// If the SSU's doors are locked closed. Can be toggled manually via the UI, but is also locked automatically when the UV decontamination sequence is running.
	var/locked = FALSE
	var/lock_functional = TRUE
	panel_open = FALSE
	/// If the safety wire is cut/pulsed, the SSU can run the decontamination sequence while occupied by a mob. The mob will be burned during every cycle of cook().
	var/safeties = TRUE

	/// If UV decontamination sequence is running. See cook()
	var/uv = FALSE
	/**
	* If the hack wire is cut/pulsed.
	* Modifies effects of cook()
	* * If FALSE, decontamination sequence will clear radiation for all atoms (and their contents) contained inside the unit, and burn any mobs inside.
	* * If TRUE, decontamination sequence will delete all items contained within, and if occupied by a mob, intensifies burn damage delt. All wires will be cut at the end.
	*/
	var/uv_super = FALSE
	/// How many cycles remain for the decontamination sequence.
	var/uv_cycles = 7
	/// Time reduction from stock parts
	var/lasers_bonus = 0
	/// Cooldown for occupant breakout messages via relaymove()
	var/message_cooldown
	/// How long it takes to break out of the SSU.
	var/breakout_time = 300
	var/obj/item/electronics/airlock/electronics

/obj/machinery/suit_storage_unit/industrial
	name = "industrial suit storage unit"
	desc = "An industrial unit made to hold and decontaminate irradiated equipment. It comes with a built-in UV cauterization mechanism. A small warning label advises that organic matter should not be placed into the unit."
	icon_state = "industrial"
	base_icon_state = "industrial"
	circuit = /obj/item/circuitboard/machine/suit_storage_unit/industrial

/obj/machinery/suit_storage_unit/industrial/atmos_firesuit
	name = "firesuit storage unit"
	suit_type = /obj/item/clothing/suit/fire/atmos
	helmet_type = /obj/item/clothing/head/hardhat/atmos
	mask_type = /obj/item/clothing/mask/gas/atmos
	storage_type = /obj/item/watertank/atmos
	req_access = list(ACCESS_ATMOSPHERICS)

LOCKED_SSU_HELPER(industrial/atmos_firesuit)

/obj/machinery/suit_storage_unit/inherit/industrial //i know its dirty but, eh you fix it, i am mapping rn
	name = "industrial suit storage unit"
	desc = "An industrial unit made to hold and decontaminate irradiated equipment. It comes with a built-in UV cauterization mechanism. A small warning label advises that organic matter should not be placed into the unit."
	icon_state = "industrial"
	base_icon_state = "industrial"
	circuit = /obj/item/circuitboard/machine/suit_storage_unit/industrial

LOCKED_SSU_HELPER(inherit)

LOCKED_SSU_HELPER(inherit/industrial)

/obj/machinery/suit_storage_unit/standard_unit
	suit_type = /obj/item/clothing/suit/space/eva
	helmet_type = /obj/item/clothing/head/helmet/space/eva
	mask_type = /obj/item/clothing/mask/breath

/obj/machinery/suit_storage_unit/captain
	name = "captain's suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/swat/captain
	mask_type = /obj/item/clothing/mask/gas/atmos/captain
	storage_type = /obj/item/tank/jetpack/oxygen/captain
	req_access = list(ACCESS_CAPTAIN)

LOCKED_SSU_HELPER(captain)

/obj/machinery/suit_storage_unit/engine
	name = "engineer's suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/engine
	mask_type = /obj/item/clothing/mask/breath
	storage_type= /obj/item/clothing/shoes/magboots
	req_access = list(ACCESS_CONSTRUCTION)

LOCKED_SSU_HELPER(engine)

/obj/machinery/suit_storage_unit/atmos
	name = "atmospheric suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/engine/atmos
	mask_type = /obj/item/clothing/mask/gas/atmos
	storage_type = /obj/item/watertank/atmos
	req_access = list(ACCESS_ATMOSPHERICS)

LOCKED_SSU_HELPER(atmos)

/obj/machinery/suit_storage_unit/ce
	name = "CE's suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/engine/elite
	mask_type = /obj/item/clothing/mask/breath
	storage_type= /obj/item/clothing/shoes/magboots/advance
	req_access = list(ACCESS_CE)

LOCKED_SSU_HELPER(ce)

/obj/machinery/suit_storage_unit/security
	name = "security suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/security
	mask_type = /obj/item/clothing/mask/gas/vigilitas
	req_access = list(ACCESS_BRIG)

LOCKED_SSU_HELPER(security)

/obj/machinery/suit_storage_unit/hos
	name = "HOS' suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/security/hos
	mask_type = /obj/item/clothing/mask/gas/vigilitas
	storage_type = /obj/item/tank/internals/oxygen
	req_access = list(ACCESS_HOS)

LOCKED_SSU_HELPER(hos)

/obj/machinery/suit_storage_unit/mining
	name = "mining suit storage unit"
	suit_type = /obj/item/clothing/suit/hooded/explorer
	mask_type = /obj/item/clothing/mask/gas/explorer
	req_access = list(ACCESS_MINING)

LOCKED_SSU_HELPER(mining)

/obj/machinery/suit_storage_unit/mining/eva
	suit_type = /obj/item/clothing/suit/space/hardsuit/mining
	mask_type = /obj/item/clothing/mask/breath

LOCKED_SSU_HELPER(mining/eva)

/obj/machinery/suit_storage_unit/cmo
	name = "CMO's suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/medical/cmo
	mask_type = /obj/item/clothing/mask/breath/medical
	storage_type = /obj/item/tank/internals/oxygen
	req_access = list(ACCESS_CMO)

LOCKED_SSU_HELPER(cmo)

/obj/machinery/suit_storage_unit/bomb
	name = "bomb suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/bomb
	mask_type = /obj/item/clothing/mask/breath

LOCKED_SSU_HELPER(rd)

/obj/machinery/suit_storage_unit/syndicate
	suit_type = /obj/item/clothing/suit/space/hardsuit/syndi
	mask_type = /obj/item/clothing/mask/gas/syndicate
	storage_type = /obj/item/tank/jetpack/oxygen/harness

/obj/machinery/suit_storage_unit/ert
	name = "ERT suit storage unit"
	req_access = list(ACCESS_CENT_SPECOPS)

/obj/machinery/suit_storage_unit/ert/command
	suit_type = /obj/item/clothing/suit/space/hardsuit/ert
	mask_type = /obj/item/clothing/mask/breath
	storage_type = /obj/item/tank/internals/emergency_oxygen/double

/obj/machinery/suit_storage_unit/ert/security
	suit_type = /obj/item/clothing/suit/space/hardsuit/ert/sec
	mask_type = /obj/item/clothing/mask/breath
	storage_type = /obj/item/tank/internals/emergency_oxygen/double

/obj/machinery/suit_storage_unit/ert/engineer
	suit_type = /obj/item/clothing/suit/space/hardsuit/ert/engi
	mask_type = /obj/item/clothing/mask/breath
	storage_type = /obj/item/tank/internals/emergency_oxygen/double

/obj/machinery/suit_storage_unit/ert/medical
	suit_type = /obj/item/clothing/suit/space/hardsuit/ert/med
	mask_type = /obj/item/clothing/mask/breath
	storage_type = /obj/item/tank/internals/emergency_oxygen/double

/obj/machinery/suit_storage_unit/radsuit
	name = "radiation suit storage unit"
	suit_type = /obj/item/clothing/suit/radiation
	helmet_type = /obj/item/clothing/head/radiation
	storage_type = /obj/item/geiger_counter

//SHIPTEST suits below

/obj/machinery/suit_storage_unit/solgov
	name = "solgov suit storage unit"
	suit_type = /obj/item/clothing/suit/space/solgov
	helmet_type = /obj/item/clothing/head/helmet/space/solgov
	mask_type = /obj/item/clothing/mask/breath
	storage_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/machinery/suit_storage_unit/frontiersmen
	name = "frontiersmen suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier
	storage_type = /obj/item/tank/jetpack/oxygen
	req_access = list(ACCESS_SECURITY)

LOCKED_SSU_HELPER(frontiersmen)

/obj/machinery/suit_storage_unit/independent/security
	name = "security suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/security/independent
	mask_type = /obj/item/clothing/mask/gas
	req_access = list(ACCESS_SECURITY)

LOCKED_SSU_HELPER(independent/security)

/obj/machinery/suit_storage_unit/independent/engineering
	name = "engineering suit storage unit"
	suit_type = /obj/item/clothing/suit/space/engineer
	helmet_type = /obj/item/clothing/head/helmet/space/light/engineer
	mask_type = /obj/item/clothing/mask/breath
	storage_type= /obj/item/clothing/shoes/magboots
	req_access = list(ACCESS_ENGINE)

LOCKED_SSU_HELPER(independent/engineering)

/obj/machinery/suit_storage_unit/independent/mining/eva
	name = "miner suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/mining/independent
	mask_type = /obj/item/clothing/mask/breath
	req_access = list(ACCESS_MINING)

LOCKED_SSU_HELPER(independent/mining/eva)

/obj/machinery/suit_storage_unit/independent/pilot
	suit_type = /obj/item/clothing/suit/space/pilot
	helmet_type = /obj/item/clothing/head/helmet/space/pilot/random
	mask_type = /obj/item/clothing/mask/breath

/obj/machinery/suit_storage_unit/minutemen
	name = "minuteman suit storage unit"
	suit_type = /obj/item/clothing/suit/space/hardsuit/clip_patroller
	mask_type = /obj/item/clothing/mask/gas/clip
	req_access = list(ACCESS_BRIG)

LOCKED_SSU_HELPER(minutemen)

/obj/machinery/suit_storage_unit/minutemen/spotter
	suit_type = /obj/item/clothing/suit/space/hardsuit/clip_spotter

LOCKED_SSU_HELPER(minutemen/spotter)

/obj/machinery/suit_storage_unit/minutemen/pilot
	suit_type = /obj/item/clothing/suit/space/pilot
	helmet_type = /obj/item/clothing/head/helmet/m10/clip_vc
	mask_type = /obj/item/clothing/mask/breath

LOCKED_SSU_HELPER(minutemen/pilot)

//End shiptest suits

/obj/machinery/suit_storage_unit/open
	state_open = TRUE
	density = FALSE

/obj/machinery/suit_storage_unit/Initialize(mapload)
	. = ..()
	wires = new /datum/wires/suit_storage_unit(src)
	src.check_access(null)
	if(req_access.len || req_one_access.len)
		electronics = new(src)
		if(req_access.len)
			electronics.accesses = req_access
		else
			electronics.one_access = 1
			electronics.accesses = req_one_access
		locked = TRUE //SSUs with access requirements start locked
	if(suit_type)
		suit = new suit_type(src)
	if(helmet_type)
		helmet = new helmet_type(src)
	if(mask_type)
		mask = new mask_type(src)
	if(mod_type)
		mod = new mod_type(src)
	if(storage_type)
		storage = new storage_type(src)
	update_appearance()

/obj/machinery/suit_storage_unit/examine(mob/user)
	. = ..()
	. += span_notice("Number of UV cycles reduced by <b>[lasers_bonus]</b>.")
	if(locked)
		. += span_notice("The locking bolts on \the [src] are engaged, preventing it from being pried open.")
	if(panel_open)
		if(electronics)
			. += span_notice("The airlock access electronics [locked ? "are securely locked in place" : "could be <b>pried</b> out."]")
		else
			. += span_notice("The airlock access electronics slot is open.")

/obj/machinery/suit_storage_unit/RefreshParts()
	lasers_bonus = 0
	for(var/obj/item/stock_parts/micro_laser/lasers in component_parts)
		lasers_bonus += ((lasers.rating) * 0.25)

	uv_cycles = BASE_UV_CYCLES - lasers_bonus

/obj/machinery/suit_storage_unit/Destroy()
	QDEL_NULL(suit)
	QDEL_NULL(helmet)
	QDEL_NULL(mask)
	QDEL_NULL(mod)
	QDEL_NULL(storage)
	return ..()

/obj/machinery/suit_storage_unit/update_overlays()
	. = ..()
	//if things arent powered, these show anyways
	if(panel_open)
		. += "[base_icon_state]_panel"
	if(state_open)
		. += "[base_icon_state]_open"
		if(suit || mod)
			. += "[base_icon_state]_suit"
		if(helmet)
			. += "[base_icon_state]_helm"
		if(storage)
			. += "[base_icon_state]_storage"
	if(!(machine_stat & BROKEN || machine_stat & NOPOWER))
		if(state_open)
			. += "[base_icon_state]_lights_open"
		else
			if(uv)
				if(uv_super)
					. += "[base_icon_state]_super"
				. += "[base_icon_state]_lights_red"
			else
				. += "[base_icon_state]_lights_closed"
		//top lights
		if(uv)
			if(uv_super)
				. += "[base_icon_state]_uvstrong"
			else
				. += "[base_icon_state]_uv"
		else if(locked)
			. += "[base_icon_state]_locked"
		else
			. += "[base_icon_state]_ready"


/obj/machinery/suit_storage_unit/power_change()
	. = ..()
	if(!is_operational && state_open)
		open_machine()
		dump_contents()
	update_appearance()

/obj/machinery/suit_storage_unit/dump_contents()
	dropContents()
	helmet = null
	suit = null
	mask = null
	mod = null
	storage = null
	occupant = null

/obj/machinery/suit_storage_unit/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		open_machine()
		dump_contents()
		on_deconstruction()
		if(circuit)
			circuit.forceMove(loc)
			circuit = null
		if(length(component_parts))
			spawn_frame(disassembled)
			for(var/obj/item/I in component_parts)
				I.forceMove(loc)
			component_parts.Cut()
	qdel(src)

/obj/machinery/suit_storage_unit/interact(mob/living/user)
	var/static/list/items

	if (!items)
		items = list(
			"suit" = create_silhouette_of(/obj/item/clothing/suit/space/eva),
			"helmet" = create_silhouette_of(/obj/item/clothing/head/helmet/space/eva),
			"mask" = create_silhouette_of(/obj/item/clothing/mask/breath),
			"mod" = create_silhouette_of(/obj/item/mod/control),
			"storage" = create_silhouette_of(/obj/item/tank/internals/oxygen),
		)

	. = ..()
	if (.)
		return

	if (!check_interactable(user))
		return

	var/list/choices = list()

	if (locked)
		choices["unlock"] = icon('icons/mob/radial.dmi', "radial_unlock")
	else if (state_open)
		choices["close"] = icon('icons/mob/radial.dmi', "radial_close")

		for (var/item_key in items)
			var/item = vars[item_key]
			if (item)
				choices[item_key] = item
			else
				// If the item doesn't exist, put a silhouette in its place
				choices[item_key] = items[item_key]
	else
		choices["open"] = icon('icons/mob/radial.dmi', "radial_open")
		choices["disinfect"] = icon('icons/mob/radial.dmi', "radial_disinfect")
		choices["lock"] = icon('icons/mob/radial.dmi', "radial_lock")

	var/choice = show_radial_menu(
		user,
		src,
		choices,
		custom_check = CALLBACK(src, PROC_REF(check_interactable), user),
		require_near = !issilicon(user),
	)

	if (!choice)
		return

	switch (choice)
		if ("open")
			if (!state_open)
				open_machine(drop = FALSE)
				if (occupant)
					dump_contents()
		if ("close")
			if (state_open)
				close_machine()
		if ("disinfect")
			if (occupant && safeties)
				say("Alert: safeties triggered, occupant detected!")
				return
			else if (!helmet && !mask && !suit && !storage && !occupant)
				to_chat(user, span_notice("There's nothing inside [src] to disinfect!"))
				return
			else
				if (occupant)
					var/mob/living/mob_occupant = occupant
					to_chat(mob_occupant, span_userdanger("[src]'s confines grow warm, then hot, then scorching. You're being burned [!mob_occupant.stat ? "alive" : "away"]!"))
				cook()
		if ("lock", "unlock")
			if(!electronics)
				to_chat(user, span_warning("You can't cycle the lock on \the [src] without an airlock circuit installed!"))
			if(!lock_functional)
				to_chat(user, span_warning("The locking mechanism is shorted out!"))
			else if (!state_open)
				if(allowed(user))
					locked = !locked
					update_icon()
				else
					to_chat(user, span_warning("Insufficent access."))
		else
			var/obj/item/item_to_dispense = vars[choice]
			if (item_to_dispense)
				vars[choice] = null
				try_put_in_hand(item_to_dispense, user)
				update_appearance()
			else
				var/obj/item/in_hands = user.get_active_held_item()
				if (in_hands)
					attackby(in_hands, user)
				update_appearance()

	interact(user)

/obj/machinery/suit_storage_unit/proc/check_interactable(mob/user)
	if (!state_open && !can_interact(user))
		return FALSE

	if (panel_open)
		return FALSE

	if (uv)
		return FALSE

	return TRUE

/obj/machinery/suit_storage_unit/proc/create_silhouette_of(atom/item)
	var/image/image = image(initial(item.icon), initial(item.icon_state))
	image.alpha = 128
	image.color = COLOR_RED
	return image

/obj/machinery/suit_storage_unit/MouseDrop_T(atom/A, mob/living/user)
	if(!istype(user) || user.stat || !Adjacent(user) || !Adjacent(A) || !isliving(A))
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.body_position == LYING_DOWN)
			return
	var/mob/living/target = A
	if(!state_open)
		to_chat(user, span_warning("The unit's doors are shut!"))
		return
	if(!is_operational)
		to_chat(user, span_warning("The unit is not operational!"))
		return
	if(occupant || helmet || suit || mod || storage)
		to_chat(user, span_warning("It's too cluttered inside to fit in!"))
		return

	if(target == user)
		user.visible_message(span_warning("[user] starts squeezing into [src]!"), span_notice("You start working your way into [src]..."))
	else
		target.visible_message(span_warning("[user] starts shoving [target] into [src]!"), span_userdanger("[user] starts shoving you into [src]!"))

	if(do_after(user, 30, target))
		if(occupant || helmet || suit || mod || storage)
			return
		if(target == user)
			user.visible_message(span_warning("[user] slips into [src] and closes the door behind [user.p_them()]!"), span_notice("You slip into [src]'s cramped space and shut its door."))
		else
			target.visible_message(span_warning("[user] pushes [target] into [src] and shuts its door!"), span_userdanger("[user] shoves you into [src] and shuts the door!"))
		close_machine(target)
		add_fingerprint(user)

/**
 * UV decontamination sequence.
 * Duration is determined by the uv_cycles var.
 * Effects determined by the uv_super var.
 * * If FALSE, all atoms (and their contents) contained are cleared of radiation. If a mob is inside, they are burned every cycle.
 * * If TRUE, all items contained are destroyed, and burn damage applied to the mob is increased. All wires will be cut at the end.
 * All atoms still inside at the end of all cycles are ejected from the unit.
*/
/obj/machinery/suit_storage_unit/proc/cook()
	var/mob/living/mob_occupant = occupant
	if(uv_cycles > 0)
		uv_cycles--
		uv = TRUE
		locked = TRUE
		update_appearance()
		use_power(ACTIVE_DRAW_HIGH)
		if(occupant)
			if(uv_super)
				mob_occupant.adjustFireLoss(rand(20, 36))
			else
				mob_occupant.adjustFireLoss(rand(10, 16))
			mob_occupant.force_scream()
		addtimer(CALLBACK(src, PROC_REF(cook)), 50)
	else
		uv_cycles = (BASE_UV_CYCLES - lasers_bonus)
		uv = FALSE
		locked = FALSE
		if(uv_super)
			visible_message(span_warning("[src]'s door creaks open with a loud whining noise. A cloud of foul black smoke escapes from its chamber."))
			playsound(src, 'sound/machines/creaking.ogg', 50, TRUE)
			helmet = null
			qdel(helmet)
			suit = null
			qdel(suit) // Delete everything but the occupant.
			mask = null
			qdel(mask)
			mod = null
			qdel(mod)
			storage = null
			qdel(storage)
			// The wires get damaged too.
			wires.cut_all()
		else
			if(!occupant)
				visible_message(span_notice("[src]'s door slides open. The glowing yellow lights dim to a gentle green."))
			else
				visible_message(span_warning("[src]'s door slides open, barraging you with the nauseating smell of charred flesh."))
				mob_occupant.radiation = 0
			playsound(src, 'sound/machines/airlocks/standard/close.ogg', 25, TRUE)
			var/list/things_to_clear = list() //Done this way since using GetAllContents on the SSU itself would include circuitry and such.
			if(suit)
				things_to_clear += suit
				things_to_clear += suit.GetAllContents()
			if(helmet)
				things_to_clear += helmet
				things_to_clear += helmet.GetAllContents()
			if(mask)
				things_to_clear += mask
				things_to_clear += mask.GetAllContents()
			if(mod)
				things_to_clear += mod
				things_to_clear += mod.GetAllContents()
			if(storage)
				things_to_clear += storage
				things_to_clear += storage.GetAllContents()
			if(occupant)
				things_to_clear += occupant
				things_to_clear += occupant.GetAllContents()
			for(var/am in things_to_clear) //Scorches away blood and forensic evidence, although the SSU itself is unaffected
				var/atom/movable/dirty_movable = am
				dirty_movable.wash(CLEAN_ALL)
		open_machine(FALSE)
		if(occupant)
			dump_contents()

/obj/machinery/suit_storage_unit/proc/shock(mob/user, prb)
	if(!prob(prb))
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(5, 1, src)
		s.start()
		if(electrocute_mob(user, src, src, 1, TRUE))
			return 1

/obj/machinery/suit_storage_unit/relaymove(mob/living/user, direction)
	if(locked)
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, span_warning("[src]'s door won't budge!"))
		return
	open_machine()
	dump_contents()

/obj/machinery/suit_storage_unit/container_resist_act(mob/living/user)
	if(!locked)
		open_machine()
		dump_contents()
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("You see [user] kicking against the doors of [src]!"), \
		span_notice("You start kicking against the doors... (this will take about [DisplayTimeText(breakout_time)].)"), \
		span_hear("You hear a thump from [src]."))
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src)
			return
		user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
			span_notice("You successfully break out of [src]!"))
		open_machine()
		dump_contents()

	add_fingerprint(user)
	if(locked)
		visible_message(span_notice("You see [user] kicking against the doors of [src]!"), \
			span_notice("You start kicking against the doors..."))
		addtimer(CALLBACK(src, PROC_REF(resist_open), user), 300)
	else
		open_machine()
		dump_contents()

/obj/machinery/suit_storage_unit/proc/resist_open(mob/user)
	if(!state_open && occupant && (user in src) && user.stat == 0) // Check they're still here.
		visible_message(span_notice("You see [user] burst out of [src]!"), \
			span_notice("You escape the cramped confines of [src]!"))
		open_machine()

/obj/machinery/suit_storage_unit/attackby(obj/item/I, mob/user, params)
	if(state_open && is_operational)
		if(istype(I, /obj/item/clothing/suit))
			if(suit)
				to_chat(user, span_warning("The unit already contains a suit!."))
				return
			if(!user.transferItemToLoc(I, src))
				return
			suit = I
		else if(istype(I, /obj/item/clothing/head))
			if(helmet)
				to_chat(user, span_warning("The unit already contains a helmet!"))
				return
			if(!user.transferItemToLoc(I, src))
				return
			helmet = I
		else if(istype(I, /obj/item/clothing/mask))
			if(mask)
				to_chat(user, span_warning("The unit already contains a mask!"))
				return
			if(!user.transferItemToLoc(I, src))
				return
			mask = I
		else if(istype(I, /obj/item/mod/control))
			if(mod)
				to_chat(user, span_warning("The unit already contains a MOD!"))
				return
			if(!user.transferItemToLoc(I, src))
				return
			mod = I
		else
			if(storage)
				to_chat(user, span_warning("The auxiliary storage compartment is full!"))
				return
			if(!user.transferItemToLoc(I, src))
				return
			storage = I

		visible_message(span_notice("[user] inserts [I] into [src]"), span_notice("You load [I] into [src]."))
		update_appearance()
		return

	if(panel_open && is_wire_tool(I))
		wires.interact(user)
		return
	if(panel_open && electronics && I.tool_behaviour == TOOL_CROWBAR)
		if(locked)
			to_chat(user,span_warning("You can't remove the airlock electronics while the lock is engaged!"))
			return
		var/obj/item/electronics/airlock/ae = electronics
		gen_access()
		ae = electronics
		electronics = null
		ae.forceMove(drop_location())
		return
	if(panel_open && istype(I, /obj/item/electronics/airlock))
		if(electronics)
			to_chat(user,span_warning("The [src] already has an airlock electronic installed!"))
			return
		else
			if(!user.transferItemToLoc(I, src))
				to_chat(user, span_warning("\The [I] is stuck to you!"))
				return
			electronics = I
			if(electronics.one_access)
				req_one_access = electronics.accesses
			else
				req_access = electronics.accesses
	if(!state_open)
		if(default_deconstruction_screwdriver(user, "[base_icon_state]", "[base_icon_state]", I))
			update_appearance()
			return
	if(default_pry_open(I))
		dump_contents()
		return

	return ..()

/*	ref tg-git issue #45036
	screwdriving it open while it's running a decontamination sequence without closing the panel prior to finish
	causes the SSU to break due to state_open being set to TRUE at the end, and the panel becoming inaccessible.
*/
/obj/machinery/suit_storage_unit/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/I)
	if(!(flags_1 & NODECONSTRUCT_1) && I.tool_behaviour == TOOL_SCREWDRIVER && uv)
		to_chat(user, span_warning("It might not be wise to fiddle with [src] while it's running..."))
		return TRUE
	return ..()


/obj/machinery/suit_storage_unit/default_pry_open(obj/item/I)//needs to check if the storage is locked.
	. = !(state_open || panel_open || is_operational || locked || (flags_1 & NODECONSTRUCT_1)) && I.tool_behaviour == TOOL_CROWBAR
	if(.)
		I.play_tool_sound(src, 50)
		visible_message(span_notice("[usr] pries open \the [src]."), span_notice("You pry open \the [src]."))
		open_machine()
	// todo, make it not deconstruct while locked
	if(!locked)
		if(default_deconstruction_crowbar(I))
			return TRUE

// Mapping helper unit takes whatever lies on top of it
/obj/machinery/suit_storage_unit/inherit/Initialize(mapload)
	. = ..()
	if(mapload)
		return INITIALIZE_HINT_LATELOAD

/obj/machinery/suit_storage_unit/inherit/LateInitialize()
	. = ..()
	var/turf/T = src.loc
	for(var/atom/movable/AM in T)
		if(istype(AM, /obj/item/clothing/suit/space) && !suit)
			AM.forceMove(src)
			suit = AM
		else if(istype(AM, /obj/item/clothing/head/helmet/space) && !helmet)
			AM.forceMove(src)
			helmet = AM
		else if(istype(AM, /obj/item/clothing/mask) && !mask)
			AM.forceMove(src)
			mask = AM
		else if(istype(AM, /obj/item/mod/control) && !storage)
			AM.forceMove(src)
			mod = AM
		else if(istype(AM, /obj/item) && !AM.anchored && !storage)
			AM.forceMove(src)
			storage = AM
	update_appearance()


#undef BASE_UV_CYCLES
