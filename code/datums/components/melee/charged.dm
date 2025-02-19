/*
 * Charged weapon component. For weapons that swap between states but require a cell for function.
 * For example: Stun batons.
 *
 * Used to easily make an item that can be attack_self'd to gain force or change mode.
 *
 * Only values passed on initialize will update when the item is activated (except the icon_state).
 * The icon_state of the item will swap between "[icon_state]" and "[icon_state]_on".
 */
/datum/component/transforming/charged
	var/obj/item/stock_parts/cell/cell
	var/allowed_cells
	var/preload_cell_type
	var/cell_hit_cost
	var/can_remove_cell
	var/no_cell_icon

/datum/component/transforming/charged/Initialize(
	start_transformed = FALSE,
	transform_cooldown_time = 0 SECONDS,
	force_on = 0,
	throwforce_on = 0,
	throw_speed_on = 2,
	sharpness_on = NONE,
	hitsound_on = 'sound/weapons/blade1.ogg',
	w_class_on = WEIGHT_CLASS_BULKY,
	list/attack_verb_on,
	inhand_icon_change = TRUE,
	_allowed_cells = list(),
	_preload_cell_type = /obj/item/stock_parts/cell,
	_cell_hit_cost = 1000,
	_can_remove_cell = FALSE,
	_no_cell_icon = FALSE
)
	. = ..()

	allowed_cells = _allowed_cells
	preload_cell_type = _preload_cell_type
	cell_hit_cost = _cell_hit_cost
	can_remove_cell = _can_remove_cell
	no_cell_icon = _no_cell_icon

	if(preload_cell_type in allowed_cells)
		cell = new preload_cell_type(parent)

/datum/component/transforming/charged/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_SCREWDRIVER_ACT, PROC_REF(on_screwdriver_act))
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ITEM_USE_CELL, PROC_REF(deduct_charge))

/datum/component/transforming/charged/Destroy(force, silent)
	if(cell)
		QDEL_NULL(cell)
	. = ..()

/datum/component/transforming/charged/on_attack_self(obj/item/source, mob/user)
	if(cell && cell.charge > cell_hit_cost)
		return ..()
	else
		set_inactive(source)
		if(!cell)
			to_chat(user, span_warning("[source] does not have a power source!"))
		else
			to_chat(user, span_warning("[source] is out of charge."))

/datum/component/transforming/charged/proc/on_screwdriver_act(obj/item/source, mob/user, obj/item/screwdriver)
	if(cell && can_remove_cell)
		cell.update_appearance()
		cell.forceMove(get_turf(parent))
		cell = null
		to_chat(user, span_notice("You remove the cell from [parent]."))
		set_inactive(source)
		source.update_appearance()
		return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/transforming/charged/proc/on_attackby(obj/item/source, obj/item/attacking_item, mob/user, params)
	SIGNAL_HANDLER

	if(attacking_item.type in allowed_cells)
		var/obj/item/stock_parts/cell/attacking_cell = attacking_item
		if(cell)
			to_chat(user, span_notice("[parent] already has a cell!"))
		else
			if(attacking_cell.maxcharge < cell_hit_cost)
				to_chat(user, span_notice("[parent] requires a higher capacity cell."))
				return
			if(!user.transferItemToLoc(attacking_item, parent))
				return
			cell = attacking_item
			to_chat(user, span_notice("You install a cell in [parent]."))
			source.update_appearance()
		return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/transforming/charged/proc/on_examine(obj/item/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(cell)
		examine_list += span_notice("\The [source] is [round(cell.percent())]% charged.")
	else
		examine_list += span_warning("\The [source] does not have a power source installed.")

/datum/component/transforming/charged/proc/deduct_charge(obj/item/source)
	SIGNAL_HANDLER
	if(cell)
		. = cell.use(cell_hit_cost)
		if(active && cell.charge < cell_hit_cost)
			playsound(src, SFX_SPARKS, 75, TRUE, -1)
			set_inactive(source)

/datum/component/transforming/charged/proc/set_active_state(active_state = -1)
	switch(active_state)
		//We didnt pass a specific state to set it to so just toggle it
		if(-1)
			toggle_active(parent)
		if(FALSE)
			set_inactive(parent)
		if(TRUE)
			set_active(parent)

/datum/component/transforming/charged/set_inactive(obj/item/source)
	. = ..()
	if(!cell)
		source.icon_state = "[initial(source.icon_state)]_nocell"
		source.item_state = "[initial(source.icon_state)]_nocell"
		source.update_appearance()
