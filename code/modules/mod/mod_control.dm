/// MODsuits
/obj/item/mod
	name = "Base MOD"
	desc = "You should not see this, yell at a coder!"
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'

/obj/item/mod/control
	name = "MOD control unit"
	desc = "The control unit of a Modular Outerwear Device, a powered suit that protects against various environments."
	icon_state = "control"
	base_icon_state = "control"
	item_state = "mod_control"
	mob_overlay_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	strip_delay = 10 SECONDS
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)
	actions_types = list(
		/datum/action/item_action/mod/deploy,
		/datum/action/item_action/mod/activate,
		/datum/action/item_action/mod/panel,
		/datum/action/item_action/mod/module,
		/datum/action/item_action/mod/deploy/ai,
		/datum/action/item_action/mod/activate/ai,
		/datum/action/item_action/mod/panel/ai,
		/datum/action/item_action/mod/module/ai,
	)
	resistance_flags = NONE
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	siemens_coefficient = 0.5
	//alternate_worn_layer = HAND_LAYER+0.1 //we want it to go above generally everything, but not hands
	/// The MOD's theme, decides on some stuff like armor and statistics.

	var/datum/mod_theme/theme = /datum/mod_theme
	/// Looks of the MOD.
	var/skin = "standard"
	/// Theme of the MOD TGUI
	var/ui_theme = "ntos"
	/// If the suit is deployed and turned on.
	var/active = FALSE
	/// If the suit wire/module hatch is open.
	var/open = FALSE
	/// If the suit is ID locked.
	var/locked = FALSE
	/// If the suit is malfunctioning.
	var/malfunctioning = FALSE
	/// If the suit is currently activating/deactivating.
	var/activating = FALSE
	/// How long the MOD is electrified for.
	var/seconds_electrified = MACHINE_NOT_ELECTRIFIED
	/// If the suit interface is broken.
	var/interface_break = FALSE
	/// How much module complexity can this MOD carry.
	var/complexity_max = DEFAULT_MAX_COMPLEXITY
	/// How much module complexity this MOD is carrying.
	var/complexity = 0
	/// Power usage of the MOD.
	var/charge_drain = DEFAULT_CHARGE_DRAIN
	/// Slowdown of the MOD when not active.
	var/slowdown_inactive = 1.25
	/// Slowdown of the MOD when active.
	var/slowdown_active = 0.75
	/// How long this MOD takes each part to seal.
	var/activation_step_time = MOD_ACTIVATION_STEP_TIME
	/// Extended description of the theme.
	var/extended_desc
	/// MOD core.
	var/obj/item/mod/core/core
	/// List of MODsuit part datums.
	var/list/mod_parts = list()
	/// Modules the MOD should spawn with.
	var/list/initial_modules = list()
	/// Modules the MOD currently possesses.
	var/list/modules = list()
	/// Currently used module.
	var/obj/item/mod/module/selected_module
	/// AI mob inhabiting the MOD.
	var/mob/living/silicon/ai/ai
	/// Delay between moves as AI.
	var/movedelay = 0
	/// Cooldown for AI moves.
	COOLDOWN_DECLARE(cooldown_mod_move)
	/// Person wearing the MODsuit.
	var/mob/living/carbon/human/wearer

	equipping_sound = EQUIP_SOUND_VFAST_GENERIC
	unequipping_sound = UNEQUIP_SOUND_VFAST_GENERIC
	equip_delay_self = EQUIP_DELAY_BACK
	equip_delay_other = EQUIP_DELAY_BACK * 1.5
	strip_delay = EQUIP_DELAY_BACK * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT | EQUIP_SLOWDOWN

/obj/item/mod/control/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	if(new_theme)
		theme = new_theme
	theme = GLOB.mod_themes[theme]
	theme.set_up_parts(src, new_skin)
	for(var/obj/item/part as anything in get_parts())
		RegisterSignal(part, COMSIG_ATOM_DESTRUCTION, PROC_REF(on_part_destruction))
		// RegisterSignal(part, COMSIG_QDELETING, PROC_REF(on_part_deletion))
	wires = new /datum/wires/mod(src)
	if(length(req_access))
		locked = TRUE
	new_core?.install(src)
	update_speed()
	RegisterSignal(src, COMSIG_ATOM_EXITED, PROC_REF(on_exit))
	for(var/obj/item/mod/module/module as anything in initial_modules)
		module = new module(src)
		install(module)

/obj/item/mod/control/Destroy()
	if(active)
		STOP_PROCESSING(SSobj, src)
	for(var/obj/item/mod/module/module as anything in modules)
		uninstall(module, deleting = TRUE)
	if(core)
		QDEL_NULL(core)
	QDEL_NULL(wires)
	for(var/datum/mod_part/part_datum as anything in get_part_datums(all = TRUE))
		part_datum.part_item = null
		part_datum.overslotting = null
	return ..()

/obj/item/mod/control/atom_destruction(damage_flag)
	if(wearer)
		wearer.visible_message(
			span_danger("[src] fall[p_s()] apart, completely destroyed!"), vision_distance = COMBAT_MESSAGE_RANGE,
		)
		clean_up()
	for(var/obj/item/mod/module/module as anything in modules)
		uninstall(module)
	/*if(ai)
		ai.controlled_equipment = null
		ai.remote_control = null
		for(var/datum/action/action as anything in actions)
			if(action.owner == ai)
				action.Remove(ai)
		new /obj/item/mod/ai_minicard(drop_location(), ai)*/
	return ..()

/obj/item/mod/control/examine(mob/user)
	. = ..()
	if(active)
		. += span_notice("Charge: [core ? "[get_charge_percent()]%" : "No core"].")
		. += span_notice("Selected module: [selected_module || "None"].")
	if(!open && !active)
		if(!wearer)
			. += span_notice("You could equip it to turn it on.")
		. += span_notice("You could open the cover with a <b>screwdriver</b>.")
	else if(open)
		. += span_notice("You could close the cover with a <b>screwdriver</b>.")
		. += span_notice("You could use <b>modules</b> on it to install them.")
		. += span_notice("You could remove modules with a <b>crowbar</b>.")
		. += span_notice("You could update the access lock with an <b>ID</b>.")
		. += span_notice("You could access the wire panel with a <b>wire tool</b>.")
		if(core)
			. += span_notice("You could remove [core] with a <b>wrench</b>.")
		else
			. += span_notice("You could use a <b>MOD core</b> on it to install one.")
		if(ai)
			. += span_notice("You could remove [ai] with an <b>intellicard</b>.")
		else
			. += span_notice("You could install an AI with an <b>intellicard</b>.")
	. += span_notice("You could <b>ctrl-click<b> the [src] to quick activate or deactivate the suit.")

/obj/item/mod/control/examine_more(mob/user)
	. = ..()
	if(extended_desc)
		. += "<i>[extended_desc]</i>"

/obj/item/mod/control/process(seconds_per_tick)
	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--
	if(!get_charge() && active && !activating)
		power_off()
		return PROCESS_KILL
	var/malfunctioning_charge_drain = 0
	if(malfunctioning)
		malfunctioning_charge_drain = rand(1,20)
	subtract_charge((charge_drain + malfunctioning_charge_drain)*seconds_per_tick)
	update_charge_alert()
	for(var/obj/item/mod/module/module as anything in modules)
		if(malfunctioning && module.active && SPT_PROB(5, seconds_per_tick))
			module.deactivate(display_message = TRUE)
		module.on_process(seconds_per_tick)

/obj/item/mod/control/visual_equipped(mob/user, slot, initial = FALSE) //needs to be visual because we wanna show it in select equipment
	..()
	if(slot == slot_flags)
		set_wearer(user)
	else if(wearer)
		unset_wearer()

/obj/item/mod/control/dropped(mob/user)
	. = ..()
	if(!wearer)
		return
	clean_up()

/obj/item/mod/control/item_action_slot_check(slot)
	if(slot & slot_flags)
		return TRUE

/obj/item/mod/control/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(!wearer || old_loc != wearer || loc == wearer)
		return
	clean_up()

/obj/item/mod/control/allow_attack_hand_drop(mob/user)
	if(user != wearer)
		return ..()
	for(var/obj/item/part as anything in get_parts())
		if(part.loc != src)
			to_chat(user,span_warning("Retract parts first!"))
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, FALSE, SILENCED_SOUND_EXTRARANGE)
			return FALSE

/obj/item/mod/control/MouseDrop(atom/over_object)
	if(usr != wearer || !istype(over_object, /atom/movable/screen/inventory/hand))
		return ..()
	for(var/obj/item/part as anything in get_parts())
		if(part.loc != src)
			to_chat(wearer,span_warning("Retract parts first!"))
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, FALSE, SILENCED_SOUND_EXTRARANGE)
			return
	if(!wearer.incapacitated())
		var/atom/movable/screen/inventory/hand/ui_hand = over_object
		if(wearer.putItemFromInventoryInHandIfPossible(src, ui_hand.held_index, FALSE, TRUE))
			add_fingerprint(usr)
			return ..()

/obj/item/mod/control/wrench_act(mob/living/user, obj/item/wrench)
	if(..())
		return TRUE
	if(seconds_electrified && get_charge() && shock(user))
		return TRUE
	if(open)
		if(!core)
			to_chat(user,span_warning("No core installed!!"))
			return TRUE
		wrench.play_tool_sound(src, 100)
		to_chat(user,span_notice("You begin removing the mod core..."))
		if(!wrench.use_tool(src, user, 3 SECONDS) || !open)
			return TRUE
		wrench.play_tool_sound(src, 100)
		to_chat(user,span_warning("You remove the core."))
		core.forceMove(drop_location())
		update_charge_alert()
		return TRUE
	return ..()

/obj/item/mod/control/screwdriver_act(mob/living/user, obj/item/screwdriver)
	if(..())
		return TRUE
	if(active || activating)// || ai_controller)
		to_chat(user,span_warning("Deactivate the suit first!"))
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	to_chat(user,span_notice("You begin [open ? "closing" : "opening"] the cover..."))
	screwdriver.play_tool_sound(src, 100)
	if(screwdriver.use_tool(src, user, 1 SECONDS))
		if(active || activating)
			to_chat(user,span_warning("Deactivate the suit first!"))
		screwdriver.play_tool_sound(src, 100)
		to_chat(user, span_notice("You [open ? "close" : "open"] the cover"))
		open = !open
	return TRUE

/obj/item/mod/control/crowbar_act(mob/living/user, obj/item/crowbar)
	. = ..()
	if(!open)
		to_chat(user, span_warning("Open the cover first!"))
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	if(!allowed(user))
		to_chat(user, span_warning("Insufficient access!"))
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	if(SEND_SIGNAL(src, COMSIG_MOD_MODULE_REMOVAL, user) & MOD_CANCEL_REMOVAL)
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	if(length(modules))
		var/list/removable_modules = list()
		for(var/obj/item/mod/module/module as anything in modules)
			if(!module.removable)
				continue
			removable_modules += module
		var/obj/item/mod/module/module_to_remove = tgui_input_list(user, "Which module to remove?", "Module Removal", removable_modules)
		if(!module_to_remove?.mod)
			return FALSE
		uninstall(module_to_remove)
		module_to_remove.forceMove(drop_location())
		crowbar.play_tool_sound(src, 100)
		return TRUE
	to_chat(user, span_warning( "The [src] doesn't have any modules to remove!"))
	playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
	return FALSE

/obj/item/mod/control/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/mod/module))
		if(!open)
			to_chat(user, span_warning("Open the cover first!"))
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return FALSE
		install(attacking_item, user)
		return TRUE
	else if(istype(attacking_item, /obj/item/mod/core))
		if(!open)
			to_chat(user, span_warning("Open the cover first!"))
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return FALSE
		if(core)
			to_chat(user, span_warning("Core already installed!"))
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return FALSE
		var/obj/item/mod/core/attacking_core = attacking_item
		attacking_core.install(src)
		to_chat(user, span_notice("You install the [attacking_core]."))
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		update_charge_alert()
		return TRUE
	else if(is_wire_tool(attacking_item) && open)
		wires.interact(user)
		return TRUE
	else if(open && attacking_item.GetID())
		update_access(user, attacking_item.GetID())
		return TRUE
	else if(open && istype(attacking_item, /obj/item/stock_parts/cell) && istype(core, /obj/item/mod/core/standard))
		var/obj/item/mod/core/standard/attacked_core = core
		attacked_core.on_attackby(src, attacking_item, wearer)
		return TRUE
	return ..()

/obj/item/mod/control/get_cell()
	if(!open)
		return
	var/obj/item/stock_parts/cell/cell = get_charge_source()
	if(!istype(cell))
		return
	return cell

/obj/item/mod/control/GetAccess()
	/*if(ai_controller)
		return req_access.Copy()
	else */
		return ..()

/obj/item/mod/control/emag_act(mob/user)
	locked = !locked
	to_chat(user, span_warning( "Suit access [locked ? "locked" : "unlocked"]"))

/obj/item/mod/control/emp_act(severity)
	. = ..()
	if(!active || !wearer)
		return
	to_chat(wearer, span_notice("[severity > 1 ? "Light" : "Strong"] electromagnetic pulse detected!"))
	if(. & EMP_PROTECT_CONTENTS)
		return
	selected_module?.deactivate(display_message = TRUE)
	wearer.apply_damage(3 / severity, BURN, spread_damage=TRUE)
	to_chat(wearer, span_danger("You feel [src] heat up from the EMP, burning you slightly."))

// /obj/item/mod/control/on_outfit_equip(mob/living/carbon/human/outfit_wearer, visuals_only, item_slot) todo add/fix
// 	. = ..()
// 	quick_activation()

/obj/item/mod/control/doStrip(mob/stripper, mob/owner)
	if(active && !toggle_activate(stripper, force_deactivate = TRUE))
		return
	for(var/obj/item/part as anything in get_parts())
		if(part.loc == src)
			continue
		retract(null, part)
	return ..()

/obj/item/mod/control/worn_overlays(isinhands = FALSE, icon_file)
	. = ..()
	for(var/obj/item/mod/module/module as anything in modules)
		var/list/module_icons = module.generate_worn_overlay(src.layer)
		if(!length(module_icons))
			continue
		. += module_icons

/obj/item/mod/control/update_icon_state()
	item_state = "[skin]-control[active ? "-sealed" : ""]"
	return ..()

/obj/item/mod/control/proc/get_parts(all = FALSE)
	. = list()
	for(var/key in mod_parts)
		var/datum/mod_part/part = mod_parts[key]
		if(!all && part.part_item == src)
			continue
		. += part.part_item

/obj/item/mod/control/proc/get_part_datums(all = FALSE)
	. = list()
	for(var/key in mod_parts)
		var/datum/mod_part/part = mod_parts[key]
		if(!all && part.part_item == src)
			continue
		. += part

/obj/item/mod/control/proc/get_part_datum(obj/item/part)
	RETURN_TYPE(/datum/mod_part)
	var/datum/mod_part/potential_part = mod_parts["[part.slot_flags]"]
	if(potential_part?.part_item == part)
		return potential_part
	for(var/datum/mod_part/mod_part in get_part_datums())
		if(mod_part.part_item == part)
			return mod_part
	CRASH("get_part_datum called with incorrect item [part] passed.")

/obj/item/mod/control/proc/get_part_from_slot(slot)
	slot = "[slot]"
	for(var/part_slot in mod_parts)
		if(slot != part_slot)
			continue
		var/datum/mod_part/part = mod_parts[part_slot]
		return part.part_item

/obj/item/mod/control/proc/set_wearer(mob/living/carbon/human/user)
	if(wearer == user)
		CRASH("set_wearer() was called with the new wearer being the current wearer: [wearer]")
	else if(!isnull(wearer))
		stack_trace("set_wearer() was called with a new wearer without unset_wearer() being called")

	wearer = user
	SEND_SIGNAL(src, COMSIG_MOD_WEARER_SET, wearer)
	RegisterSignal(wearer, COMSIG_ATOM_EXITED, PROC_REF(on_exit))
	RegisterSignal(wearer, COMSIG_SPECIES_GAIN, PROC_REF(on_species_gain))
	update_charge_alert()
	for(var/obj/item/mod/module/module as anything in modules)
		module.on_equip()

/obj/item/mod/control/proc/unset_wearer()
	for(var/obj/item/mod/module/module as anything in modules)
		module.on_unequip()
	UnregisterSignal(wearer, list(COMSIG_ATOM_EXITED, COMSIG_SPECIES_GAIN))
	wearer.clear_alert("mod_charge")
	SEND_SIGNAL(src, COMSIG_MOD_WEARER_UNSET, wearer)
	wearer = null

/obj/item/mod/control/proc/clean_up()
	if(QDELING(src))
		unset_wearer()
		return

	if(active || activating)
		for(var/obj/item/mod/module/module as anything in modules)
			if(!module.active)
				continue
			module.deactivate(display_message = FALSE)
		for(var/obj/item/part as anything in get_parts())
			seal_part(part, is_sealed = FALSE)
	for(var/obj/item/part as anything in get_parts())
		retract(null, part)
	if(active)
		finish_activation(is_on = FALSE)
	var/mob/old_wearer = wearer
	unset_wearer()
	old_wearer.temporarilyRemoveItemFromInventory(src)

/obj/item/mod/control/proc/on_species_gain(datum/source, datum/species/new_species, datum/species/old_species)
	SIGNAL_HANDLER

	for(var/obj/item/part in get_parts(all = TRUE))
		if(!(part.slot_flags in new_species.no_equip) || is_type_in_list(new_species, part.species_exception))
			continue
		forceMove(drop_location())
		return

/obj/item/mod/control/proc/quick_module(mob/user)
	if(!length(modules))
		return
	var/list/display_names = list()
	var/list/items = list()
	for(var/obj/item/mod/module/module as anything in modules)
		if(module.module_type == MODULE_PASSIVE)
			continue
		display_names[module.name] = REF(module)
		var/image/module_image = image(icon = module.icon, icon_state = module.icon_state)
		if(module == selected_module)
			module_image.underlays += image(icon = 'icons/hud/radial.dmi', icon_state = "module_selected")
		else if(module.active)
			module_image.underlays += image(icon = 'icons/hud/radial.dmi', icon_state = "module_active")
		if(!COOLDOWN_FINISHED(module, cooldown_timer))
			module_image.add_overlay(image(icon = 'icons/hud/radial.dmi', icon_state = "module_cooldown"))
		items += list(module.name = module_image)
	if(!length(items))
		return
	var/radial_anchor = src
	if(istype(user.loc, /obj/effect/dummy/phased_mob))
		radial_anchor = get_turf(user.loc) //they're phased out via some module, anchor the radial on the turf so it may still display
	var/pick = show_radial_menu(user, radial_anchor, items, custom_check = FALSE, require_near = TRUE, tooltips = TRUE)
	if(!pick)
		return
	var/module_reference = display_names[pick]
	var/obj/item/mod/module/picked_module = locate(module_reference) in modules
	if(!istype(picked_module))
		return
	picked_module.on_select()

/obj/item/mod/control/proc/shock(mob/living/user)
	if(!istype(user) || get_charge() < 1)
		return FALSE
	do_sparks(5, TRUE, src)
	var/check_range = TRUE
	return electrocute_mob(user, get_charge_source(), src, 0.7, check_range)

/obj/item/mod/control/proc/install(obj/item/mod/module/new_module, mob/user)
	for(var/obj/item/mod/module/old_module as anything in modules)
		if(is_type_in_list(new_module, old_module.incompatible_modules) || is_type_in_list(old_module, new_module.incompatible_modules))
			if(user)
				to_chat(user, span_warning("\The [new_module] is incompatible with [old_module]!"))
				playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return
	if(is_type_in_list(new_module, theme.module_blacklist))
		if(user)
			to_chat(user, span_warning("\The [src] doesn't accept [new_module]!"))
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	var/complexity_with_module = complexity
	complexity_with_module += new_module.complexity
	if(complexity_with_module > complexity_max)
		if(user)
			to_chat(user, span_warning("\The [new_module] would make [src] too complex!"))
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	if(!new_module.has_required_parts(mod_parts))
		if(user)
			to_chat(user, span_warning("\The [new_module] would make [src] too complex!"))
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	new_module.forceMove(src)
	modules += new_module
	complexity += new_module.complexity
	new_module.mod = src
	new_module.on_install()
	if(wearer)
		new_module.on_equip()

	if(user)
		to_chat(user, span_notice("You add \the [new_module] to \the [src]"))
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)

/obj/item/mod/control/proc/uninstall(obj/item/mod/module/old_module, deleting = FALSE)
	modules -= old_module
	complexity -= old_module.complexity
	if(active)
		old_module.on_suit_deactivation(deleting = deleting)
		if(old_module.active)
			old_module.deactivate(display_message = !deleting, deleting = deleting)
	old_module.on_uninstall(deleting = deleting)
	QDEL_LIST_ASSOC_VAL(old_module.pinned_to)
	old_module.mod = null

/// Intended for callbacks, don't use normally, just get wearer by itself.
/obj/item/mod/control/proc/get_wearer()
	return wearer

/obj/item/mod/control/proc/update_access(mob/user, obj/item/card/id/card)
	if(!allowed(user))
		to_chat(user, span_warning( "Insufficient access!"))
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	req_access = card.access.Copy()
	to_chat(user, span_warning("You update the access credentials on \the [src]."))

/obj/item/mod/control/proc/get_charge_source()
	return core?.charge_source()

/obj/item/mod/control/proc/get_charge()
	return core?.charge_amount() || 0

/obj/item/mod/control/proc/get_max_charge()
	return core?.max_charge_amount() || 1 //avoid dividing by 0

/obj/item/mod/control/proc/get_charge_percent()
	return ROUND_UP((get_charge() / get_max_charge()) * 100)

/obj/item/mod/control/proc/add_charge(amount)
	return core?.add_charge(amount) || FALSE

/obj/item/mod/control/proc/subtract_charge(amount)
	return core?.subtract_charge(amount) || FALSE

/obj/item/mod/control/proc/check_charge(amount)
	return core?.check_charge(amount) || FALSE

/obj/item/mod/control/proc/update_charge_alert()
	if(!wearer)
		return
	if(!core)
		wearer.throw_alert("mod_charge", /atom/movable/screen/alert/nocore)
		return
	core.update_charge_alert()

/obj/item/mod/control/proc/update_speed()
	for(var/obj/item/part as anything in get_parts(all = TRUE))
		part.slowdown = (active ? slowdown_active : slowdown_inactive) / length(mod_parts)
	wearer?.update_equipment_speed_mods()

/obj/item/mod/control/proc/power_off()
	toggle_activate(wearer, force_deactivate = TRUE)

/obj/item/mod/control/proc/set_mod_color(new_color)
	for(var/obj/item/part as anything in get_parts(all = TRUE))
		part.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
		part.add_atom_colour(new_color, FIXED_COLOUR_PRIORITY)
	wearer?.regenerate_icons()

/obj/item/mod/control/proc/on_exit(datum/source, atom/movable/part, direction)
	SIGNAL_HANDLER

	if(part.loc == src)
		return
	if(part == core)
		core.uninstall()
		update_charge_alert()
		return
	if(part.loc == wearer)
		return
	if(part in modules)
		uninstall(part)
		return
	if(part in get_parts())
		if(isnull(part.loc))
			return
		if(!wearer)
			part.forceMove(src)
			return
		retract(wearer, part)
		if(active)
			INVOKE_ASYNC(src, PROC_REF(toggle_activate), wearer, TRUE)

/obj/item/mod/control/proc/on_part_destruction(obj/item/part, damage_flag)
	SIGNAL_HANDLER

	if(QDELING(src))
		return
	atom_destruction(damage_flag)

/obj/item/mod/control/proc/on_part_deletion(obj/item/part)
	SIGNAL_HANDLER

	if(QDELING(src))
		return
	qdel(src)

/obj/item/mod/control/proc/on_overslot_exit(obj/item/part, atom/movable/overslot, direction)
	SIGNAL_HANDLER

	var/datum/mod_part/part_datum = get_part_datum(part)
	if(overslot != part_datum.overslotting)
		return
	part_datum.overslotting = null


